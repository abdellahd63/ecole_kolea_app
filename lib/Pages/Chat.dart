import 'dart:io';

import 'package:ecole_kolea_app/APIs.dart';
import 'package:ecole_kolea_app/Componants/MessageFileCard.dart';
import 'package:ecole_kolea_app/Componants/SendedMessageCard.dart';
import 'package:ecole_kolea_app/Constant.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Model/Message.dart';
import 'package:ecole_kolea_app/controllers/SocketController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Chat extends StatefulWidget {
  Chat({super.key, required this.target, required this.Title});
  final Map<String, dynamic> target;
  final String Title;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController messagecontroller=new TextEditingController();
  final SocketController socketController = Get.put(SocketController());
  late IO.Socket socket;
  bool sendButton = false;
  String mysourceID = "";
  String mysourceType = "";
  List<Message> messages=[];
  ImagePicker imagePicker = ImagePicker();
  XFile? file;
  Future<void> connecte() async {
    socket = IO.io(Constant.URL, <String,dynamic>{
      "transports":["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.emit("signin", mysourceID);
    socket.onConnect((data) {
      socket.on("replyMessage", (msg) {
        setMessage(msg["msg"], "destination", msg["path"]);
      }
      );
    });
  }
  void sendMessage(String msg, String targetID, String path){
    setMessage(msg, mysourceType, path);
    socket.emit("message", {
      "msg" : msg,
      "sourceID": mysourceID,
      "targetID": targetID,
      "date": DateTime.now().toString(),
      "sujet": '',
      "source": mysourceType,
      "path": path,
      "type": mysourceType + widget.target["type"],
      "class": '',
    });
  }
  void sendRoomMessage(String msg, String targetID, String path){
    setMessage(msg, mysourceType, path);
    socket.emit("message", {
      "msg" : msg,
      "sourceID": mysourceID,
      "targetID": widget.target["id"],
      "date": DateTime.now().toString(),
      "sujet": '',
      "source": mysourceType,
      "path": path,
      "type": 'class',
    });
  }
  void setMessage(String msg, String type, String path){
    Message message = Message(
        text: msg,
        date: DateTime.now(),
        type: type,
        path: path != null ? path.toString() : ""
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
        type: mysourceType,
        path: file.path
    );
    if(mounted) {
      setState(() {
        messages.add(message);
      });
    }
    String serverPath = await APIs.uploadMyFile(context, file);
    socket.emit("message", {
      "msg" : '',
      "sourceID": mysourceID,
      "targetID": widget.target["id"],
      "date": DateTime.now().toString(),
      "sujet": '',
      "source": mysourceType,
      "path": serverPath,
      "type": mysourceType + widget.target["type"],
      "class": '',
    });
  }
  Future<void> fetchCurrentUserData() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      mysourceID = preferences.getString("id").toString();
      mysourceType = preferences.getString("type").toString();
    });
    connecte();
    // Request chat history when the chat screen is opened
    socket.emit('getChatHistory', {
      "sourceID" : mysourceID,
      "targetID" : widget.target["id"],
      "type" : mysourceType + widget.target["type"],
      "source" : mysourceType,
    });
    // Listen for chat history response from the server
    socket.on('chatHistory', (chatHistory) {
      if (mounted) {
        setState(() {
          // Update messages list with chat history
          if (chatHistory != null) {
            messages = chatHistory.map<Message>((item) => Message.fromJson(item)).toList();
          }
        });
      }
    });
    // Request join room when the chat screen is opened if is a room
    if(widget.target["type"] == 'classe'){
      socket.emit('joinRoom', widget.target["id"]);
    }
  }
  @override
  void initState(){
    super.initState();
    fetchCurrentUserData();
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
                alignment: (element.expediteurID !=  null ? (element.expediteurID == mysourceID)  : (element.type == mysourceType)) ? Alignment.centerRight : Alignment.centerLeft,
                child: element.path.isNotEmpty ?
                  MessageFileCard(
                      type: element.expediteurID !=  null ? (element.expediteurID == mysourceID) : (element.type == mysourceType),
                      path: element.path
                  ) :
                  SendedMessageCard(
                      text: element.text ?? '',
                      time: element.date.toString().substring(10,16),
                      type: element.expediteurID !=  null ? (element.expediteurID == mysourceID)  : (element.type == mysourceType),
                      fullname: element.fullname
                  ),
              ),
              itemComparator: (Message message1, Message message2) =>
                  message1.date.compareTo(message2.date),
          )),
          Container(
            padding: EdgeInsets.symmetric(vertical: 05),
           decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: MyAppColors.dimopacityvblue,
           ),
            
            child: mysourceType == "etudiant" ?
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
                    if (!sendButton) {
                      file = await imagePicker.pickImage(source: ImageSource.gallery);
                      if (file == null) {
                        showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.info(
                            message: "le fichier n'a pas été téléchargé correctement, vous devez le joindre à nouveau",
                          ),
                        );
                        return;
                      } else {
                        await sendIMG(File(file!.path));
                      }
                    } else {
                      if (messagecontroller.text.isNotEmpty && sendButton) {
                        widget.target["type"] == "classe" ?
                          sendRoomMessage(
                            messagecontroller.text,
                            widget.target["id"],
                            "",
                          ) :
                          sendMessage(
                            messagecontroller.text,
                            widget.target["id"],
                            "",
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
                    onTap: () async {
                      if (!sendButton) {
                        file = await imagePicker.pickImage(source: ImageSource.gallery);
                        if (file == null) {
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.info(
                              message: "le fichier n'a pas été téléchargé correctement, vous devez le joindre à nouveau",
                            ),
                          );
                          return;
                        } else {
                          await sendIMG(File(file!.path));
                        }
                      } else {
                        if (messagecontroller.text.isNotEmpty && sendButton) {
                          widget.target["type"] == "classe" ?
                          sendRoomMessage(
                            messagecontroller.text,
                            widget.target["id"],
                            "",
                          ) :
                          sendMessage(
                            messagecontroller.text,
                            widget.target["id"],
                            "",
                          );
                          messagecontroller.clear();
                          setState(() {
                            sendButton = false;
                          });
                        }
                      }
                    },                  )
              ),
            ),
          )
      ]),
    );
  }
}