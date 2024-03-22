import 'dart:convert';

import 'package:ecole_kolea_app/Constant.dart';
import 'package:ecole_kolea_app/Pages/Chat.dart';
import 'package:ecole_kolea_app/controllers/LocalNotification.dart';
import 'package:flutter/src/widgets/overlay.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class SocketController extends GetxController {
  late IO.Socket socket;
  @override
  void onInit() async{
    // Initialize variables or perform other setup operations
    super.onInit();
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    socket = IO.io(Constant.URL, <String,dynamic>{
      "transports":["websocket"],
      "autoConnect": false,
      'force new connection': true,
    });
    socket.connect();
    socket.emit("signin", preferences.getString("id").toString());
    socket.on('notification', (data) {
      LocalNotification.showNotification(
        title: '${data["source"]}',
        body: '${data["msg"]}',
        payload: jsonEncode({
          'id': data["sourceID"],
          'type': data["type"],
          'title': 'title'
        }),
      );
    });

  }
  @override
  void onClose() async{
    // Clean up resources when the controller is closed
    super.onClose();
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    socket.emit("subsignout", preferences.getString("id").toString());
    print('SocketController disconnect');
    socket.disconnect();
  }
}