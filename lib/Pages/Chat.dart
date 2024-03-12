import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Model/Message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class Chat extends StatefulWidget {
  Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<Message> messages=[
    Message(text: "Bonjour", date: DateTime.now().subtract(Duration(minutes: 1)), issentbyme: true),
    Message(text: "Bonjour", date: DateTime.now().subtract(Duration(minutes: 1)), issentbyme: false),
    Message(text: "Cava !", date: DateTime.now().subtract(Duration(minutes: 1)), issentbyme: true),
    Message(text: "Tres bien hmdlh", date: DateTime.now().subtract(Duration(minutes: 1)), issentbyme: false),
    Message(text: "Monsieur je veux savoir ou je peux trouver des sujets d'examen", date: DateTime.now().subtract(Duration(minutes: 1)), issentbyme: true),
    Message(text: "ici : www.asdfg.com", date: DateTime.now().subtract(Duration(minutes: 1)), issentbyme: false),
    Message(text: "Merci", date: DateTime.now().subtract(Duration(minutes: 1)), issentbyme: true),
    Message(text: "Bonne nuit", date: DateTime.now().subtract(Duration(minutes: 1)), issentbyme: false)

  ];

  TextEditingController messagecontroller=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(
        backgroundColor: MyAppColors.whitecolor,
        leading: InkWell(child: Icon(Icons.arrow_back_ios, color: MyAppColors.principalcolor,), onTap: () {
          Navigator.pop(context);
        },),
        title: Text("Mme Tabti", style: TextStyle(color: MyAppColors.principalcolor),),
      ),

      backgroundColor: MyAppColors.whitecolor,
      body: Column(
        children: [
          Expanded(
            child: GroupedListView<Message, DateTime>(
              reverse: true,
              order: GroupedListOrder.DESC,
              elements: messages, 
              groupBy: (Message element)=>DateTime(
                element.date.year,
                element.date.month,
                element.date.day
              ),
              groupHeaderBuilder: (element) => SizedBox(
                height: 40,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      DateFormat.yMMMd().format(element.date),
                      style: TextStyle(color: MyAppColors.black),
                    ),
                  ),
                ),
              ),
              itemBuilder: (context, element) => Align(
                alignment: element.issentbyme ? Alignment.centerRight : Alignment.centerLeft,
                child: Card(
                  color: element.issentbyme ? MyAppColors.principalcolor : MyAppColors.whitecolor,
                  margin: element.issentbyme ? EdgeInsets.only(left: 25 , bottom: 10, right: 10) :EdgeInsets.only(right:25 ,bottom: 10, left:10),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(element.text,
                      style: TextStyle(
                        color: element.issentbyme ? MyAppColors.whitecolor : MyAppColors.black,
                      ),
                    ),
                    ),
                ),
              ),

          )),
          Container(
            padding: EdgeInsets.symmetric(vertical: 05),
           decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: MyAppColors.dimopacityvblue,
           ),
            
            child: TextField(
              autocorrect: true,
              controller: messagecontroller,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(12),
                hintText: " Message",
                
                suffixIcon: InkWell(
                  child: Icon(Icons.send, color: MyAppColors.principalcolor,),
                  onTap: (){
                    setState(() {
                      if(messagecontroller.text.isNotEmpty){
                       messages.add(new Message(text: messagecontroller.text, date: DateTime.now(), issentbyme: true));
                       
                    }
                    });
                   
                    
                  },
                  )
              ),

              
            ),
          )
      ]),
    );
  }
}