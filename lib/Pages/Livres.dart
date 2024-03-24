import 'package:ecole_kolea_app/APIs.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Model/CategorieModel.dart';
import 'package:ecole_kolea_app/Model/Document.dart';
import 'package:flutter/material.dart';

class Livres extends StatelessWidget {
  Livres({super.key, required this.Categorie, required this.name});
  final String Categorie;
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
                    return Text('Aucun document disponible.');
                  } else {
                    List<Document> documentData = List<Document>.from(snapshot.data!.map<Document>((item) => Document.fromJson(item)));
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: documentData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            tileColor: MyAppColors.dimopacityvblue,
                            title: Text('${documentData[index].nom_document}'),
                            subtitle: Row(
                              children: [
                                Text(
                                  documentData[index].disponibilite != 0
                                      ? "disponible : "
                                      : "indisponible",
                                  style: TextStyle(
                                    color: documentData[index].disponibilite != 0
                                        ? Colors.green
                                        : Colors.red
                                  ),
                                ),
                                if(documentData[index].disponibilite > 0)
                                Text('${documentData[index].disponibilite}',
                                  style: TextStyle(
                                      color: Colors.green
                                  ),
                                ),
                              ],
                            ),
                            trailing: Icon(Icons.download),
                          ),
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