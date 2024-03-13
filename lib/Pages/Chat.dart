import 'dart:io';

import 'package:ecole_kolea_app/APIs.dart';
import 'package:ecole_kolea_app/Auth/AuthContext.dart';
import 'package:ecole_kolea_app/Componants/MessageFileCard.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Model/Message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Chat extends StatefulWidget {
  Chat({super.key, required this.targetID, required this.Title});
  final String targetID;
  final String Title;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController messagecontroller=new TextEditingController();
  late IO.Socket socket;
  bool sendButton = false;
  String mysourceID = "";
  String mysourceType = "";
  List<Message> messages=[];
  ImagePicker imagePicker = ImagePicker();
  XFile? file;
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
        setMessage(msg["msg"], "destination", msg["path"]);
      }
      );
    });
  }
  void sendMessage(String msg, String sourceID, String targetID, String path){
    setMessage(msg, "source", path);
    socket.emit("message", {
      "msg" : msg,
      "sourceID": sourceID,
      "targetID": targetID,
      "path": path
    });
  }
  void setMessage(String msg, String type, String path){
    Message message = Message(
        text: msg,
        date: DateTime.now(),
        type: type,
        path: path
    );
    if(mounted) {
      setState(() {
        messages.add(message);
      });
    }
  }
  Future<void> sendIMG(File file) async {
    Message message = Message(
        date: DateTime.now(),
        type: "source",
        path: file.path
    );
    if(mounted) {
      setState(() {
        messages.add(message);
      });
    }
    String serverPath = await APIs.uploadMyFile(context, file);
    socket.emit("message", {
      "sourceID": mysourceID,
      "targetID": widget.targetID,
      "path": serverPath
    });
  }
  @override
  void initState() {
    super.initState();
    final AuthContext authContext = context.read<AuthContext>();
    final Map<String, dynamic>? userData = authContext.state.user;
    setState(() {
      mysourceID = userData?['id'].toString() ?? "";
    });
    setState(() {
      mysourceType = userData?['type'].toString() ?? "";
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
        title: Text(widget.Title, style: TextStyle(color: MyAppColors.principalcolor),),
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
                    child: Column(
                        children: [
                          if (element.path == null)
                            Text(element.text ?? '',
                              textAlign: element.type == "source" ? TextAlign.right : TextAlign.left,
                              style: TextStyle(
                                color: element.type == "source" ? MyAppColors.whitecolor : MyAppColors.black,
                              ),
                            )
                          else
                            MessageFileCard(
                              type: element.type,
                              path: element.path
                            ),
                          Text(element.date.toString().substring(10,16),
                            textAlign: element.type == "source" ? TextAlign.right : TextAlign.left,
                            style: TextStyle(
                              fontSize: 12,
                              color: element.type == "source" ? MyAppColors.whitecolor : MyAppColors.black,
                            ),
                          ),
                        ],
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
            
            child: mysourceType == "student" ?
            TextField(
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
                hintText: "sélectionner un message",
                suffixIcon: InkWell(
                  child: sendButton ? Icon(Icons.send, color: MyAppColors.principalcolor,) : Icon(Icons.upload_file, color: MyAppColors.principalcolor,),
                  onTap: () async {
                    if(!sendButton){
                      file = await imagePicker.pickImage(source: ImageSource.gallery);
                      if(file == null){
                        showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.info(
                            message: "le fichier n\'a pas été téléchargé correctement, vous devez le joindre à nouveau",
                          ),
                        );
                        return;
                      }else{
                        await sendIMG(File(file!.path));
                      }
                    }else{
                      if(messagecontroller.text.isNotEmpty &&
                          sendButton){
                        sendMessage(
                            messagecontroller.text,
                            mysourceID,
                            widget.targetID,
                            ""
                        );
                        messagecontroller.clear();
                        setState(() {
                          sendButton = false;
                        });
                      }
                    }
                  },
                  )
              ),
            ) :
            TextField(
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
                  hintText: "Entrez votre message",
                  suffixIcon: InkWell(
                    child: sendButton ? Icon(Icons.send, color: MyAppColors.principalcolor,) : Icon(Icons.upload_file, color: MyAppColors.principalcolor,),
                    onTap: (){
                      setState(() async {
                        if(!sendButton){
                          file = await imagePicker.pickImage(source: ImageSource.gallery);
                          if(file == null){
                            showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.info(
                                message: "le fichier n\'a pas été téléchargé correctement, vous devez le joindre à nouveau",
                              ),
                            );
                            return;
                          }else{
                            await sendIMG(File(file!.path));
                          }
                        }else{
                          if(messagecontroller.text.isNotEmpty &&
                              sendButton){
                            sendMessage(
                                messagecontroller.text,
                                mysourceID,
                                widget.targetID,
                                ""
                            );
                            messagecontroller.clear();
                            setState(() {
                              sendButton = false;
                            });
                          }
                        }                      });
                    },
                  )
              ),
            ),
          )
      ]),
    );
  }
}