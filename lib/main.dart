import 'package:ecole_kolea_app/Auth/AuthContextProvider.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Pages/DeconnectedHomepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
      AuthContextProvider(
        child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: DeconnectedHomePage(),
    );
  }
}
