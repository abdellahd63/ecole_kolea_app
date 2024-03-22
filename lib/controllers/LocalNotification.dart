import 'dart:convert';
import 'package:ecole_kolea_app/Pages/Chat.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static final FlutterLocalNotificationsPlugin
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //init the local notification
  static Future init() async{
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>null);
    final LinuxInitializationSettings initializationSettingsLinux =
    LinuxInitializationSettings(
        defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
        linux: initializationSettingsLinux);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) {
          print('clicked');
          print(details.payload);
          var data = jsonDecode(details.payload.toString());
          //here open the application if is closed and redirect to chat with this params
          // Chat(target: {"id": data['id'], "type": data['type']}, Title: data['title'])
          if (!kIsWeb) {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => Chat(
            //       target: {"id": data['id'], "type": data['type']},
            //       Title: data['title'],
            //     ),
            //   ),
            // );
          }
        });
  }
  static Future showNotification({
    required String title,
    required String body,
    required String payload
  }) async{
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('MessageNotifier', 'Message Notification',
        channelDescription: 'Receive message notifications for target user',
        importance: Importance.max,
        priority: Priority.high);
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.show(
        0, title, body, notificationDetails,
        payload: payload);
  }
}