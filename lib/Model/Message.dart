import 'package:ecole_kolea_app/Auth/AuthContext.dart';
import 'package:flutter/material.dart';

class Message {
  String? expediteurID;
  String? text;
  DateTime date;
  String type;
  String path;
  String? fullname;

  Message({
    this.text,
    required this.date,
    required this.type,
    required this.path,
    this.expediteurID,
    this.fullname
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json['texte'],
      date: DateTime.parse(json['date_envoi']),
      type: json['expediteur'],
      path: '',
      expediteurID: json['expediteurID'],
      fullname: json['expediteurName']
    );
  }
}
