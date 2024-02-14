
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Pages/Contact.dart';
import 'package:ecole_kolea_app/Pages/Filiere.dart';
import 'package:ecole_kolea_app/Pages/Login.dart';
import 'package:ecole_kolea_app/Pages/Presentation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeconnectedHomePage extends StatefulWidget {
  const DeconnectedHomePage({super.key});

  @override
  State<DeconnectedHomePage> createState() => _DeconnectedHomePageState();
}

class _DeconnectedHomePageState extends State<DeconnectedHomePage> {

  int _selectedIndex=0;

    static  List<Widget> routes=[ const Presentation(), const Filiere(),const Contact()];

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
              leading: Icon(CupertinoIcons.phone),
              selected: _selectedIndex==2,
              selectedColor: MyAppColors.principalcolor,
              title: Text("Contact" ,
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
              leading: Icon(Icons.login),
              selectedColor: MyAppColors.principalcolor,
              title: Text("Se Connecter" ,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              onTap: (){
               
               Navigator.pop(context);
               Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login()));
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