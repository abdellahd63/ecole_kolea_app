import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Presence extends StatefulWidget {
   Presence({super.key});

  @override
  State<Presence> createState() => _PresenceState();
  
}

class _PresenceState extends State<Presence> {
  String qrstr="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.whitecolor,
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
                padding: const EdgeInsets.symmetric(vertical:10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text("Appuyer pour scanner", 
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                        fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical:25.0),
                child: InkWell(
                  child: Container(
                    decoration: BoxDecoration(color: MyAppColors.dimopacityvblue, borderRadius: BorderRadius.circular(20)),
                    child: Icon(Icons.qr_code_scanner, size: 250,)),
                    onTap: (){
                      scanQr();
                    },
                ),
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

  Future<void> scanQr() async {
    try {
      FlutterBarcodeScanner.scanBarcode('#2A99CF', 'Annuler', true, ScanMode.QR)
          .then((value) {
        setState(() {
          qrstr = value;// Invoke the callback function
        });
      });
    } catch (e) {
      qrstr = "essayer à nouveau";
    }
  }
}

