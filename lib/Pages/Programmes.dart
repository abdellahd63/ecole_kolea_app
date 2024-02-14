import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Programmes extends StatelessWidget {
  const Programmes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30,),
          Row(
            children: [
              Expanded(
                child: Text("Consulter Votre Planning", 
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

           SizedBox(height: 30,),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 170,
                          
                          
                           decoration: BoxDecoration(
                                color: MyAppColors.dimopacityvblue,
                                borderRadius: BorderRadius.circular(20),
                                    
                              ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('lib/Assets/Images/plancours.png'),
                              SizedBox(height: 10,),
                              Text('Planning cours',
                                style: TextStyle(
                                  color: MyAppColors.principalcolor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
          
                    Expanded(
                    child: InkWell(
                      onTap: () {
                        
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 170,
                          
                          
                           decoration: BoxDecoration(
                                color: MyAppColors.dimopacityvblue,
                                borderRadius: BorderRadius.circular(20),
                                    
                              ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('lib/Assets/Images/planexams.png'),
                              SizedBox(height: 10,),
                              Text('Planning examens',
                                style: TextStyle(
                                  color: MyAppColors.principalcolor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}