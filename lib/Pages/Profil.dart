import 'package:ecole_kolea_app/APIs.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profil extends StatelessWidget {
  const Profil({super.key});

  @override
  Widget build(BuildContext context) {
    Future<String> fetchData() async {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      return preferences.getString("type") ?? '';
    }
    return Scaffold(
      backgroundColor: MyAppColors.whitecolor,
      body: FutureBuilder<String>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            String mysourceType = snapshot.data!;
            return FutureBuilder<dynamic>(
              future: mysourceType == 'user'
                  ? APIs.GetUserByID(context)
                  : (mysourceType == 'enseignant'
                  ? APIs.GetenseignantByID(context)
                  : APIs.GetStudentByID(context)),
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No data available.'));
                } else{
                  Map<String, dynamic> userData = snapshot.data;
                  return Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //pic
                          Image.asset('lib/Assets/Images/profilpic.png', height: 120,),
                          //name
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical:10.0),
                            child: Column(
                              children: [
                                if(mysourceType != 'user')
                                  Text('${userData['nom']} ${userData['prenom']}',
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: MyAppColors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                if(mysourceType == 'enseignant')
                                  Text('${userData['grade']}',
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: MyAppColors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                              ],
                            ),
                          ),
      
                          //info
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:15.0 , vertical: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text("Informations",
                                        textAlign: TextAlign.left,
                                        softWrap: true,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: MyAppColors.principalcolor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                 
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                  decoration: BoxDecoration(
                                    
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 15),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(360),
                                          color: MyAppColors.whitecolor, 
                                          boxShadow: [BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0, 3), // changes position of shadow
                                          ),]
                                        ),
                                        child: Icon(Icons.email,color: MyAppColors.principalcolor, size: 25,),
                                      ),
                                      Text( mysourceType == 'user' ? '${userData['username']}' : '${userData['email']}',
                                        style: TextStyle(
                                            color: MyAppColors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(horizontal:10.0, vertical: 5),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    
                                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                    
      
                                    child: mysourceType == 'user'
                                        ? Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(right: 15),
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(360),
                                                  color: MyAppColors.whitecolor, 
                                                  boxShadow: [BoxShadow(
                                                    color: Colors.grey.withOpacity(0.3),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: Offset(0, 3), // changes position of shadow
                                                  ),]
                                                ),
                                                child: Icon(Icons.badge,size: 25,color: MyAppColors.principalcolor, ),
                                              ),
                                              Text('${userData['role']}',
                                                style: TextStyle(
                                                    color: MyAppColors.principalcolor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14
                                                ),
                                              )
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(right: 15),
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(360),
                                                color: MyAppColors.whitecolor, 
                                                boxShadow: [BoxShadow(
                                                  color: Colors.grey.withOpacity(0.3),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0, 3), // changes position of shadow
                                                ),]
                                              ),
                                              child: Icon(Icons.date_range,size: 25,color: MyAppColors.principalcolor, ),
                                            ),
                                              
                                              Text('${userData['date_naissance']}',
                                                style: TextStyle(
                                                    color: MyAppColors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16
                                                ),
                                              )
                                            ],
                                          ),
                                  )
                              ),
                              if(mysourceType == 'etudiant')
                                Column(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.symmetric(horizontal:10.0, vertical: 5),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                      
                                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                          
      
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(right: 15),
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(360),
                                                color: MyAppColors.whitecolor, 
                                                boxShadow: [BoxShadow(
                                                  color: Colors.grey.withOpacity(0.3),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0, 3), 
                                                ),]
                                              ),
                                              child: Icon(Icons.star,size: 25,color: MyAppColors.principalcolor, ),
                                            ),
                                              Text('${userData["cycle"].toString()}',
                                                style: TextStyle(
                                                    color: MyAppColors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(horizontal:10.0, vertical: 5),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                         
                                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                          
      
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(right: 15),
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(360),
                                                color: MyAppColors.whitecolor, 
                                                boxShadow: [BoxShadow(
                                                  color: Colors.grey.withOpacity(0.3),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0, 3), // changes position of shadow
                                                ),]
                                              ),
                                              child: Icon(Icons.school,size: 25,color: MyAppColors.principalcolor, ),
                                            ),
                                              Text('${userData["filiereName"].toString()}',
                                                style: TextStyle(
                                                    color: MyAppColors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:10.0, vertical: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                    
                                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                            
                                                
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                margin: EdgeInsets.only(right: 15),
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(360),
                                                  color: MyAppColors.whitecolor, 
                                                  boxShadow: [BoxShadow(
                                                    color: Colors.grey.withOpacity(0.3),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: Offset(0, 3), // changes position of shadow
                                                  ),]
                                                ),
                                                child: Icon(Icons.segment ,size: 25,color: MyAppColors.principalcolor, ),
                                              ),
                                                Text('${userData["sectionName"].toString()}',
                                                  style: TextStyle(
                                                      color: MyAppColors.black,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 16
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 5,),
                                          Container(
                                           
                                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                            
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                margin: EdgeInsets.only(right: 15),
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(360),
                                                  color: MyAppColors.whitecolor, 
                                                  boxShadow: [BoxShadow(
                                                    color: Colors.grey.withOpacity(0.3),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: Offset(0, 3), // changes position of shadow
                                                  ),]
                                                ),
                                                child: Icon(Icons.group,size: 25,color: MyAppColors.principalcolor, ),
                                              ),
                                                Text('${userData['groupeName']}',
                                                  style: TextStyle(
                                                      color: MyAppColors.black,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 16
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
      
                        ],
                      ),
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}