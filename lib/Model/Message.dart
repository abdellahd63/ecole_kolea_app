import 'package:ecole_kolea_app/Auth/AuthContext.dart';
import 'package:flutter/material.dart';

class Message {
  String? id;
  String? text;
  DateTime date;
  String type;
  String path;

  Message({
    this.text,
    required this.date,
    required this.type,
    required this.path,
    this.id,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json['texte'],
      date: DateTime.parse(json['date_envoi']),
      type: json['expediteur'],
      path: '',
      id: json['id'].toString()
    );
  }
}
