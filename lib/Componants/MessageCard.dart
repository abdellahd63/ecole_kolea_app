import 'package:ecole_kolea_app/Pages/Chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget{
  String imgpath;
  String title;
  String subTitle;
  String UserID;
  MessageCard({
    super.key,
    required this.imgpath,
    required this.title,
    required this.subTitle,
    required this.UserID
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:10.0),
      child: InkWell(
        child: ListTile(
          leading: Image.asset(imgpath),
          title: Text(title),
          subtitle: Text(subTitle),
        ),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Chat(targetID: UserID, Title: title)));
        },
      ),
    );
  }
}