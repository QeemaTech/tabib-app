import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/app_services/sokect_io_service.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/core/cache_helper/app_local_storage.dart';
import 'package:tabib_app/core/cache_helper/local_keys.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/chat/domain/entities/message_entity.dart';
import 'package:tabib_app/features/chat/domain/entities/messages_page_entity.dart';
import 'package:tabib_app/features/chat/domain/repo/chat_repo.dart';
import 'package:tabib_app/features/chat/presentation/view_model/chat_details_state.dart';

@injectable
class ChatDetailsViewModel extends Cubit<ChatDetailsState> {
  ChatDetailsViewModel({required this.chatRepo})
      : super(const ChatDetailsState());

  final ChatRepo chatRepo;

  String _currentRole = '';
  String? _pendingTempId;
  Timer? _typingDebounce;
  Timer? _peerTypingClearTimer;
  bool _isLocalTyping = false;

  Future<void> init({
    required String consultationId,
    String participantTitle = '',
    String avatarUrl = '',
  }) async {
    if (consultationId.isEmpty) {
      emit(
        state.copyWith(
          historyState: BaseState.error('Missing consultation id'),
          errorMessage: 'Missing consultation id',
          canSend: false,
        ),
      );
      return;
    }

    _currentRole = MessageEntity.normalizeRole(
      await AppLocalStorage.getSecuredString(key: LocalKeys.role),
    );

    emit(
      state.copyWith(
        consultationId: consultationId,
        participantTitle: participantTitle,
        avatarUrl: avatarUrl,
        historyState: BaseState.loading(),
        messages: const [],
        hasMore: false,
        clearNextBefore: true,
        clearError: true,
      ),
    );

    await _loadHistory(consultationId: consultationId);
    _connectSocket(consultationId);
  }

  Future<void> retryHistory() async {
    if (state.consultationId.isEmpty) return;
    emit(state.copyWith(historyState: BaseState.loading(), clearError: true));
    await _loadHistory(consultationId: state.consultationId);
    _connectSocket(state.consultationId);
  }

