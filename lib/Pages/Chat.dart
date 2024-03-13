import 'package:ecole_kolea_app/Auth/AuthContext.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Model/Message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Chat extends StatefulWidget {
  Chat({super.key, required this.UserID});
  final String UserID;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController messagecontroller=new TextEditingController();
  late IO.Socket socket;
  bool sendButton = false;
  String mysourceID = "";
  List<Message> messages=[];

  void connecte(){
    socket = IO.io("http://192.168.1.100:8000", <String,dynamic>{
      "transports":["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.emit("signin", mysourceID);
    socket.onConnect((data) {
      print("connected");
      socket.on("destinationMessage", (msg) {
        print(msg);
        setMessage(msg["msg"], "destination");
      }
      );
    });
  }
  void sendMessage(String msg, String sourceID, String targetID){
    setMessage(msg, "source");
    socket.emit("message", {
      "msg" : msg,
      "sourceID": sourceID,
      "targetID": targetID
    });
  }
  void setMessage(String msg, String type){
    Message message = Message(text: msg, date: DateTime.now(), type: type);
    if(mounted) {
      setState(() {
        messages.add(message);
      });
    }
  }
  @override
  void initState() {
    super.initState();
    final AuthContext authContext = context.read<AuthContext>();
    final Map<String, dynamic>? userData = authContext.state.user;
    setState(() {
      mysourceID = userData?['id'].toString() ?? "";
    });
    connecte();
  }
  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }
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
                alignment: element.type == "source" ? Alignment.centerRight : Alignment.centerLeft,
                child: Card(
                  color: element.type == "source" ? MyAppColors.principalcolor : MyAppColors.whitecolor,
                  margin: element.type == "source" ? EdgeInsets.only(left: 25 , bottom: 10, right: 10) :EdgeInsets.only(right:25 ,bottom: 10, left:10),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(element.text,
                      style: TextStyle(
                        color: element.type == "source" ? MyAppColors.whitecolor : MyAppColors.black,
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
              onChanged: (val){
                if(val.length > 0){
                  setState(() {
                    sendButton = true;
                  });
                }else{
                  setState(() {
                    sendButton = false;
                  });
                }
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(12),
                hintText: "Message",
                suffixIcon: InkWell(
                  child: sendButton ? Icon(Icons.send, color: MyAppColors.principalcolor,) : Icon(Icons.mic, color: MyAppColors.principalcolor,),
                  onTap: (){
                    setState(() {
                      if(messagecontroller.text.isNotEmpty && sendButton){
                        sendMessage(
                            messagecontroller.text,
                            mysourceID,
                            widget.UserID
                        );
                       messagecontroller.clear();
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