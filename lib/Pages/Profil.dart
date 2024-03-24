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
    return FutureBuilder<String>(
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
              } else if (!snapshot.hasData || snapshot.data == null) {
                return Center(child: Text('No data available.'));
              } else {
                Map<String, dynamic> userData = snapshot.data;
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //pic
                        Image.asset('lib/Assets/Images/profilpic.jpg'),
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
                                  color: MyAppColors.principalcolor,
                                  fontSize: 20,
                                ),
                              ),
                              if(mysourceType == 'enseignant')
                                Text('${userData['grade']}',
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: MyAppColors.principalcolor,
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
                                height: 45,
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                decoration: BoxDecoration(
                                  color: MyAppColors.dimopacityvblue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text( mysourceType == 'user' ? '${userData['username']}' : '${userData['email']}',
                                      style: TextStyle(
                                          color: MyAppColors.principalcolor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14
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
                                  height: 45,
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                  decoration: BoxDecoration(
                                    color: MyAppColors.dimopacityvblue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),

                                  child: mysourceType == 'user'
                                      ? Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
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
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Née le ',
                                              style: TextStyle(
                                                  color: MyAppColors.principalcolor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14
                                              ),
                                            ),
                                            Text('${userData['date_naissance']}',
                                              style: TextStyle(
                                                  color: MyAppColors.principalcolor,

                                                  fontSize: 14
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
                                        height: 45,
                                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                        decoration: BoxDecoration(
                                          color: MyAppColors.dimopacityvblue,
                                          borderRadius: BorderRadius.circular(10),
                                        ),

                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Cycle ',
                                              style: TextStyle(
                                                  color: MyAppColors.principalcolor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14
                                              ),
                                            ),

                                            Text('Master 1er annee',
                                              style: TextStyle(
                                                  color: MyAppColors.principalcolor,

                                                  fontSize: 14
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:10.0, vertical: 5),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 45,
                                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                        decoration: BoxDecoration(
                                          color: MyAppColors.dimopacityvblue,
                                          borderRadius: BorderRadius.circular(10),
                                        ),

                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Filière ',
                                              style: TextStyle(
                                                  color: MyAppColors.principalcolor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14
                                              ),
                                            ),
                                            Text('E-Banking',
                                              style: TextStyle(
                                                  color: MyAppColors.principalcolor,
                                                  fontSize: 14
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal:10.0, vertical: 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Container(
                                              height: 45,
                                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                              decoration: BoxDecoration(
                                                color: MyAppColors.dimopacityvblue,
                                                borderRadius: BorderRadius.circular(10),

                                              ),

                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text('Section ',
                                                    style: TextStyle(
                                                        color: MyAppColors.principalcolor,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 14
                                                    ),
                                                  ),

                                                  Text('A',
                                                    style: TextStyle(
                                                        color: MyAppColors.principalcolor,

                                                        fontSize: 14
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )),
                                        SizedBox(width: 5,),
                                        Expanded(child: Container(
                                          height: 45,
                                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                          decoration: BoxDecoration(
                                            color: MyAppColors.dimopacityvblue,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('Groupe ',
                                                style: TextStyle(
                                                    color: MyAppColors.principalcolor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14
                                                ),
                                              ),
                                              Text('${userData['groupe']}',
                                                style: TextStyle(
                                                    color: MyAppColors.principalcolor,
                                                    fontSize: 14
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
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
    );
  }
}