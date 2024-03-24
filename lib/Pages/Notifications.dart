import 'package:ecole_kolea_app/APIs.dart';
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

  List<String> not=['Prive', 'Groupe', 'Section', 'Promo'];

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
              if(currentTab == 0)
              FutureBuilder<List<dynamic>>(
                future: APIs.GetAllAnnoncesForStudent(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(),
                            ],
                          ),)
                    ); // or any loading indicator
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('Aucune annonce disponible.');
                  } else {
                    List<NotificationModel> notificatinsList = List<NotificationModel>.from(snapshot.data!.map<NotificationModel>((item) => NotificationModel.fromJson(item)));
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: notificatinsList.length,
                      itemBuilder: (context, index) {
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
                                  Text(notificatinsList[index].Title,
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
                    );
                  }
                },
              ),
              if(currentTab == 1)
                FutureBuilder<List<dynamic>>(
                  future: APIs.GetAllAnnoncesForGroupe(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularProgressIndicator(),
                              ],
                            ),)
                      ); // or any loading indicator
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('Aucune annonce disponible.');
                    } else {
                      List<NotificationModel> notificatinsList = List<NotificationModel>.from(snapshot.data!.map<NotificationModel>((item) => NotificationModel.fromJson(item)));
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: notificatinsList.length,
                        itemBuilder: (context, index) {
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
                                    Text(notificatinsList[index].Title,
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
                      );
                    }
                  },
                ),
              if(currentTab == 2)
                FutureBuilder<List<dynamic>>(
                  future: APIs.GetAllAnnoncesForSection(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularProgressIndicator(),
                              ],
                            ),)
                      ); // or any loading indicator
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('Aucune annonce disponible.');
                    } else {
                      List<NotificationModel> notificatinsList = List<NotificationModel>.from(snapshot.data!.map<NotificationModel>((item) => NotificationModel.fromJson(item)));
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: notificatinsList.length,
                        itemBuilder: (context, index) {
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
                                    Text(notificatinsList[index].Title,
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
                      );
                    }
                  },
                ),
              if(currentTab == 3)
                FutureBuilder<List<dynamic>>(
                  future: APIs.GetAllAnnoncesForFiliere(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularProgressIndicator(),
                              ],
                            ),)
                      ); // or any loading indicator
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('Aucune annonce disponible.');
                    } else {
                      List<NotificationModel> notificatinsList = List<NotificationModel>.from(snapshot.data!.map<NotificationModel>((item) => NotificationModel.fromJson(item)));
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: notificatinsList.length,
                        itemBuilder: (context, index) {
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
                                    Text(notificatinsList[index].Title,
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
                      );
                    }
                  },
                ),
            ],
          ),
      ),
      );
  }
}