  Future<void> loadOlderMessages() async {
    if (!state.hasMore ||
        state.isLoadingMore ||
        state.nextBefore == null ||
        state.nextBefore!.isEmpty ||
        state.consultationId.isEmpty) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));
    final result = await chatRepo.getMessages(
      consultationId: state.consultationId,
      currentRole: _currentRole,
      before: state.nextBefore,
    );

    switch (result) {
      case Success<MessagesPageEntity>():
        final older = result.data.messages;
        final merged = _dedupeById([...older, ...state.messages]);
        emit(
          state.copyWith(
            messages: merged,
            hasMore: result.data.hasMore,
            nextBefore: result.data.nextBefore,
            clearNextBefore: result.data.nextBefore == null,
            isLoadingMore: false,
          ),
        );
      case Failure<MessagesPageEntity>():
        emit(
          state.copyWith(
            isLoadingMore: false,
            errorMessage: result.errorMessage,
          ),
        );
    }
  }

  Future<void> _loadHistory({required String consultationId}) async {
    final result = await chatRepo.getMessages(
      consultationId: consultationId,
      currentRole: _currentRole,
    );

    switch (result) {
      case Success<MessagesPageEntity>():
        emit(
          state.copyWith(
            historyState: BaseState.loaded(true),
            messages: result.data.messages,
            hasMore: result.data.hasMore,
            nextBefore: result.data.nextBefore,
            clearNextBefore: result.data.nextBefore == null,
          ),
        );
      case Failure<MessagesPageEntity>():
        emit(
          state.copyWith(
            historyState: BaseState.error(result.errorMessage),
            errorMessage: result.errorMessage,
          ),
        );
    }
  }

  void _connectSocket(String consultationId) {
    if (!SocketIoService.isInitialized) {
      emit(
        state.copyWith(
          isConnected: false,
          canSend: false,
          errorMessage: state.errorMessage ?? 'Socket not connected',
        ),
      );
      return;
    }

    final socket = SocketIoService.instance;
    _wireSocketCallbacks(socket);
    socket.setActiveConsultation(consultationId);
    final connected = socket.isConnected;
    emit(
      state.copyWith(
        isConnected: connected,
        isJoined: false,
        canSend: false,
      ),
    );
    if (connected) {
      socket.joinChat(consultationId);
    }
  }

  void sendMessage(String content) {
    final trimmed = content.trim();
    if (trimmed.isEmpty) return;
    if (!state.canSend || !SocketIoService.isInitialized) {
      emit(state.copyWith(errorMessage: 'Not connected to chat'));
      return;
    }

    final tempId = 'temp-${DateTime.now().microsecondsSinceEpoch}';
    _pendingTempId = tempId;
    final pending = MessageEntity.pending(
      tempId: tempId,
      content: trimmed,
      currentRole: _currentRole,
    );

    emit(state.copyWith(messages: [...state.messages, pending], clearError: true));

    _setLocalTyping(false);
    SocketIoService.instance.sendMessage(
      consultationId: state.consultationId,
      content: trimmed,
    );
  }

  void onComposerChanged(String text) {
    final shouldType = text.trim().isNotEmpty;
    _typingDebounce?.cancel();
    _typingDebounce = Timer(const Duration(milliseconds: 400), () {
      _setLocalTyping(shouldType);
    });
  }

  void clearError() {
    emit(state.copyWith(clearError: true));
  }

  void _setLocalTyping(bool isTyping) {
    if (!SocketIoService.isInitialized || state.consultationId.isEmpty) return;
    if (_isLocalTyping == isTyping) return;
    _isLocalTyping = isTyping;
    SocketIoService.instance.sendTyping(
      consultationId: state.consultationId,
      isTyping: isTyping,
    );
  }

  void _wireSocketCallbacks(SocketIoService socket) {
    socket.onConnect = () {
      if (isClosed) return;
      emit(
        state.copyWith(
          isConnected: true,
          isJoined: false,
          canSend: false,
          clearError: true,
        ),
      );
    };

    socket.onDisconnect = () {
      if (isClosed) return;
      emit(
        state.copyWith(
          isConnected: false,
          isJoined: false,
          canSend: false,
          isPeerTyping: false,
        ),
      );
    };

    socket.onJoined = (_) {
      if (isClosed) return;
      emit(
        state.copyWith(
          isJoined: true,
          isConnected: true,
          canSend: true,
          clearError: true,
        ),
      );
      socket.markAllAsRead(state.consultationId);
    };

    socket.onMessageSent = (payload) {
      if (isClosed) return;
      final message = MessageEntity.fromSocketMap(
        payload,
        currentRole: _currentRole,
      );
      final updated = _replacePendingOrUpsert(message);
      emit(state.copyWith(messages: updated, clearError: true));
      _pendingTempId = null;
    };

    socket.onMessage = (payload) {
      if (isClosed) return;
      final message = MessageEntity.fromSocketMap(
        payload,
        currentRole: _currentRole,
      );
      if (message.isMine) return;
      emit(
        state.copyWith(
          messages: _upsertMessage(state.messages, message),
          isPeerTyping: false,
          clearError: true,
        ),
      );
      if (message.id.isNotEmpty) {
        socket.markAsRead(
          consultationId: state.consultationId,
          messageId: message.id,
        );
      }
    };

    socket.onMessageDelivered = (payload) {
      if (isClosed) return;
      final messageId = payload['messageId'] as String?;
      if (messageId == null || messageId.isEmpty) return;
      emit(
        state.copyWith(
          messages: state.messages
              .map(
                (m) => m.id == messageId
                    ? m.copyWith(status: 'DELIVERED')
                    : m,
              )
              .toList(),
        ),
      );
    };

    socket.onTyping = (payload) {
      if (isClosed) return;
      final consultationId = payload['consultationId'] as String?;
      if (consultationId != null &&
          consultationId.isNotEmpty &&
          consultationId != state.consultationId) {
        return;
      }
      final isTyping = payload['isTyping'] == true;
      _peerTypingClearTimer?.cancel();
      emit(state.copyWith(isPeerTyping: isTyping));
      if (isTyping) {
        _peerTypingClearTimer = Timer(const Duration(seconds: 3), () {
          if (!isClosed) {
            emit(state.copyWith(isPeerTyping: false));
          }
        });
      }
    };

    socket.onRead = (payload) {
      if (isClosed) return;
      final messageId = payload['messageId'] as String?;
      if (messageId == null || messageId.isEmpty) return;
      final readAt = payload['readAt'] as String?;
      emit(
        state.copyWith(
          messages: state.messages
              .map(
                (m) => m.id == messageId
                    ? m.copyWith(
                        isRead: true,
                        readAt: readAt ?? m.readAt,
                        status: 'READ',
                      )
                    : m,
              )
              .toList(),
        ),
      );
    };

    socket.onReadAll = (_) {
      if (isClosed) return;
      emit(
        state.copyWith(
          messages: state.messages
              .map(
                (m) => m.isMine
                    ? m.copyWith(isRead: true, status: 'READ')
                    : m,
              )
              .toList(),
        ),
      );
    };

    socket.onError = (error) {
      if (isClosed) return;
      final message = _errorToMessage(error);
      emit(state.copyWith(errorMessage: message));
    };
  }

  List<MessageEntity> _replacePendingOrUpsert(MessageEntity message) {
    final messages = List<MessageEntity>.from(state.messages);
    if (_pendingTempId != null) {
      final index = messages.indexWhere((m) => m.id == _pendingTempId);
      if (index != -1) {
        messages[index] = message;
        return _dedupeById(messages);
      }
    }
    return _upsertMessage(messages, message);
  }

  List<MessageEntity> _upsertMessage(
    List<MessageEntity> current,
    MessageEntity message,
  ) {
    if (message.id.isEmpty) return [...current, message];
    final index = current.indexWhere((m) => m.id == message.id);
    if (index == -1) return [...current, message];
    final updated = List<MessageEntity>.from(current);
    updated[index] = message;
    return updated;
  }

  List<MessageEntity> _dedupeById(List<MessageEntity> messages) {
    final seen = <String>{};
    final result = <MessageEntity>[];
    for (final message in messages.reversed) {
      if (message.id.isNotEmpty && !seen.add(message.id)) continue;
      result.add(message);
    }
    return result.reversed.toList();
  }

  String _errorToMessage(dynamic error) {
    if (error is Map) {
      final code = error['code'];
      final message = error['message'];
      if (code == 'UNAUTHORIZED') {
        return message?.toString() ?? 'Unauthorized';
      }
      return message?.toString() ?? error.toString();
    }
    return error.toString();
  }

  @override
  Future<void> close() {
    _typingDebounce?.cancel();
    _peerTypingClearTimer?.cancel();
    _setLocalTyping(false);
    if (SocketIoService.isInitialized) {
      final socket = SocketIoService.instance;
      socket.clearActiveConsultation();
      socket.clearCallbacks();
    }
    return super.close();
  }
}
