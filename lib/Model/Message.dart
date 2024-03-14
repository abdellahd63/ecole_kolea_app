import 'package:ecole_kolea_app/Auth/AuthContext.dart';
import 'package:flutter/material.dart';

class Message {
  String? text;
  DateTime date;
  String type;
  String path;

  Message({
    this.text,
    required this.date,
    required this.type,
    required this.path,
  });

  factory Message.fromJson(Map<String, dynamic> json, String mysourceID) {
    return Message(
      text: json['message'],
      date: DateTime.parse(json['createdAt']),
      type: json['source'] == mysourceID ? "source" : "target",
      path: json['path'],
    );
  }
}
