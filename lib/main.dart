
import 'dart:convert';

import 'package:ecole_kolea_app/Constant.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Pages/ConnectedHomePage.dart';
import 'package:ecole_kolea_app/Pages/DeconnectedHomepage.dart';
import 'package:ecole_kolea_app/controllers/LocalNotification.dart';
import 'package:ecole_kolea_app/controllers/SocketController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  await LocalNotification.init();
  final SocketController socketController = Get.put(SocketController());
  runApp(
      MyApp(token: preferences.getString("token"))
  );
}
class MyApp extends StatelessWidget {
  final token;
  const MyApp({super.key, required this.token});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecole De Kolea',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MyAppColors.principalcolor),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: (token != null && JwtDecoder.isExpired(token) == false) ? ConnectedHomePage() : DeconnectedHomePage(),
    );
  }
}
