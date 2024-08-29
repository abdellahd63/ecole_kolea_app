import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:flutter/material.dart';

class Filieresdescription extends StatelessWidget {
  String title;
  String description;
  Filieresdescription({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: MyAppColors.dimopacityvblue,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: ExpansionTile(
                  shape: const Border(),
                  title: Text(title,
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.w600),
                      ),
                  children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0,right: 20.0,bottom: 20.0),
                        child: Text(
                          description,
                          textAlign: TextAlign.justify,
                          softWrap: true,
                          style: TextStyle(color: Colors.grey[700], fontSize: 15,fontWeight: FontWeight.w500),
                        ),
                      ),
                  ],    
                  ),
              );
  }
}