import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Model/Notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {


  int currentTab=0;

  void changeTab(int index){
    setState(() {
      currentTab=index;
    });
  }



  List<String> not=['Prive', 'Groupe', 'Section', 'Promo','Public'];

  List<NotificationModel> notificatinsList=[
    NotificationModel("Presence avant le 30", "Bonjour mr nom prenom veuillez se présentera l’administartion avant le 30 janvier."),

    NotificationModel("Demande certificat de scolarit...", "Bonjour mme/mr , j’ai besoin de ma certificat descolarité pour l’année 2023 2024."),

    NotificationModel("Presence avant le 30", "Bonjour mr nom prenom veuillez se présentera l’administartion avant le 30 janvier."),

    NotificationModel("Demande certificat de scolarit...", "Bonjour mme/mr , j’ai besoin de ma certificat descolarité pour l’année 2023 2024."),

    NotificationModel("Presence avant le 30", "Bonjour mr nom prenom veuillez se présentera l’administartion avant le 30 janvier."),

    NotificationModel("Demande certificat de scolarit...", "Bonjour mme/mr , j’ai besoin de ma certificat descolarité pour l’année 2023 2024."),

    NotificationModel("Presence avant le 30", "Bonjour mr nom prenom veuillez se présentera l’administartion avant le 30 janvier."),

    NotificationModel("Demande certificat de scolarit...", "Bonjour mme/mr , j’ai besoin de ma certificat descolarité pour l’année 2023 2024."),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            children: [
              //Tab Bar
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 45,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: not.length,
                    
                    itemBuilder:(context, index) {
                      return InkWell(
                        onTap: (){
                          changeTab(index);
                        },
                        child: AnimatedContainer(
                          duration: Duration(microseconds: 300),
                          width: 85,
                          height: 20,
                          margin: EdgeInsets.symmetric(horizontal: 5,),
                          
                          decoration: BoxDecoration(
                            color: currentTab == index ? MyAppColors.principalcolor: MyAppColors.dimopacityvblue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(not[index], style: TextStyle(color: currentTab == index ? MyAppColors.whitecolor: MyAppColors.principalcolor),),
                          ),
                        ),
                      );
                    },
                  
                  ),
                ),
              ),
              
              //Notificatins
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: notificatinsList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: MyAppColors.dimopacityvblue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left:15.0, top: 5, bottom: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(notificatinsList[index].Object,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                            ),
                            ),
                            Text(notificatinsList[index].Content),
                      
                          ],
                        ),
                      ) ,),
                  );
                },

              ),
              
            ],
          ),
      ),
      );
  }
}