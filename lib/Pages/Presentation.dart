import 'package:ecole_kolea_app/Componants/DiscouverItem.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:flutter/material.dart';

class Presentation extends StatelessWidget {
  const Presentation({super.key});

  @override
  Widget build(BuildContext context) {
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
                  color: MyAppColors.principalcolor,
                  fontSize: 16,
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

              // liste des photos
             DiscoverItem(
              imgpath: 'lib/Assets/Images/Frame1.png',
              title: 'Notre Compus',
             ),


             DiscoverItem(
              imgpath: 'lib/Assets/Images/Frame2.png',
              title: 'Notre Bibliotheque',
             ),

             DiscoverItem(
              imgpath: 'lib/Assets/Images/Frame3.png',
              title: 'Nos Classes',
             ),



            ],
            
          ),
        ),
      ),
    );
  }
}