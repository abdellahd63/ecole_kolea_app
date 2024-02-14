import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:flutter/material.dart';

class Filiere extends StatelessWidget {
  const Filiere({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.whitecolor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
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
                      style: TextStyle(color: MyAppColors.principalcolor, fontSize: 15,),
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
                      style: TextStyle(color: MyAppColors.principalcolor, fontSize: 15,),
                    ),
              ),

              SizedBox(height: 20,),

              //Specialite

              Padding(
                padding: const EdgeInsets.only(left : 30.0),
                child: Row(
                  children: [
              
                    Icon(Icons.circle, color: Colors.black, size: 16,),
                    SizedBox(width: 20,),
                    Text("E-Banking",
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: Colors.black, fontSize: 15,),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left : 30.0),
                child: Row(
                  children: [
              
                    Icon(Icons.circle, color: Colors.black, size: 16,),
                    SizedBox(width: 20,),
                    Text("E-Business",
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: Colors.black, fontSize: 15,),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left : 30.0),
                child: Row(
                  children: [
              
                    Icon(Icons.circle, color: Colors.black, size: 16,),
                    SizedBox(width: 20,),
                    Text("Audit et contrôle de gestion",
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: Colors.black, fontSize: 15,),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left : 30.0),
                child: Row(
                  children: [
              
                    Icon(Icons.circle, color: Colors.black, size: 16,),
                    SizedBox(width: 20,),
                    Text("Gouvernance de la sécurité des SI",
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: Colors.black, fontSize: 15,),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left : 30.0),
                child: Row(
                  children: [
              
                    Icon(Icons.circle, color: Colors.black, size: 16,),
                    SizedBox(width: 20,),
                    Text("Management Digital",
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: Colors.black, fontSize: 15,),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}