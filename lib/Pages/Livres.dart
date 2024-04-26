import 'package:ecole_kolea_app/APIs.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Model/CategorieModel.dart';
import 'package:ecole_kolea_app/Model/Document.dart';
import 'package:ecole_kolea_app/controllers/Searching.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Livres extends StatelessWidget {
  Livres({super.key, required this.Categorie, required this.name});
  final String Categorie;
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
                future: APIs.GetAllDocumentsByIDCategorie(context, Categorie),
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
                    return Center(child: Text('Aucun document disponible.'));
                  } else {
                    List<Document> documentData = List<Document>.from(snapshot.data!.map<Document>((item) => Document.fromJson(item)));
                    if(searching.DocumentSearchingtextController.text.isEmpty) {
                      searching.DocumentFilteredList.value =
                      List<Document>.from(documentData);
                    }
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: SearchBar(
                            hintText: 'Search for your a document',
                            hintStyle: MaterialStateProperty.resolveWith((states) => TextStyle(fontSize: 12)),
                            textStyle: MaterialStateProperty.resolveWith((states) => TextStyle(
                                fontSize: 12,
                                color: MyAppColors.principalcolor
                            )),
                            controller: searching.DocumentSearchingtextController,
                            onChanged: (value){
                              if (searching.DocumentSearchingtextController.text.isEmpty) {
                                searching.DocumentSearchingtextController.clear();
                                searching.DocumentFilteredList.value = List<Document>.from(documentData);
                              }
                              if (searching.DocumentSearchingtextController.text.isNotEmpty) {
                                searching.DocumentFilteredList.value = documentData.where((document) {
                                  return document.nom_document.toLowerCase().contains(searching.DocumentSearchingtextController.text.toLowerCase());
                                }).toList();
                              }
                            },
                            shadowColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
                          ),
                        ),
                        Obx(() =>ListView.builder(
                          shrinkWrap: true,
                          itemCount: searching.DocumentFilteredList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                tileColor: MyAppColors.dimopacityvblue,
                                title: Text('${searching.DocumentFilteredList[index].nom_document}'),
                                trailing: GestureDetector(
                                  onTap: () {
                                    if(searching.DocumentFilteredList[index].lien_document.toString().isNotEmpty){
                                      final Uri uri = Uri.parse(searching.DocumentFilteredList[index].lien_document.toString());
                                      _launchUrl(uri);
                                    }
                                  },
                                  child: Icon(Icons.open_in_new),
                                ),
                              ),
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
Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}