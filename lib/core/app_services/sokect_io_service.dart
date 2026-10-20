import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketIoService {
  static const String baseUrl = 'https://tabeeb.nodeteam.site';

  final String token;
  IO.Socket? _socket;
  String? _activeConsultationId;

  static SocketIoService? _instance;

  bool get isConnected => _socket?.connected ?? false;

  String? get activeConsultationId => _activeConsultationId;

  SocketIoService._internal({required this.token});

  factory SocketIoService({required String token}) {
    _instance ??= SocketIoService._internal(token: token);
    return _instance!;
  }

  static SocketIoService get instance {
    assert(_instance != null, 'SocketIoService has not been initialized yet!');
    return _instance!;
  }

  static bool get isInitialized => _instance != null;

  VoidCallback? onConnect;
  VoidCallback? onDisconnect;
  void Function(dynamic error)? onError;
  void Function(Map<String, dynamic> payload)? onJoined;
  void Function(Map<String, dynamic> message)? onMessage;
  void Function(Map<String, dynamic> message)? onMessageSent;
  void Function(Map<String, dynamic> payload)? onMessageDelivered;
  void Function(Map<String, dynamic> payload)? onTyping;
  void Function(Map<String, dynamic> payload)? onRead;
  void Function(Map<String, dynamic> payload)? onReadAll;

  void connect() {
    try {
      _socket = IO.io(
        baseUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .setAuth({'token': token})
            .setPath('/socket.io')
            .enableForceNew()
            .enableAutoConnect()
            .enableReconnection()
            .build(),
      );

      _registerListeners();
    } catch (e) {
      onError?.call(e.toString());
    }
  }

  void setActiveConsultation(String consultationId) {
    _activeConsultationId = consultationId;
  }

  void clearActiveConsultation() {
    _activeConsultationId = null;
  }

  void clearCallbacks() {
    onConnect = null;
    onDisconnect = null;
    onError = null;
    onJoined = null;
    onMessage = null;
    onMessageSent = null;
    onMessageDelivered = null;
    onTyping = null;
    onRead = null;
    onReadAll = null;
  }

  void _registerListeners() {
    final socket = _socket;
    if (socket == null) return;

    socket.onConnect((_) {
      if (kDebugMode) log('Socket Connected: ${socket.id}');
      final consultationId = _activeConsultationId;
      if (consultationId != null && consultationId.isNotEmpty) {
        joinChat(consultationId);
      }
      onConnect?.call();
    });

    socket.onDisconnect((_) {
      if (kDebugMode) log('Socket Disconnected');
      onDisconnect?.call();
    });

    socket.onConnectError((error) {
      if (kDebugMode) log('Socket Connect Error: $error');
      onError?.call(error);
    });

    socket.onError((error) {
      if (kDebugMode) log('Socket Error: $error');
      onError?.call(error);
    });

    socket.on('chat:joined', (payload) {
      if (payload is Map) {
        onJoined?.call(Map<String, dynamic>.from(payload));
      }
    });

    socket.on('chat:sent', (message) {
      if (message is Map) {
        onMessageSent?.call(Map<String, dynamic>.from(message));
      }
    });

    socket.on('chat:message', (message) {
      if (message is Map) {
        onMessage?.call(Map<String, dynamic>.from(message));
      }
    });

    socket.on('chat:delivered', (payload) {
      if (payload is Map) {
        onMessageDelivered?.call(Map<String, dynamic>.from(payload));
      }
    });

    socket.on('chat:typing', (payload) {
      if (payload is Map) {
        onTyping?.call(Map<String, dynamic>.from(payload));
      }
    });

    socket.on('chat:read', (payload) {
      if (payload is Map) {
        onRead?.call(Map<String, dynamic>.from(payload));
      }
    });

    socket.on('chat:readAll', (payload) {
      if (payload is Map) {
        onReadAll?.call(Map<String, dynamic>.from(payload));
      }
    });

    socket.on('chat:error', (error) {
      onError?.call(error);
    });
  }

  void joinChat(String consultationId) {
    _emit('chat:join', {'consultationId': consultationId});
  }

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
    _emit('chat:message', payload);
  }

  void sendTyping({required String consultationId, required bool isTyping}) {
    _emit('chat:typing', {
      'consultationId': consultationId,
      'isTyping': isTyping,
    });
  }

  void markAsRead({required String consultationId, required String messageId}) {
    _emit('chat:read', {
      'consultationId': consultationId,
      'messageId': messageId,
    });
  }

  void markAllAsRead(String consultationId) {
    _emit('chat:readAll', {'consultationId': consultationId});
  }

  void _emit(String event, dynamic data) {
    final socket = _socket;
    if (socket != null && socket.connected) {
      socket.emit(event, data);
    } else if (kDebugMode) {
      log('Attempted to emit "$event" while socket was disconnected.');
    }
  }

  void updateToken(String newToken) {
    _socket?.auth = {'token': newToken};
  }

  void disconnect() {
    try {
      clearActiveConsultation();
      clearCallbacks();
      _socket?.clearListeners();
      _socket?.disconnect();
      _socket?.dispose();
      _socket = null;
      _instance = null;
    } catch (e) {
      onError?.call(e.toString());
    }
  }
}
