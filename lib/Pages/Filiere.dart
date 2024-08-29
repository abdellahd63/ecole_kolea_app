import 'package:ecole_kolea_app/Componants/Filieresdescription.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:flutter/material.dart';

class Filiere extends StatelessWidget {
  const Filiere({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.whitecolor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //discover
              SizedBox(height: 20,),
              Text("Découvrir nos filières", 
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: MyAppColors.principalcolor,
                  fontSize: 18,
                  overflow: TextOverflow.ellipsis,
                  
                ),
              ),

              SizedBox(height: 20,),
      
              //1st cycle
      
              Row(
                children: [
                  Expanded(
                    child: Divider(
                        height: 1,
                        color: MyAppColors.principalcolor,
                      )
                  ),
      
                  Text('  1 er Cycle  ',
                    style: TextStyle(color: MyAppColors.principalcolor, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
      
                  Expanded(
                    child: Divider(
                        height: 1,
                        color: MyAppColors.principalcolor,
                      )
                  ),
                ],
              ),
      
              //present

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("L'ESGEN propose1 une formation en cycle préparatoire de deux ans, qui après un concours national",
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: MyAppColors.black, fontSize: 15,),
                    ),
              ),

              SizedBox(height: 20,),
              //2nd cycle

              Row(
                children: [
                  Expanded(
                    child: Divider(
                        height: 1,
                        color: MyAppColors.principalcolor,
                      )
                  ),
      
                  Text('  2 eme Cycle  ',
                    style: TextStyle(color: MyAppColors.principalcolor, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
      
                  Expanded(
                    child: Divider(
                        height: 1,
                        color: MyAppColors.principalcolor,
                      )
                  ),
                ],
              ),
      
              //present

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Après un concours national peut déboucher sur un deuxième cycle avec cinq parcours possible sanctionné par un diplôme de Master en :",
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: MyAppColors.black, fontSize: 15,),
                    ),
              ),

              SizedBox(height: 20,),

              

              //Specialite


              Filieresdescription(
                title: "E-Banking", 
                description: "L’École Supérieure de Gestion et de l'Économie Numérique de Kolea intègre l'E-Banking dans son programme académique pour offrir à ses étudiants une formation de pointe dans le domaine financier numérique. Ce module explore les fondements des services bancaires électroniques, incluant les paiements en ligne, la gestion des comptes à distance, et l'innovation financière dans un environnement digital. Les étudiants acquièrent des compétences essentielles pour naviguer dans le monde en constante évolution de la finance numérique, en se concentrant sur la sécurité des transactions, la réglementation financière, et l'utilisation des technologies avancées telles que la blockchain et l'intelligence artificielle. Cette formation prépare les futurs professionnels à relever les défis de la transformation digitale dans le secteur bancaire.",
              ),


              Filieresdescription(
                title: "E-Business", 
                description: "À l'École Supérieure de Gestion et de l'Économie Numérique Kolea, l'E-business représente une discipline clé qui prépare les étudiants à maîtriser les technologies numériques appliquées au commerce et à la gestion d'entreprises. Ce programme forme des professionnels capables de concevoir, de mettre en œuvre et de gérer des stratégies de commerce électronique, en intégrant des compétences en marketing digital, en gestion des systèmes d'information, et en entrepreneuriat numérique.",
              ),



              Filieresdescription(
                title: "Audit et contrôle de gestion", 
                description: "Le programme d'Audit et Contrôle de Gestion de l'École Supérieure De Gestion Et De L'économie Numérique Kolea est conçu pour former des experts capables d'assurer la bonne gestion et la transparence financière des organisations. Ce parcours allie théorie et pratique pour permettre aux étudiants de maîtriser les techniques d'audit interne, d'évaluation des risques, et de contrôle de gestion.",
              ),


              Filieresdescription(
                title: "Gouvernance de la sécurité des SI", 
                description: "La gouvernance de la sécurité des systèmes d'information (SI) à l'Ecole Supérieure de Gestion et de l'Économie Numérique Kolea vise à établir des pratiques robustes et conformes pour protéger les informations et les infrastructures informatiques de l'institution. ",
              ),

              Filieresdescription(
                title: "Management Digital", 
                description: "Le programme de Management Digital à l’École Supérieure De Gestion Et De L'économie Numérique Kolea est conçu pour préparer les futurs leaders à naviguer dans un environnement commercial en constante évolution. Ce cursus se concentre sur l'intégration des technologies numériques dans les stratégies de gestion, offrant aux étudiants une compréhension approfondie des outils et des techniques nécessaires pour optimiser les performances des entreprises dans l'ère numérique.",
              ),

            

              



            

             

              


              

            
            ],
          ),
        ),
      ),
    );
  }
}