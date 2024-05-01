import 'dart:io';

import 'package:ecole_kolea_app/APIs.dart';
import 'package:ecole_kolea_app/Componants/MessageFileCard.dart';
import 'package:ecole_kolea_app/Componants/SendedMessageCard.dart';
import 'package:ecole_kolea_app/Constant.dart';
import 'package:ecole_kolea_app/Constantes/Colors.dart';
import 'package:ecole_kolea_app/Model/Message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
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
  late IO.Socket socket;
  bool sendButton = false;
  String mysourceID = "";
  String mysourceType = "";
  List<Message> messages=[];
  ImagePicker imagePicker = ImagePicker();
  XFile? file;
  bool loading = true;

  void sendMessage(String msg, String targetID, String path){
    setMessage(msg, mysourceType, path);
    socket.emit("message", {
      "msg" : msg,
      "sourceID": mysourceID,
      "targetID": targetID,
      "targetType": widget.target["type"],
      "date": DateTime.now().toString(),
      "sujet": '',
      "source": mysourceType,
      "path": path,
      "type": mysourceType + widget.target["type"],
      "class": '',
    });
    socket.emit('notification', {
      "msg" : msg,
      "sourceID": mysourceID,
      "targetID": targetID,
      "targetType": widget.target["type"],
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
    socket.emit('notification', {
      "msg" : msg,
      "sourceID": mysourceID,
      "targetID": widget.target["id"],
      "date": DateTime.now().toString(),
      "sujet": '',
      "source": mysourceType,
      "path": path,
      "type": 'class',
      "class": '',
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
        messages.insert(0,message);
      });
    }
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  Future<void> sendIMG(File file) async {
    Message message = Message(
        date: DateTime.now(),
        type: mysourceType,
        path: file.path
    );
    if(mounted) {
      setState(() {
        messages.insert(0,message);
      });
    }
    String serverPath = await APIs.uploadMyFile(context, file);
    socket.emit("message", {
      "msg" : '',
      "sourceID": mysourceID,
      "targetID": widget.target["id"],
      "targetType": widget.target["type"],
      "date": DateTime.now().toString(),
      "sujet": '',
      "source": mysourceType,
      "path": serverPath,
      "type": mysourceType + widget.target["type"],
      "class": '',
    });
  }
  Future<void> connecte() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      mysourceID = preferences.getString("id").toString();
      mysourceType = preferences.getString("type").toString();
    });
    socket = IO.io(Constant.URL, <String,dynamic>{
      "transports":["websocket"],
      "autoConnect": false,
      'force new connection': true,
    });
    socket.connect();
    socket.on("connect_error", (err) {
       // some additional context, for example the XMLHttpRequest object
        print(err);
    });
    socket.emit("openchat", mysourceID+mysourceType+widget.target["id"]+widget.target["type"]);
    // Request chat history when the chat screen is opened
    socket.emit('getChatHistory', {
      "sourceID" : mysourceID,
      "targetID" : widget.target["id"],
      "targetType": widget.target["type"],
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
      loading = false;
    });
    // Listen for reply message response from the server
    socket.onConnect((data) {
      socket.on("replyMessage", (msg) {
        setMessage(msg["msg"], "destination", msg["path"]);
      });
    });
    // Request join room when the chat screen is opened if is a room
    if(widget.target["type"] == 'classe'){
      socket.emit('joinRoom', widget.target["id"]);
    }
  }
  ScrollController _scrollController = ScrollController();

  @override
  void initState(){
    super.initState();
    connecte();
  }

  @override
  void dispose() async{
    socket.emit("signout", mysourceID+mysourceType);
    socket.disconnect();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
            child: Align(
              alignment: Alignment.topCenter,
              child: loading == false
                  ? ListView.separated(
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: messages.length,
                    controller: _scrollController,
                    separatorBuilder: (_, __) => const SizedBox(
                      height: 0,
                    ),
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final previousMessage = index > 0 ? messages[index - 1] : null;
                      final isSameDay = previousMessage != null &&
                          message.date.year == previousMessage.date.year &&
                          message.date.month == previousMessage.date.month &&
                          message.date.day == previousMessage.date.day;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          if (isSameDay && index == messages.length - 1)
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              color: Colors.white,
                              child: Center(
                                child: Text(
                                  DateFormat.yMMMd().format(message.date),
                                  style: TextStyle(color: MyAppColors.black),
                                ),
                              ),
                            ),
                          if (!isSameDay && index != 0)
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              color: Colors.white,
                              child: Center(
                                child: Text(
                                  DateFormat.yMMMd().format(message.date),
                                  style: TextStyle(color: MyAppColors.black),
                                ),
                              ),
                            ),
                          Align(
                            alignment: (message.expediteurID != null
                                ? (message.expediteurID == mysourceID)
                                : (message.type == mysourceType))
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: message.path.isNotEmpty
                                ? MessageFileCard(
                              type: message.expediteurID != null
                                  ? (message.expediteurID == mysourceID)
                                  : (message.type == mysourceType),
                              path: message.path,
                            )
                                : SendedMessageCard(
                              text: message.text ?? '',
                              time: message.date.toString().substring(10, 16),
                              type: message.expediteurID != null
                                  ? (message.expediteurID == mysourceID)
                                  : (message.type == mysourceType),
                              fullname: message.fullname,
                            ),
                          ),
                        ],
                      );
                    },
                  )
                  : Shimmer.fromColors(
                        baseColor: Colors.grey[200]!,
                        highlightColor: Colors.grey[50]!,
                        child: ListView.builder(
                          itemCount: (MediaQuery.of(context).size.height/72).toInt(), // Adjust the count based on your needs
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Container(
                                  height: MediaQuery.of(context).size.height / 15,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                        ),
                      )
            )
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 05),
            margin: EdgeInsets.only(bottom: 10, left: 5, right: 5), // Set the margins
            decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: MyAppColors.dimopacityvblue,
           ),
            child: mysourceType == "etudiant"
                ? SafeArea(
              bottom: true,
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
                    hintText: "sélectionner un message",
                    suffixIcon: InkWell(
                      child: sendButton ? Icon(Icons.send, color: MyAppColors.principalcolor,) : Icon(Icons.textsms_outlined, color: MyAppColors.principalcolor,),
                      onTap: () async {
                        if (!sendButton) {
                          // file = await imagePicker.pickImage(source: ImageSource.gallery);
                          // if (file == null) {
                          //   showTopSnackBar(
                          //     Overlay.of(context),
                          //     CustomSnackBar.info(
                          //       message: "le fichier n'a pas été téléchargé correctement, vous devez le joindre à nouveau",
                          //     ),
                          //   );
                          //   return;
                          // } else {
                          //   await sendIMG(File(file!.path));
                          // }
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
                : SafeArea(
              bottom: true,
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
                      hintText: "Entrez votre message",
                      suffixIcon: InkWell(
                        child: sendButton ? Icon(Icons.send, color: MyAppColors.principalcolor,) : Icon(Icons.textsms_outlined, color: MyAppColors.principalcolor,),
                        onTap: () async {
                          if (!sendButton) {
                            // file = await imagePicker.pickImage(source: ImageSource.gallery);
                            // if (file == null) {
                            //   showTopSnackBar(
                            //     Overlay.of(context),
                            //     CustomSnackBar.info(
                            //       message: "le fichier n'a pas été téléchargé correctement, vous devez le joindre à nouveau",
                            //     ),
                            //   );
                            //   return;
                            // } else {
                            //   await sendIMG(File(file!.path));
                            // }
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
          )
      ]),
    );
  }
}