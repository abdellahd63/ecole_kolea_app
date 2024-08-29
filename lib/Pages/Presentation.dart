import 'package:ecole_kolea_app/Componants/DiscouverItem.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Model/Presentationmodel.dart';
import 'package:ecole_kolea_app/Model/Presentationmodel.dart';
import 'package:ecole_kolea_app/Pages/Login.dart';
import 'package:flutter/material.dart';

class Presentation extends StatelessWidget {
  final VoidCallback onProfileButtonPressed;

   Presentation({super.key, required this.onProfileButtonPressed});

  

  @override
  Widget build(BuildContext context) {
    List <Presentationmodel> presentationlist=[

    Presentationmodel( 
      imgpath: 'lib/Assets/Images/Frame1.jpg',
      title: 'Notre Compus',
      description: "Le campus universitaire de l'École Sup de Kolea offre un environnement académique moderne et bien équipé pour favoriser l'apprentissage et la recherche."
    ),

    Presentationmodel( 
      imgpath: 'lib/Assets/Images/Frame2.jpg',
      title: 'Notre Bibliotheque',
      description: "La bibliothèque de l'École Supérieure de Kolea est un pilier central du campus, offrant un environnement propice à l'étude, à la recherche et à l'apprentissage."
    ),

    Presentationmodel( 
      imgpath: 'lib/Assets/Images/Frame3.jpg',
      title: 'Nos Classes',
      description: "L'École Supérieure de Kolea propose une variété de cours couvrant de nombreuses disciplines, répondant aux besoins académiques et professionnels de ses étudiants."
    ),


  ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //logo
              Image.asset('lib/Assets/Images/logo.png'),
              
              // bienvenu

              Text("Bienvenu à \n L’Ecole Supérieure De Gestion Et De \n L'économie Numérique Kolea", 
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: MyAppColors.black,
                  fontSize: 18,
                  overflow: TextOverflow.ellipsis,
                  
                ),
              ),

              //devider decouvrir

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text('Découvrir  ',
                      style: TextStyle(
                        color: MyAppColors.principalcolor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        height: 1,
                      ),
                    )
                  ],
                ),
              ),
              //list items
              Container(
                padding: EdgeInsets.only(left: 15),
                height: 380,
                child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context , index){
                      
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: DiscoverItem(
                          imgpath: presentationlist[index].imgpath,
                          title: presentationlist[index].title,
                          description: presentationlist[index].description,
                        ),
                      );
                  }),
              ),
              //  Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          onProfileButtonPressed();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: MyAppColors.dimopacityvblue,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text('Voir nos filiers',textAlign: TextAlign.center ,style: TextStyle(color: MyAppColors.principalcolor),),
                        ),
                      ),
                      ),
                      
                      SizedBox(width: 10,),
                
                      Expanded(
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: MyAppColors.principalcolor,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text('Se connecter',textAlign: TextAlign.center, style: TextStyle(color: MyAppColors.whitecolor),),
                        ),
                      ),
                      )
                  ],
                ),
              )
             


             



            ],
            
          ),
        ),
      ),
    );
  }
}