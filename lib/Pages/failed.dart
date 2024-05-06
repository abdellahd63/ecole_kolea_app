import 'package:ecole_kolea_app/Componants/MyButton.dart';
import 'package:ecole_kolea_app/Pages/Presence.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Failed extends StatelessWidget {
  const Failed({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset('lib/animations/info.json'),
            ),
            Center(
                child: Text(
                  message.toString(),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.red
                  ),
                  textAlign: TextAlign.center,
                )
            ),
            SizedBox(height: 20),
            InkWell(
              child: MyButton(buttontext: 'retourner' ),
              onTap: (){
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Presence()),
                      (Route<dynamic> route) => false,
                );
              },
            )

          ],
        ),
      ),
    );
  }
}