import 'package:ecole_kolea_app/Componants/EvaluationList.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Evaluation extends StatefulWidget {
  const Evaluation({super.key});

  @override
  State<Evaluation> createState() => _EvaluationState();
}

class _EvaluationState extends State<Evaluation> {

  List<String> Semestre=[
    "S10",
    "S9",
    "S8",
    "S7",
    "S6",
    "S5",
    "S4",
    "S3",
    "S2",
    "S1",
  ];

  int currentTab=0;

  void changeTab(int index){
    setState(() {
      currentTab=index;
    });
  }

  
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
                    itemCount: Semestre.length,
                    
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
                            child: Text(Semestre[index], style: TextStyle(color: currentTab == index ? MyAppColors.whitecolor: MyAppColors.principalcolor),),
                          ),
                        ),
                      );
                    },
                  
                  ),
                ),
              ),
              
              //Moyenne
              EvaluationList(),
            ],
          ),
      ),
      );
  }
}
