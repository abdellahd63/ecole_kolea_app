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

  void changeTab(int index){
    setState(() {
      currentTab=index;
    });
  }
  late int? affichageID = null;
  void setAffichageID(int id){
    setState(() {
      affichageID= id;
    });
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
                              itemCount: AffichageData.length,
                              itemBuilder:(context, index) {
                                return Column(
                                  children: [
                                    Text(
                                      (AffichageData[index].semestre.toString() == '01' || AffichageData[index].semestre.toString() == '02'
                                          ? '1er '
                                          : (AffichageData[index].semestre.toString() == '03' || AffichageData[index].semestre.toString() == '04'
                                              ? '2eme '
                                              :(AffichageData[index].semestre.toString() == '05' || AffichageData[index].semestre.toString() == '06'
                                                    ? '3eme '
                                                    :'4eme '
                                                )
                                            )
                                      )
                                          +'annnee',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: MyAppColors.gray400
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        changeTab(index);
                                        setAffichageID(AffichageData[index].id);
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
                                          child: Text('S${AffichageData[index].semestre}', style: TextStyle(color: currentTab == index ? MyAppColors.whitecolor: MyAppColors.principalcolor),),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },

                            ),
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
