import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:tabib_app/core/api/api_constant.dart';
import 'dart:async';

import 'package:tabib_app/core/cache_helper/app_local_storage.dart';
import 'package:tabib_app/core/cache_helper/local_keys.dart';

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
  late final IO.Socket _socket;

  final _messageController = StreamController<dynamic>.broadcast();

  Stream<dynamic> get messages => _messageController.stream;

  bool get isConnected => _socket.connected;

  void initializeSocket() async {
    final String accessToken = await AppLocalStorage.getSecuredString(
      key: LocalKeys.token,
    );

    _socket = IO.io(
      EndPoint.socketUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setAuth({'token': accessToken})
          .setPath('/socket.io')
          .enableAutoConnect()
          .build(),
    );

    _socket.onConnect((_) {
      _socket.emit(SocketEvent.join.name);
    });

    _socket.onDisconnect((_) {
      _socket.disconnect();
    });

    _socket.onConnectError((error) {
      //print('Connection error: $error');
    });

    _socket.onError((error) {
      _messageController.add({
        'event': SocketEvent.error.name,
        'data': error,
      });
    });

    _socket.on(SocketEvent.message.name, (data) {
      _messageController.add({
        'event': SocketEvent.message.name,
        'data': data,
      });
    });
  }

  void sendMessage(dynamic message) {
    if (!_socket.connected) return;

    _socket.emit(SocketEvent.sent.name, message);
  }

  void dispose() {
    _socket.dispose();
    _messageController.close();
  }
}
