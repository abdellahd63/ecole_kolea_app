import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Presence extends StatelessWidget {
  const Presence({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text("Scanner ce QR code pour justifier votre présence", 
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: MyAppColors.principalcolor,
                      fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical:35.0),
                child: Icon(Icons.qr_code_scanner, size: 250,),
              ),

               Row(
                children: [
                  Expanded(
                    child: Text("Merci !", 
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: MyAppColors.principalcolor,
                      fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),

            ]),
        ),
      ),
    );
  }
}