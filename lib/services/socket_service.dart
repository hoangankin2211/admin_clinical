import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../constants/api_link.dart';

class SocketService {
  static IO.Socket socket = IO.io(
    ApiLink.uri,
    IO.OptionBuilder().setTransports(['websocket']).setQuery(
            {'test': UniqueKey().toString()}) // for Flutter or Dart VM
        .build(),
  );

  static void connectSocket() {
    socket.onConnect((data) {
      print(data);
      socket.emit('/test', 'test');
    });

    socket.onConnectError((data) => print(data));
    socket.onDisconnect((data) => print('disconnect,$data'));
  }
}
