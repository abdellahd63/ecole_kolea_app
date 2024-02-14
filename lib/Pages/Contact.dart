import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                    color: MyAppColors.principalcolor,
                    fontSize: 16,
                    
                    
                  ),
                ),

                SizedBox(height: 30,),
      
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal : 10, vertical: 25),
                    decoration: BoxDecoration(
                      color: MyAppColors.dimopacityvblue,
                      borderRadius: BorderRadius.circular(10),
                      
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.location_on, color: MyAppColors.principalcolor,size: 40,),
                            Flexible(
                              child: Text("  Ecole supérieure de gestion et d’économie numérique – Pole universitaire – Koléa", 
                                textAlign: TextAlign.left,
                                softWrap: true,
                                maxLines: 5,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: MyAppColors.principalcolor,
                                  fontSize: 12,
                                  
                                  
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.mail, color: MyAppColors.principalcolor,size: 40,),
                            Flexible(
                              child: Text("  contact@esgen.edu.dz", 
                                textAlign: TextAlign.left,
                                softWrap: true,
                                maxLines: 5,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: MyAppColors.principalcolor,
                                  fontSize: 13,
                                  
                                  
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10,),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(CupertinoIcons.phone_fill, color: MyAppColors.principalcolor,size: 40,),
                            Flexible(
                              child: Text("  024 38 01 08", 
                                textAlign: TextAlign.left,
                                softWrap: true,
                                maxLines: 5,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: MyAppColors.principalcolor,
                                  fontSize: 15,
                                  
                                  
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                  ),
                )
              ],
            ),
          )),
      ),
    );
  }
}