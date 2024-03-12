import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:flutter/material.dart';

class Profil extends StatelessWidget {
  const Profil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //pic
                Image.asset('lib/Assets/Images/profilpic.jpg'),
              //name 
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:20.0),
                  child: Text("Bourouba Ilyes", 
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: MyAppColors.principalcolor,
                      fontSize: 20,
                      
                      
                    ),
                  ),
                ),

              //info

              Padding(
                  padding: const EdgeInsets.symmetric(horizontal:15.0 , vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text("Informations", 
                          textAlign: TextAlign.left,
                          softWrap: true,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: MyAppColors.principalcolor,
                            fontSize: 16,
                            
                            
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:10.0, vertical: 5),
                child: Row(
                  
                  children: [
                    Expanded(
                      child: Container(
                        height: 45,
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: MyAppColors.dimopacityvblue,
                          borderRadius: BorderRadius.circular(10),
              
                        ),
              
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.key, color: MyAppColors.principalcolor,),
                            
                            Text(' 202319190022',
                              style: TextStyle(
                                color: MyAppColors.principalcolor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14
                              ),
                            )
                          ],
                        ),
                      )),
              
                      SizedBox(width: 5,),
                      Expanded(
                      child: Container(
                        height: 45,
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: MyAppColors.dimopacityvblue,
                          borderRadius: BorderRadius.circular(10),
              
                        ),
              
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Née le ',
                              style: TextStyle(
                                color: MyAppColors.principalcolor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14
                              ),
                            ),
                            
                            Text('11-12-1998',
                              style: TextStyle(
                                color: MyAppColors.principalcolor,
                                
                                fontSize: 14
                              ),
                            )
                          ],
                        ),
                      ))
                  ],
                ),
              ),



              Padding(
                padding: const EdgeInsets.symmetric(horizontal:10.0, vertical: 5),
                child: Row(
                  
                  children: [
                    Expanded(
                      child: Container(
                        height: 45,
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: MyAppColors.dimopacityvblue,
                          borderRadius: BorderRadius.circular(10),
              
                        ),
              
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           Text('Cycle ',
                              style: TextStyle(
                                color: MyAppColors.principalcolor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14
                              ),
                            ),
                            
                            Text('Master',
                              style: TextStyle(
                                color: MyAppColors.principalcolor,
                                
                                fontSize: 14
                              ),
                            )
                          ],
                        ),
                      )),
              
                      SizedBox(width: 5,),
                      Expanded(
                      child: Container(
                        height: 45,
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: MyAppColors.dimopacityvblue,
                          borderRadius: BorderRadius.circular(10),
              
                        ),
              
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Année ',
                              style: TextStyle(
                                color: MyAppColors.principalcolor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14
                              ),
                            ),
                            
                            Text('1ere année',
                              style: TextStyle(
                                color: MyAppColors.principalcolor,
                                
                                fontSize: 14
                              ),
                            )
                          ],
                        ),
                      ))
                  ],
                ),
              ),



              Padding(
                padding: const EdgeInsets.symmetric(horizontal:10.0, vertical: 5),
                child: Row(
                  
                  children: [
                    Expanded(
                      child: Container(
                        height: 45,
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: MyAppColors.dimopacityvblue,
                          borderRadius: BorderRadius.circular(10),
              
                        ),
              
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Filière ',
                              style: TextStyle(
                                color: MyAppColors.principalcolor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14
                              ),
                            ),
                            
                            Text('E-Banking',
                              style: TextStyle(
                                color: MyAppColors.principalcolor,
                                
                                fontSize: 14
                              ),
                            )
                          ],
                        ),
                      )),
              
                      SizedBox(width: 5,),
                      Expanded(
                      child: Container(
                        height: 45,
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: MyAppColors.dimopacityvblue,
                          borderRadius: BorderRadius.circular(10),
              
                        ),
              
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Section ',
                              style: TextStyle(
                                color: MyAppColors.principalcolor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14
                              ),
                            ),
                            
                            Text('1',
                              style: TextStyle(
                                color: MyAppColors.principalcolor,
                                
                                fontSize: 14
                              ),
                            )
                          ],
                        ),
                      ))
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal:10.0, vertical: 5),
                child: Row(
                  
                  children: [
                    Expanded(
                      child: Container(
                        height: 45,
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: MyAppColors.dimopacityvblue,
                          borderRadius: BorderRadius.circular(10),
              
                        ),
              
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Groupe ',
                              style: TextStyle(
                                color: MyAppColors.principalcolor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14
                              ),
                            ),
                            
                            Text('2',
                              style: TextStyle(
                                color: MyAppColors.principalcolor,
                                
                                fontSize: 14
                              ),
                            )
                          ],
                        ),
                      )),
              
                      SizedBox(width: 5,),
                      Expanded(
                      child: Container(
                        height: 45,
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: MyAppColors.dimopacityvblue,
                          borderRadius: BorderRadius.circular(10),
              
                        ),
              
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Sexe ',
                              style: TextStyle(
                                color: MyAppColors.principalcolor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14
                              ),
                            ),
                            
                            Text('Homme',
                              style: TextStyle(
                                color: MyAppColors.principalcolor,
                                
                                fontSize: 14
                              ),
                            )
                          ],
                        ),
                      ))
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}