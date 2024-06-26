
import 'dart:io';

import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Pages/ConnectedHomePage.dart';
import 'package:ecole_kolea_app/Pages/DeconnectedHomepage.dart';
import 'package:ecole_kolea_app/controllers/LocalNotification.dart';
import 'package:ecole_kolea_app/controllers/Searching.dart';
import 'package:ecole_kolea_app/controllers/SocketController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  await LocalNotification.init();
  HttpOverrides.global = new MyHttpOverrides();
  runApp(
      MyApp(token: preferences.getString("token"))
  );
}
class MyApp extends StatelessWidget {
  final token;
  const MyApp({super.key, required this.token});
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
