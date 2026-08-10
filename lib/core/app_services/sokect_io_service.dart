import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum SocketEvent {
  join,
  message,
  sent,
  delivered,
  read,
  deleted,
  typing,
  readAll,
  error,
}




class SocketIoService {
  static const String baseUrl = 'https://tabeeb.nodeteam.site';
  



  final String token;
  late final IO.Socket _socket;

  static SocketIoService? _instance;




  // Connection status getter
  bool get isConnected => _socket.connected;

  SocketIoService._internal({required this.token});



factory SocketIoService({required String token}) {
    _instance ??= SocketIoService._internal(token: token);
    return _instance!;
  }

  // 4. Global getter if you want to access it later without passing the token again
  static SocketIoService get instance {
    assert(_instance != null, "SocketIoService has not been initialized yet!");
    return _instance!;
  }







  // Callbacks
  VoidCallback? onConnect;
  VoidCallback? onDisconnect;
  void Function(dynamic error)? onError;
  void Function(Map<String, dynamic> payload)? onJoined;
  void Function(Map<String, dynamic> message)? onMessage;
  void Function(Map<String, dynamic> message)? onMessageSent;
  void Function(Map<String, dynamic> payload)? onMessageDelivered;
  void Function(Map<String, dynamic> payload)? onTyping;
  void Function(Map<String, dynamic> payload)? onRead;
  void Function(Map<String, dynamic> payload)? onReadAlled;

  /// Establishes the socket connection and registers event listeners for Tabeeb Chat Flow
 void connect() {
    try {
      _socket = IO.io(
        baseUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .setAuth({'token': token})
            .setPath('/socket.io')
            .enableAutoConnect()
            .enableReconnection()
            .build(),
      );

      _registerListeners();
    } catch (e) {
      
      onError?.call(e.toString());
    }
  }

  void _registerListeners() {
    _socket.onConnect((data) {
      if (kDebugMode) log('Socket Connected: ${_socket.id}');
      onConnect?.call();
    });

    _socket.onDisconnect((data) {
      if (kDebugMode) log('Socket Disconnected');
      onDisconnect?.call();
    });

    _socket.onConnectError((error) {
      
      if (kDebugMode) log('Socket Connect Error: $error');
      onError?.call(error);
    });

    _socket.onError((error) {
      if (kDebugMode) log('Socket Error: $error');
      onError?.call(error);
    });

    // --- Chat Specific Listeners ---

    // Confirmation that the client entered the consultation room[cite: 1]
    _socket.on('chat:joined', (payload) {
      if (payload is Map) {
        onJoined?.call(Map<String, dynamic>.from(payload));
      }
    });

    // Confirmation for the sender that the message was saved[cite: 1]
    _socket.on('chat:sent', (message) {
      if (message is Map) {
        onMessageSent?.call(Map<String, dynamic>.from(message));
      }
    });

    // Incoming messages from the other participant[cite: 1]
    _socket.on('chat:message', (message) {
      if (message is Map) {
        onMessage?.call(Map<String, dynamic>.from(message));
      }
    });

    // Message delivery notifications[cite: 1]
    _socket.on('chat:delivered', (payload) {
      if (payload is Map) {
        onMessageDelivered?.call(Map<String, dynamic>.from(payload));
      }
    });

    // Typing indicators[cite: 1]
    _socket.on('chat:typing', (payload) {
      if (payload is Map) {
        onTyping?.call(Map<String, dynamic>.from(payload));
      }
    });

    // Single read receipts[cite: 1]
    _socket.on('chat:read', (payload) {
      if (payload is Map) {
        onRead?.call(Map<String, dynamic>.from(payload));
      }
    });

    // Read-all receipts[cite: 1]
    _socket.on('chat:readAll', (payload) {
      if (payload is Map) {
        onReadAlled?.call(Map<String, dynamic>.from(payload));
      }
    });

    // Backend error notifications[cite: 1]
    _socket.on('chat:error', (error) {
      onError?.call(error);
    });
  }

  /// --- Chat Emitters ---

  /// Joins a specific consultation chat room[cite: 1]
  void joinChat(String consultationId) {
    _emit('chat:join', {'consultationId': consultationId});
  }

  /// Sends a text message or a file message payload[cite: 1]
  void sendMessage({required String consultationId, required String content, String? fileUrl}) {
    final payload = <String, dynamic>{
      'consultationId': consultationId,
      'content': content,
    };
    if (fileUrl != null) {
      payload['fileUrl'] = fileUrl;
    }
    _emit('chat:message', payload);
  }

  /// Emits a typing state indicator[cite: 1]
  void sendTyping({required String consultationId, required bool isTyping}) {
    _emit('chat:typing', {
      'consultationId': consultationId,
      'isTyping': isTyping,
    });
  }

  /// Marks a single message as read[cite: 1]
  void markAsRead({required String consultationId, required String messageId}) {
    _emit('chat:read', {
      'consultationId': consultationId,
      'messageId': messageId,
    });
  }

  /// Marks all messages within the consultation as read[cite: 1]
  void markAllAsRead(String consultationId) {
    _emit('chat:readAll', {'consultationId': consultationId});
  }

  void _emit(String event, dynamic data) {
    if (_socket.connected) {
      _socket.emit(event, data);
    } else {
      if (kDebugMode) print('Attempted to emit "$event" while socket was disconnected.');
    }
  }

  /// Updates the authentication token dynamically (useful during token refreshes)
  void updateToken(String newToken) {
    _socket.auth = {'token': newToken};
  }

  /// Disconnects and cleans up socket listeners safely[cite: 1]
  void disconnect() {
    try {
      _socket.clearListeners();
      _socket.disconnect();
      _socket.dispose();
      _instance = null;
    } catch (e) {
      onError?.call(e.toString());
    }
  }
}