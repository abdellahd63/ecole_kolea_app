import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Pages/Bibiotheque.dart';
import 'package:flutter/material.dart';

class Livres extends StatelessWidget {
  const Livres({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: MyAppColors.whitecolor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
                SizedBox(height: 30,),
                

                ListTile(
                  leading: InkWell(
                    child: Icon(Icons.arrow_back_ios, color: MyAppColors.principalcolor,),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),

                  title: Text("Commerce", 
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: MyAppColors.principalcolor,
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis,
                        
                      ),
                    ),
                ),
                
                
                SizedBox(height: 20,),
              ListTile(
                tileColor: MyAppColors.dimopacityvblue,
                
                title: Text("Introduction to E commerce"),
                subtitle: Row(
                  children: [
                    Text("Taille : "),
                    Text("400 Mo"),
                  ],
                ),

                trailing: Icon(Icons.download),
              )
            ]),
        ),
      ),
    );
  }
}