import 'package:ecole_kolea_app/Pages/Chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget{
  String imgpath;
  String title;
  String type;
  String TargetID;
  MessageCard({
    super.key,
    required this.imgpath,
    required this.title,
    required this.type,
    required this.TargetID
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:10.0),
      child: InkWell(
        child: ListTile(
          leading: Image.asset(imgpath),
          title: Text(title),
          subtitle: Text(type),
        ),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Chat(target: {"id":TargetID, "type":type}, Title: title)));
        },
      ),
    );
  }
}