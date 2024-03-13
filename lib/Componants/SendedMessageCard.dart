import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Pages/Chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SendedMessageCard extends StatelessWidget{
  String text;
  String time;
  String type;
  SendedMessageCard({
    super.key,
    required this.text,
    required this.time,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: type == "source" ? EdgeInsets.only(left: 25 , bottom: 5, right: 10) :EdgeInsets.only(right:25 ,bottom: 5, left:10),
        child: Column(
          crossAxisAlignment: type == "source" ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
            ),
            color: type == "source" ? MyAppColors.principalcolor : MyAppColors.whitecolor,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Text(text,
                    textAlign: TextAlign.left,
                      style: TextStyle(
                      color: type == "source" ? MyAppColors.whitecolor : MyAppColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
            Padding(
              padding: type == "source" ? const EdgeInsets.only(right: 10) : const EdgeInsets.only(left: 10),
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 8,
                  color: MyAppColors.gray400,
                ),
              ),
            ),
        ],
      )
    );
  }
}