import 'dart:convert';

import 'package:ecole_kolea_app/Constant.dart';
import 'package:ecole_kolea_app/Pages/Chat.dart';
import 'package:ecole_kolea_app/controllers/LocalNotification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/overlay.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class SocketController extends GetxController {
  void Start() async{
    WidgetsFlutterBinding.ensureInitialized();
    final service = FlutterBackgroundService();
    service.onDataReceived.listen((event) { 
      if(event!['action'] == 'stopService'){
        service.stopBackgroundService();
      }
    });
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    late IO.Socket socket;
    socket = IO.io(Constant.URL, <String,dynamic>{
      "transports":["websocket"],
      "autoConnect": false,
      'force new connection': true,
    });
    socket.connect();
    socket.emit("signin",
        preferences.getString("id").toString()
        + preferences.getString("type").toString()
    );
    socket.on('notification', (data) {
      print(data);
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
  void onInit() async{
    // Initialize variables or perform other setup operations
    super.onInit();
    WidgetsFlutterBinding.ensureInitialized();
    Start();
    FlutterBackgroundService.initialize(Start);

    bool run = await FlutterBackgroundService().isServiceRunning();
    print('isServiceRunning '+ run.toString());
    FlutterBackgroundService().onDataReceived.listen((event) {
      print('Received data');
      if(event!.isNotEmpty){
        print(event);
        // LocalNotification.showNotification(
        //   title: '${event["source"]}',
        //   body: '${event["msg"]}',
        //   payload: jsonEncode({
        //     'id': event["sourceID"],
        //     'type': event["type"],
        //     'title': 'title'
        //   }),
        // );
      }
    });
  }

  @override
  void onClose() async{
    // Clean up resources when the controller is closed
    super.onClose();
    //final SharedPreferences preferences = await SharedPreferences.getInstance();
    // socket.emit("subsignout",
    //        preferences.getString("id").toString()
    //         + preferences.getString("type").toString()
    // );
    // print('SocketController disconnect');
    // socket.disconnect();
  }
}