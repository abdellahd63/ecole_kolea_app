import 'dart:io';

import 'package:ecole_kolea_app/Constant.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageFileCard extends StatelessWidget {
  const MessageFileCard({super.key, required this.type, required this.path});
  final bool type;
  final String path;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: type ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Container(
          height: MediaQuery.of(context).size.height/2.3,
          width: MediaQuery.of(context).size.width/1.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: type ? MyAppColors.principalcolor : MyAppColors.gray400
          ),
          child: Card(
            margin: EdgeInsets.all(3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
            ),
            child: type == "source" ? Image.file(
              File(path),
              fit: BoxFit.cover,
            ) :
            Image.network(
              Constant.URL+"/files/"+path.toString(),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

