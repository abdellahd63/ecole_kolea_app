import 'package:ecole_kolea_app/Componants/MyButton.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Pages/ConnectedHomePage.dart';
import 'package:ecole_kolea_app/Pages/Presence.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class Success extends StatelessWidget {
  const Success({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal:20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('lib/animations/success.json'),
            Center(child: Text(message.toString(),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: MyAppColors.principalcolor
              ),
              textAlign: TextAlign.center,
            )),
            SizedBox(height: 100),
            Center(
              child: InkWell(child: MyButton(buttontext: 'Merci' ),onTap: (){
                Navigator.pop(context,true);
              },),
            )
          ],
        ),
      ),
    );
  }
}