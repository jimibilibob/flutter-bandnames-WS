import 'package:flutter/cupertino.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { online, offline, connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;

  get serverStatus => _serverStatus;

  SocketService() {
    _initConfig();
  }

  void _initConfig() {
    // Dart client
    IO.Socket socket = IO.io(
        'http://192.168.100.8:3000',
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect()
            .build());
    socket.onConnect((_) {
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });
    socket.on('event', (data) => print(data));
    socket.onDisconnect((_) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });
    socket.on('fromServer', (_) => print(_));
  }
}
