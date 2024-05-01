import 'package:ecole_kolea_app/APIs.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Model/CategorieModel.dart';
import 'package:ecole_kolea_app/Pages/Livres.dart';
import 'package:ecole_kolea_app/controllers/Searching.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Categorie extends StatelessWidget {
  Categorie({super.key, required this.bibliotheque, required this.name});
  final String bibliotheque;
  final String name;
  @override
  Widget build(BuildContext context) {
    final searching = Get.put(Searching());
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
                    return Center(child: Text('Aucune categorie disponible.'));
                  } else {
                    List<CategorieModel> categorieData = List<CategorieModel>.from(snapshot.data!.map<CategorieModel>((item) => CategorieModel.fromJson(item)));
                    if(searching.CategorieSearchingtextController.text.isEmpty) {
                      searching.CategorieFilteredList.value =
                      List<CategorieModel>.from(categorieData);
                    }
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: SearchBar(
                            hintText: 'Search for your a categorie',
                            hintStyle: MaterialStateProperty.resolveWith((states) => TextStyle(fontSize: 12)),
                            textStyle: MaterialStateProperty.resolveWith((states) => TextStyle(
                                fontSize: 12,
                                color: MyAppColors.principalcolor
                            )),
                            controller: searching.CategorieSearchingtextController,
                            onChanged: (value){
                              if (searching.CategorieSearchingtextController.text.isEmpty) {
                                searching.CategorieSearchingtextController.clear();
                                searching.CategorieFilteredList.value = List<CategorieModel>.from(categorieData);
                              }
                              if (searching.CategorieSearchingtextController.text.isNotEmpty) {
                                searching.CategorieFilteredList.value = categorieData.where((categorie) {
                                  return categorie.libelle.toLowerCase().contains(searching.CategorieSearchingtextController.text.toLowerCase());
                                }).toList();
                              }
                            },
                            shadowColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
                          ),
                        ),
                        Obx(() =>ListView.builder(
                          shrinkWrap: true,
                          itemCount: searching.CategorieFilteredList.length,
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
                                    Text(searching.CategorieFilteredList[index].libelle,
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
                        )),
                      ],
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