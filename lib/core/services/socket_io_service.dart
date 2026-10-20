import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:tabib_app/core/api/api_constant.dart';
import 'package:tabib_app/core/cache_helper/app_local_storage.dart';
import 'package:tabib_app/core/cache_helper/local_keys.dart';

@lazySingleton
class SocketIoService {
  SocketIoService();

  io.Socket? _socket;
  final Set<String> _consultationIds = {};
  final List<void Function(String event, Map<String, dynamic> data)>
  _eventListeners = [];
  final List<void Function()> _connectListeners = [];
  bool _trackingListenersAttached = false;
  bool _connecting = false;

  static const List<String> _trackingEvents = [
    'chat:joined',
    'chat:sent',
    'chat:message',
    'chat:typing',
    'chat:read',
    'chat:readAll',
    'chat:delivered',
    'chat:error',
  ];

  bool get isConnected => _socket?.connected == true;

  /// Connects with `auth.token`. Pass [accessToken] or falls back to secure storage.
  ///
  /// Native `socket_io_client` 3.x always opens a WebSocket. Listing `polling`
  /// first makes that request use `transport=polling`, so the server never
  /// sends the Engine.IO open packet and the client times out.
  Future<void> connect({String? accessToken}) async {
    if (isConnected || _connecting) return;
    _connecting = true;

    final token =
        accessToken ??
        await AppLocalStorage.getSecuredString(key: LocalKeys.token);

    if (!_connecting) return;

    if (token.isEmpty) {
      _connecting = false;
      log('Socket connect skipped: missing token');
      return;
    }

    final previous = _socket;
    _socket = null;
    previous?.dispose();
    _trackingListenersAttached = false;

    final socket = io.io(
      EndPoint.socketUrl,
      io.OptionBuilder()
          .setPath('/socket.io')
          .setTransports(['websocket'])
          .setAuth({'token': token})
          .enableAutoConnect()
          .enableForceNew()
          .build(),
    );
    _socket = socket;

    socket.onConnect((_) {
      if (!identical(socket, _socket)) return;
      _connecting = false;
      for (final consultationId in _consultationIds) {
        _emitJoin(consultationId);
      }
      for (final listener in List.of(_connectListeners)) {
        listener();
      }
      log('Socket connected: ${socket.id}');
    });

    socket.onConnectError((error) {
      if (!identical(socket, _socket)) return;
      _connecting = false;
      log('Socket connection error: $error');
    });

    socket.onDisconnect((reason) {
      if (!identical(socket, _socket)) return;
      _connecting = false;
      log('Socket disconnected: $reason');
    });

    socket.onError((error) {
      log('Socket error: $error');
    });

    _attachTrackingListeners();
  }

  /// Joins a consultation room. The room is joined again after every reconnect.
  void join(String consultationId) {
    _consultationIds.add(consultationId);
    if (isConnected) _emitJoin(consultationId);
  }

  /// Emits `chat:message`. File fields are sent only when a file was uploaded first.
  void sendMessage({
    required String consultationId,
    required String content,
    String? fileUrl,
    String? fileType,
    String? fileName,
    int? fileSize,
  }) {
    final payload = <String, dynamic>{
      'consultationId': consultationId,
      'content': content,
    };
    if (fileUrl != null) payload['fileUrl'] = fileUrl;
    if (fileType != null) payload['fileType'] = fileType;
    if (fileName != null) payload['fileName'] = fileName;
    if (fileSize != null) payload['fileSize'] = fileSize;
    _socket?.emit('chat:message', payload);
  }

  void setTyping({required String consultationId, required bool isTyping}) {
    _socket?.emit('chat:typing', {
      'consultationId': consultationId,
      'isTyping': isTyping,
    });
  }

  void markRead({required String consultationId, required String messageId}) {
    _socket?.emit('chat:read', {
      'consultationId': consultationId,
      'messageId': messageId,
    });
  }

  void markReadAll({required String consultationId}) {
    _socket?.emit('chat:readAll', {'consultationId': consultationId});
  }

  /// Called on every connect, including reconnect, after rooms are re-joined.
  void addConnectListener(void Function() listener) {
    _connectListeners.add(listener);
  }

  void removeConnectListener(void Function() listener) {
    _connectListeners.remove(listener);
  }

  /// Registers a handler for chat events. Safe to call before [connect].
  void listen(void Function(String event, Map<String, dynamic> data) onEvent) {
    _eventListeners.add(onEvent);
    if (_socket != null && !_trackingListenersAttached) {
      _attachTrackingListeners();
    }
  }

  void unlisten(
    void Function(String event, Map<String, dynamic> data) onEvent,
  ) {
    _eventListeners.remove(onEvent);
  }

  void onError(void Function(dynamic error) callback) {
    _socket?.onError(callback);
    _socket?.onConnectError(callback);
  }

  void _attachTrackingListeners() {
    if (_socket == null || _trackingListenersAttached) return;
    _trackingListenersAttached = true;

    for (final event in _trackingEvents) {
      _socket!.on(event, (dynamic raw) {
        if (raw is! Map) {
          log('Socket event $event ignored: $raw');
          return;
        }
        final data = Map<String, dynamic>.from(raw);
        for (final listener in List.of(_eventListeners)) {
          listener(event, data);
        }
      });
    }
  }

  void _emitJoin(String consultationId) {
    _socket?.emit('chat:join', {'consultationId': consultationId});
  }

  /// Call on logout. Clears joined consultations and tears down the socket.
  void dispose() {
    _consultationIds.clear();
    _eventListeners.clear();
    _connectListeners.clear();
    _trackingListenersAttached = false;
    _connecting = false;
    final socket = _socket;
    _socket = null;
    socket?.dispose();
    log('Socket disposed');
  }
}
