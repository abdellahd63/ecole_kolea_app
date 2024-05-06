import 'package:ecole_kolea_app/APIs.dart';
import 'package:ecole_kolea_app/Componants/EvaluationList.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Model/Affichage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Evaluation extends StatefulWidget {
  const Evaluation({super.key});

  @override
  State<Evaluation> createState() => _EvaluationState();
}

class _EvaluationState extends State<Evaluation> {
  int currentTab=0;
  int currentSemesterTab=0;

  void changeTab(int index){
    setState(() {
      currentTab=index;
    });
  }
  void changeSemesterTab(int index){
    setState(() {
      currentSemesterTab=index;
    });
  }
  late int? affichageID = null;
  void setAffichageID(int id){
    setState(() {
      affichageID= id;
    });
  }
  List<Affichage> Semesters = [];
  int? cycleID = null;
  List<Affichage> filterDuplicates<Affichage>(List<Affichage> list, int Function(Affichage) idSelector) {
    Set<int> uniqueIds = Set();
    List<Affichage> filteredList = [];
    for (Affichage item in list) {
      int id = idSelector(item);
      if (!uniqueIds.contains(id)) {
        uniqueIds.add(id);
        filteredList.add(item);
      }
    }
    return filteredList;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
          future: APIs.GetAllAffichageByIDEtudiant(context),
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data == null) {
                return Center(child: Text('No data available.'));
              } else {
                List<Affichage> AffichageData = List<Affichage>.from(snapshot.data!.map<Affichage>((item) => Affichage.fromJson(item)));
                if (AffichageData.isEmpty)
                  return Center(child: Text('No data available.'));
                if(affichageID == null)
                affichageID = AffichageData[0].id;
                if(cycleID == null)
                Semesters = AffichageData.where((item) => item.anneeID == AffichageData[0].anneeID).toList();
                List<Affichage> filtredAffichageData = filterDuplicates(AffichageData, (item) => item.anneeID);
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
                              itemCount: filtredAffichageData.length,
                              itemBuilder:(context, index) {
                                return InkWell(
                                  onTap: (){
                                    changeTab(index);
                                    changeSemesterTab(0);
                                    affichageID = AffichageData[index].id;
                                    cycleID = filtredAffichageData[index].anneeID;
                                    Semesters = AffichageData.where((item) => item.anneeID == cycleID).toList();
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(microseconds: 300),
                                    width: 100,
                                    height: 20,
                                    margin: EdgeInsets.symmetric(horizontal: 5,),
                                    padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                    decoration: BoxDecoration(
                                      color: currentTab == index ? MyAppColors.principalcolor: MyAppColors.dimopacityvblue,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text('${filtredAffichageData[index].annee}', style: TextStyle(color: currentTab == index ? MyAppColors.whitecolor: MyAppColors.principalcolor),),
                                    ),
                                  ),
                                );
                              },

                            ),
                          ),
                        ),
                        if(Semesters.length > 0)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    changeSemesterTab(0);
                                    setAffichageID(Semesters[0].id);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0.0, // Remove shadow
                                    textStyle: const TextStyle(color: Colors.white),
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    backgroundColor: currentSemesterTab == 0 ? MyAppColors.principalcolor: MyAppColors.dimopacityvblue,
                                  ),
                                  child: Text('${Semesters[0].semestre}', style: TextStyle(color: currentSemesterTab == 0 ? MyAppColors.whitecolor: MyAppColors.principalcolor),),
                                ),
                                if(Semesters.length > 1)
                                ElevatedButton(
                                  onPressed: () {
                                    changeSemesterTab(1);
                                    setAffichageID(Semesters[1].id);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0.0, // Remove shadow
                                    textStyle: const TextStyle(color: Colors.white),
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    backgroundColor: currentSemesterTab == 1 ? MyAppColors.principalcolor: MyAppColors.dimopacityvblue,
                                  ),
                                  child: Text('${Semesters[1].semestre}', style: TextStyle(color: currentSemesterTab == 1 ? MyAppColors.whitecolor: MyAppColors.principalcolor),),
                                ),
                              ],
                            ),
                          ),
                        //Moyenne
                        if(affichageID != null)
                          EvaluationList(
                            key: ValueKey<String>(affichageID.toString()),
                            id: affichageID.toString(),
                          ),
                      ],
                    ),
                  ),
                );
              }
            },
    );
  }
}
