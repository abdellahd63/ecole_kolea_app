import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Pages/Chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SendedMessageCard extends StatelessWidget{
  String text;
  String time;
  bool type;
  String? fullname;
  SendedMessageCard({
    super.key,
    required this.text,
    required this.time,
    required this.type,
    this.fullname
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: type ? EdgeInsets.only(left: 25 , bottom: 5, right: 10) :EdgeInsets.only(right:25 ,bottom: 5, left:10),
        child: Column(
          crossAxisAlignment: type ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Padding(
              padding: type ? const EdgeInsets.only(right: 10) : const EdgeInsets.only(left: 10),
              child: Text(
                fullname ?? '',
                style: TextStyle(
                  fontSize: 8,
                  color: MyAppColors.gray400,
                ),
              ),
            ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
            ),
            color: type ? MyAppColors.principalcolor : MyAppColors.whitecolor,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Text(text,
                    textAlign: TextAlign.left,
                      style: TextStyle(
                      color: type ? MyAppColors.whitecolor : MyAppColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
            Padding(
              padding: type ? const EdgeInsets.only(right: 10) : const EdgeInsets.only(left: 10),
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