import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Connectedpresentation extends StatefulWidget {
  final VoidCallback onPlanningButtonPressed;
  final VoidCallback onevaluationButtonPressed;
  final VoidCallback onnotificationButtonPressed;
  final VoidCallback onpresenceButtonPressed;
  const Connectedpresentation(
    {super.key,
    required this.onPlanningButtonPressed,
    required this.onevaluationButtonPressed,
    required this.onnotificationButtonPressed,
    required this.onpresenceButtonPressed,
   });

  @override
  State<Connectedpresentation> createState() => _ConnectedpresentationState();
}

class _ConnectedpresentationState extends State<Connectedpresentation> {
  String mysourceType = "";

  void fetchInitData() async{
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      mysourceType = preferences.getString("type").toString();
    });
  }
  @override
  void initState() {
    super.initState();
    fetchInitData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               //logo
              Image.asset('lib/Assets/Images/logo.png'),

              // bienvenu

              

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("de retour ! \n Préparez-vous à atteindre vos objectifs.",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    maxLines: 5,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: MyAppColors.black,
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,

                    ),
                  ),
                ],
              ),
              if(mysourceType == "etudiant" || mysourceType == "enseignant")
              SizedBox(height: 40,),
              if(mysourceType == "etudiant" || mysourceType == "enseignant")
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          widget.onPlanningButtonPressed();
                        },
                        child: Container(

                          height: 170,
                          decoration: BoxDecoration(
                            color: MyAppColors.dimopacityvblue,
                            borderRadius: BorderRadius.circular(20),

                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(height: 70, child: Image.asset('lib/Assets/Images/plancours.png')),
                                SizedBox(height: 10,),
                                Text('Programmes',
                                  style: TextStyle(
                                      color: MyAppColors.principalcolor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16
                                  ),
                                )
                            ],
                          ),
                        ),
                      )
                      ),

                    if(mysourceType == "etudiant" || mysourceType == "enseignant")
                      SizedBox(width: 20,),
                    if(mysourceType == "enseignant")

                    Expanded(
                      child: InkWell(
                        onTap: (){
                          widget.onnotificationButtonPressed();
                        },
                        child: Container(

                          height: 170,
                          decoration: BoxDecoration(
                            color: MyAppColors.dimopacityvblue,
                            borderRadius: BorderRadius.circular(20),

                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 70,
                                child: Image.asset('lib/Assets/Images/Notification.png',)),
                                SizedBox(height: 10,),
                                Text('Notifications',
                                  style: TextStyle(
                                      color: MyAppColors.principalcolor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16
                                  ),
                                )
                            ],
                          ),
                        ),
                      )
                      ),

                    if(mysourceType == "etudiant")
                      Expanded(
                      child: InkWell(
                        onTap: (){
                          widget.onevaluationButtonPressed();
                        },
                        child: Container(
                          height: 170,
                          decoration: BoxDecoration(
                            color: MyAppColors.dimopacityvblue,
                            borderRadius: BorderRadius.circular(20),

                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container( height: 70, child: Image.asset('lib/Assets/Images/planexams.png')),
                                SizedBox(height: 10,),
                                Text('Evaluation',
                                  style: TextStyle(
                                      color: MyAppColors.principalcolor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16
                                  ),
                                )
                            ],
                          ),
                        ),
                      )
                      ),

                  ],
                ),
              ),
              if(mysourceType == "etudiant")
              SizedBox(height: 20,),
              if(mysourceType == "etudiant")
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          widget.onnotificationButtonPressed();
                        },
                        child: Container(

                          height: 170,
                          decoration: BoxDecoration(
                            color: MyAppColors.dimopacityvblue,
                            borderRadius: BorderRadius.circular(20),

                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 70,
                                child: Image.asset('lib/Assets/Images/Notification.png',)),
                                SizedBox(height: 10,),
                                Text('Notifications',
                                  style: TextStyle(
                                      color: MyAppColors.principalcolor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16
                                  ),
                                )
                            ],
                          ),
                        ),
                      )
                      ),


                      SizedBox(width: 20,),


                      Expanded(
                      child: InkWell(
                        onTap: (){
                          widget.onpresenceButtonPressed();
                        },
                        child: Container(
                          height: 170,
                          decoration: BoxDecoration(
                            color: MyAppColors.dimopacityvblue,
                            borderRadius: BorderRadius.circular(20),

                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(height: 70, child: Image.asset('lib/Assets/Images/qrcode.png')),
                                SizedBox(height: 10,),
                                Text('Presence',
                                  style: TextStyle(
                                      color: MyAppColors.principalcolor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16
                                  ),
                                )
                            ],
                          ),
                        ),
                      )
                      ),

                  ],
                ),
              ),
           
              if(mysourceType == "enseignant")
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                            child: InkWell(
                              onTap: (){
                                widget.onpresenceButtonPressed();
                              },
                              child: Container(
                                height: 170,
                                decoration: BoxDecoration(
                                  color: MyAppColors.dimopacityvblue,
                                  borderRadius: BorderRadius.circular(20),
                    
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container( height: 70, child: Image.asset('lib/Assets/Images/qrcode.png')),
                                      SizedBox(height: 10,),
                                      Text('Presence',
                                        style: TextStyle(
                                            color: MyAppColors.principalcolor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            )
                            ),

                            SizedBox(width: 20,),
                
                            Expanded(child: Container())
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}