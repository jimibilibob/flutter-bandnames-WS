import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  final IO.Socket _socket = IO.io(
      'https://flutter-ws-server.herokuapp.com/',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .build());

  ServerStatus get serverStatus => _serverStatus;

  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;

  SocketService() {
    _initConfig();
  }

  void _initConfig() {
    // Dart client
    try {
      _socket.connect();
      print('TRYING TO CONNECT!!');
      _socket.on('connect', (_) {
        print('CONECTED!!');
        _serverStatus = ServerStatus.Online;
        notifyListeners();
      });

      _socket.on('disconnect', (_) {
        print('DISCONNECTED!!');
        _serverStatus = ServerStatus.Offline;
        notifyListeners();
      });
    } catch (e) {
      print('ERROR $e');
    }
  }
}
