
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Pages/Bibiotheque.dart';
import 'package:ecole_kolea_app/Pages/Contact.dart';
import 'package:ecole_kolea_app/Pages/DeconnectedHomepage.dart';
import 'package:ecole_kolea_app/Pages/Doleance.dart';
import 'package:ecole_kolea_app/Pages/Evaluation.dart';
import 'package:ecole_kolea_app/Pages/Filiere.dart';
import 'package:ecole_kolea_app/Pages/Login.dart';
import 'package:ecole_kolea_app/Pages/Notifications.dart';
import 'package:ecole_kolea_app/Pages/Presence.dart';
import 'package:ecole_kolea_app/Pages/Presentation.dart';
import 'package:ecole_kolea_app/Pages/Profil.dart';
import 'package:ecole_kolea_app/Pages/Programmes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConnectedHomePage extends StatefulWidget {
  const ConnectedHomePage({super.key});

  @override
  State<ConnectedHomePage> createState() => _DeconnectedHomePageState();
}

class _DeconnectedHomePageState extends State<ConnectedHomePage> {

  int _selectedIndex=0;

    static  List<Widget> routes=[ const Presentation(), const Filiere() ,  Bibiotheque(),const Profil(),const Programmes(),const Evaluation(),const Notifications(),Doleance(),  Presence(),const Contact()];

    void _onitemtapped(int index){
      setState(() {
        _selectedIndex=index;
      });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context)=> IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          }, icon: Icon(Icons.menu, color:MyAppColors.principalcolor, size: 30,))),
        
        backgroundColor: MyAppColors.whitecolor,
      ),

      drawer: Drawer(
        
        child: ListView(
          children: [

            DrawerHeader(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical:10.0),
                child: Center(
              
                  child: Image.asset('lib/Assets/Images/logo.png'),
                  
                ),
              )),
            ListTile(
              leading: Icon(CupertinoIcons.home),
              selected: _selectedIndex==0,
              selectedColor: MyAppColors.principalcolor,
              title: Text("Presentation" ,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              onTap: (){
               _onitemtapped(0);
               Navigator.pop(context);
              },  
            ),
             ListTile(
              leading: Icon(CupertinoIcons.star),
              selected: _selectedIndex==1,
              selectedColor: MyAppColors.principalcolor,
              title: Text("Filiere" ,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              onTap: (){
               _onitemtapped(1);
               Navigator.pop(context);
              },  
            ),

            ListTile(
              leading: Icon(CupertinoIcons.book),
              selected: _selectedIndex==2,
              selectedColor: MyAppColors.principalcolor,
              title: Text("Bibiotheque" ,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              onTap: (){
               _onitemtapped(2);
               Navigator.pop(context);
              },  
            ),

             ListTile(
              leading: Icon(CupertinoIcons.person),
              selected: _selectedIndex==3,
              selectedColor: MyAppColors.principalcolor,
              title: Text("Profil" ,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              onTap: (){
               _onitemtapped(3);
               Navigator.pop(context);
              },  
            ),

            ListTile(
              leading: Icon(CupertinoIcons.calendar),
              selected: _selectedIndex==4,
              selectedColor: MyAppColors.principalcolor,
              title: Text("Programme Et Emploi" ,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              onTap: (){
               _onitemtapped(4);
               Navigator.pop(context);
              },  
            ),

            ListTile(
              leading: Icon(Icons.notes),
              selected: _selectedIndex==5,
              selectedColor: MyAppColors.principalcolor,
              title: Text("Evaluation" ,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              onTap: (){
               _onitemtapped(5);
               Navigator.pop(context);
              },  
            ),

            ListTile(
              leading: Icon(Icons.notifications),
              selected: _selectedIndex==6,
              selectedColor: MyAppColors.principalcolor,
              title: Text("Notifications" ,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              onTap: (){
               _onitemtapped(6);
               Navigator.pop(context);
              },  
            ),
            ListTile(
              leading: Icon(Icons.messenger_outline),
              selected: _selectedIndex==7,
              selectedColor: MyAppColors.principalcolor,
              title: Text("Doleance" ,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              onTap: (){
               _onitemtapped(7);
               Navigator.pop(context);
              }, 
            ),


            ListTile(
              leading: Icon(Icons.qr_code_scanner),
              selected: _selectedIndex==8,
              selectedColor: MyAppColors.principalcolor,
              title: Text("Presence" ,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              onTap: (){
               _onitemtapped(8);
               Navigator.pop(context);
              },  
            ),

            

             ListTile(
              leading: Icon(CupertinoIcons.phone),
              selected: _selectedIndex==9,
              selectedColor: MyAppColors.principalcolor,
              title: Text("Contact" ,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      
                    ),
              ),
              onTap: (){
               _onitemtapped(9);
               Navigator.pop(context);
              },  
            ),

             ListTile(
              leading: Icon(Icons.logout),
              selectedColor: MyAppColors.principalcolor,
              title: Text("Se Deconnecter" ,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              onTap: (){
               
               Navigator.pop(context);
               Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DeconnectedHomePage()));
              },  
            ),
        ]),
      ),
      body: Center(
        child: routes[_selectedIndex],
       ),
    );
  }
}