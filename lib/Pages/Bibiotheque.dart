import 'package:ecole_kolea_app/APIs.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Model/Bibliotheque.dart';
import 'package:ecole_kolea_app/Pages/Categorie.dart';
import 'package:flutter/material.dart';

class Bibiotheque extends StatelessWidget {
  Bibiotheque({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: MyAppColors.whitecolor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Bibliotheque",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: MyAppColors.principalcolor,
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,

                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              FutureBuilder<List<dynamic>>(
                future: APIs.GetAllBibliotheques(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(),
                            ],
                          ),)
                    ); // or any loading indicator
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('Aucune bibliotheque disponible.');
                  } else {
                    List<Bibliotheque> bibliothequeData = List<Bibliotheque>.from(snapshot.data!.map<Bibliotheque>((item) => Bibliotheque.fromJson(item)));
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: bibliothequeData.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                            decoration: BoxDecoration(
                                color: MyAppColors.dimopacityvblue,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(bibliothequeData[index].libelle,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600
                                  ),),
                                Icon(Icons.keyboard_arrow_right_outlined),
                              ],
                            ),
                          ),
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Categorie(bibliotheque: bibliothequeData[index].id.toString(), name: bibliothequeData[index].libelle.toString())));
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}