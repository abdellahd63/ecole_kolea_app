import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.whitecolor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child:SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('lib/Assets/Images/logo.png'),
      
                Text("Si vous avez la moindre des choses \n N’hésitez pas a nous contacter", 
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: MyAppColors.black,
                    fontSize: 16,
                    
                    
                  ),
                ),

                SizedBox(height: 30,),

                Divider(height: 2, color: MyAppColors.gray400,),

                SizedBox(height: 20,),


                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal : 10),
                        padding: EdgeInsets.symmetric(horizontal : 25, vertical: 25),
                        decoration: BoxDecoration(
                          color: MyAppColors.dimopacityvblue,
                          borderRadius: BorderRadius.circular(10),
                          
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_on, color: MyAppColors.principalcolor,size: 40,),
                            SizedBox(height: 10,),
                            Text("Ecole supérieure de gestion et d’économie numérique – Pole universitaire – Koléa", 
                              textAlign: TextAlign.center,
                              softWrap: true,
                              maxLines: 5,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: MyAppColors.black,
                                fontSize: 14,),
                            ),
                            SizedBox(height: 10,),
                            InkWell(
                              onTap: (){
                                 MapsLauncher.launchQuery("Ecole Supérieure de Gestion et D’Économie Numérique");
                              },
                              child: Text("Ouvrir map", 
                                textAlign: TextAlign.center,
                                softWrap: true,
                                maxLines: 5,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: MyAppColors.principalcolor,
                                  fontSize: 14,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
      

                SizedBox(height: 20,),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal : 10),
                        padding: EdgeInsets.symmetric(horizontal : 25, vertical: 25),
                        decoration: BoxDecoration(
                          color: MyAppColors.dimopacityvblue,
                          borderRadius: BorderRadius.circular(10),
                          
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.mail, color: MyAppColors.principalcolor,size: 40,),
                            SizedBox(height: 10,),
                            Text("contact@esgen.edu.dz", 
                              textAlign: TextAlign.center,
                              softWrap: true,
                              maxLines: 5,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: MyAppColors.black,
                                fontSize: 14,),
                            ),
                            SizedBox(height: 10,),
                            InkWell(
                              onTap: (){
                                Clipboard.setData(ClipboardData(text: "contact@esgen.edu.dz")).then(
                                  (result) {
                                    final snackBar = SnackBar(
                                      content: Text('Email copié dans le presse-papier'),
                                      action: SnackBarAction(
                                        label: 'Merci',
                                        onPressed: () {},
                                      ),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                   }
                                );
                              },
                              child: Text("Copier", 
                                textAlign: TextAlign.center,
                                softWrap: true,
                                maxLines: 5,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: MyAppColors.principalcolor,
                                  fontSize: 14,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),


                SizedBox(height: 20,),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal : 10),
                        padding: EdgeInsets.symmetric(horizontal : 25, vertical: 25),
                        decoration: BoxDecoration(
                          color: MyAppColors.dimopacityvblue,
                          borderRadius: BorderRadius.circular(10),
                          
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(CupertinoIcons.phone_fill, color: MyAppColors.principalcolor,size: 40,),
                            SizedBox(height: 10,),
                            Text("024 38 01 08", 
                              textAlign: TextAlign.center,
                              softWrap: true,
                              maxLines: 5,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: MyAppColors.black,
                                fontSize: 14,),
                            ),
                            SizedBox(height: 10,),
                            InkWell(
                              onTap: (){
                                launch('tel://024 38 01 08');
                              },
                              child: Text("Composer", 
                                textAlign: TextAlign.center,
                                softWrap: true,
                                maxLines: 5,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: MyAppColors.principalcolor,
                                  fontSize: 14,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                
              ],
            ),
          )),
      ),
    );
  }
}