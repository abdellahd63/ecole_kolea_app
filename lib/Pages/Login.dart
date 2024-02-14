import 'package:ecole_kolea_app/Componants/LoginEdittext.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Pages/ConnectedHomePage.dart';
import 'package:ecole_kolea_app/Pages/DeconnectedHomepage.dart';
import 'package:ecole_kolea_app/Pages/Presentation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  Login({super.key});

  

  @override
  Widget build(BuildContext context) {
    TextEditingController matriculetextfield = new TextEditingController();
    TextEditingController passwordtextfield = new TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyAppColors.principalcolor,
        leading: InkWell(
          child: Icon(Icons.arrow_back_ios, color: MyAppColors.whitecolor,),
          onTap: () {
             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DeconnectedHomePage()));
          },
          
          ),
      ),

      backgroundColor: MyAppColors.principalcolor,

      body: Center(
        child:SingleChildScrollView(
          child: Column(
            children: [
              //logo
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal : 10, vertical: 25),
                    decoration: BoxDecoration(
                      color: MyAppColors.blue,
                      borderRadius: BorderRadius.circular(10),
                      
                    ),
                    child:Image.asset('lib/Assets/Images/logo.png'),
                    )),
              //se conn
              Text("Connectez vous !", 
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: MyAppColors.whitecolor,
                    fontSize: 26,
                    
                    
                  ),
                ),
              //matricule
              LoginEdittext(hint: "Maticule", isPassword: false, controller: matriculetextfield, icon: Icons.key, visiblicon: null,),
              //mdp
              LoginEdittext(hint: "Mot De Passe", isPassword: false, controller: matriculetextfield, icon: CupertinoIcons.lock_fill, visiblicon: Icons.visibility_off,),
              //login

              InkWell(
                onTap: () {
                   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ConnectedHomePage()));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                  child: Container(
                    padding: EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyAppColors.darkblue,
                    ),
                    child: Center(
                      child: Text(
                        "Se Connecter",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ) ),
      
    );
  }
}