import 'package:ecole_kolea_app/APIs.dart';
import 'package:ecole_kolea_app/Componants/LoginEdittext.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Pages/DeconnectedHomepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController matriculetextfield = new TextEditingController();

  TextEditingController Passwordtextfield = new TextEditingController();

  @override
  void dispose() {
    matriculetextfield.dispose();
    Passwordtextfield.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      resizeToAvoidBottomInset: true,
      
      
      body: Container(
        decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/Assets/Images/loginbg.png"), fit: BoxFit.cover)
            ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //se conn
                Text("Bienvenu", 
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: MyAppColors.black,
                      fontSize: 24,
                    ),
                  ),
            
                  SizedBox(height: 20,),
            
                  Text("bon retour, connectez vous pour utiliser cette application", 
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: MyAppColors.black,
                      fontSize: 18,
                    ),
                  ),
            
                  SizedBox(height: 20,),
                //matricule
                LoginEdittext(hint: "Maticule", isPassword: false, controller: matriculetextfield, icon: Icons.key, visiblicon: null,),
                //mdp
                LoginEdittext(hint: "Mot De Passe", isPassword: true, controller: Passwordtextfield, icon: CupertinoIcons.lock_fill, visiblicon: Icons.visibility_off,),
                //login
                SizedBox(height: 20,),
                InkWell(
                  onTap: () async {
                    await APIs.signIn(context, matriculetextfield, Passwordtextfield);
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
                ),

                SizedBox(height: 20,),

                InkWell(
                  onTap: (){Navigator.pop(context);},
                  child: Text("Revenir en arriere", 
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: MyAppColors.darkblue,
                        fontSize: 14,
                      ),
                    ),
                ),
              ],
            ),
          ),
        ),
      ),
      
    );
  }
}