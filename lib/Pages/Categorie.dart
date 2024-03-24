import 'package:ecole_kolea_app/APIs.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Model/CategorieModel.dart';
import 'package:ecole_kolea_app/Pages/Livres.dart';
import 'package:flutter/material.dart';

class Categorie extends StatelessWidget {
  Categorie({super.key, required this.bibliotheque, required this.name});
  final String bibliotheque;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${name}',
          textAlign: TextAlign.center,
          softWrap: true,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: MyAppColors.principalcolor,
            fontSize: 18,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        iconTheme: IconThemeData(color: MyAppColors.principalcolor),
      ),
      backgroundColor: MyAppColors.whitecolor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              FutureBuilder<List<dynamic>>(
                future: APIs.GetAllCategoriesByIDBibliotheques(context, bibliotheque),
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
                    return Text('Aucune categorie disponible.');
                  } else {
                    List<CategorieModel> categorieData = List<CategorieModel>.from(snapshot.data!.map<CategorieModel>((item) => CategorieModel.fromJson(item)));
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: categorieData.length,
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
                                Text(categorieData[index].libelle,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600
                                  ),),
                                Icon(Icons.keyboard_arrow_right_outlined),
                              ],
                            ),
                          ),
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Livres(Categorie: categorieData[index].id.toString(), name: categorieData[index].libelle.toString())));
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