import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Pages/Livres.dart';
import 'package:flutter/material.dart';

class Bibiotheque extends StatelessWidget {
  Bibiotheque({super.key});

  List<String> domains=["Analyse", "Algebre","Informatique", "Marketing", "Management","Langue","Droits","Culture Generale","Economie"];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.whitecolor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            
            children: [

              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Bibliotheque", 
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: MyAppColors.principalcolor,
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                      
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),

              ListView.builder(
                itemCount: domains.length,
                shrinkWrap: true,
                itemBuilder:(context, index) {
                return InkWell(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    decoration: BoxDecoration(
                      color: MyAppColors.dimopacityvblue,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(domains[index], 
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600
                        ),),
                
                        Icon(Icons.keyboard_arrow_right_outlined),
                
                        
                      ],
                    ),
                  ),

                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Livres()));
                  },
                );
              },)
              
            ],
          ),
        ),
      ),
    );
  }
}