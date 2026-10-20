import 'package:equatable/equatable.dart';
import 'package:tabib_app/core/base_state/base_state.dart';
import 'package:tabib_app/features/chat/domain/entities/message_entity.dart';

class ChatDetailsState extends Equatable {
  final String consultationId;
  final String participantTitle;
  final List<MessageEntity> messages;
  final BaseState<bool> historyState;
  final bool isJoined;
  final bool isConnected;
  final bool isPeerTyping;
  final bool canSend;
  final bool hasMore;
  final String? nextBefore;
  final bool isLoadingMore;
  final String? errorMessage;

  const ChatDetailsState({
    this.consultationId = '',
    this.participantTitle = '',
    this.messages = const [],
    this.historyState = const BaseState(requestState: RequestState.init),
    this.isJoined = false,
    this.isConnected = false,
    this.isPeerTyping = false,
    this.canSend = false,
    this.hasMore = false,
    this.nextBefore,
    this.isLoadingMore = false,
    this.errorMessage,
  });

  ChatDetailsState copyWith({
    String? consultationId,
    String? participantTitle,
    List<MessageEntity>? messages,
    BaseState<bool>? historyState,
    bool? isJoined,
    bool? isConnected,
    bool? isPeerTyping,
    bool? canSend,
    bool? hasMore,
    String? nextBefore,
    bool clearNextBefore = false,
    bool? isLoadingMore,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ChatDetailsState(
      consultationId: consultationId ?? this.consultationId,
      participantTitle: participantTitle ?? this.participantTitle,
      messages: messages ?? this.messages,
      historyState: historyState ?? this.historyState,
      isJoined: isJoined ?? this.isJoined,
      isConnected: isConnected ?? this.isConnected,
      isPeerTyping: isPeerTyping ?? this.isPeerTyping,
      canSend: canSend ?? this.canSend,
      hasMore: hasMore ?? this.hasMore,
      nextBefore: clearNextBefore ? null : (nextBefore ?? this.nextBefore),
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        consultationId,
        participantTitle,
        messages,
        historyState,
        isJoined,
        isConnected,
        isPeerTyping,
        canSend,
        hasMore,
        nextBefore,
        isLoadingMore,
        errorMessage,
      ];
}
