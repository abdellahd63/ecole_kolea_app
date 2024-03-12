import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Pages/Chat.dart';
import 'package:flutter/material.dart';

class Doleance extends StatelessWidget {
  const Doleance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.whitecolor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text('Tous mes messages'),
                ),
              ],
            ),
            
            InkWell(
              child: ListTile(
                leading: Image.asset('lib/Assets/Images/noprofilpic.png'),
                title: Text("Mme Tabti"),
                subtitle: Text("Bonne nuit"),
                
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Chat()));
              },
            ),
            Divider(),

            ListTile(
              leading: Image.asset('lib/Assets/Images/noprofilpic.png'),
              title: Text("Direction Generale"),
              subtitle: Text("Bonjour mr..."),
              
            ),
            Divider()
          ]),
      ),
    );
  }
}