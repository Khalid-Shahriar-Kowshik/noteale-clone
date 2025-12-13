//import 'package:flutter/material.dart';

class NotesModel {
  final String id;
  final String title;
  final String content;
  //final Widget checkList;
  final String colorHex;
  final DateTime createdAt;

  NotesModel({
    String? id,
    required this.title,
    required this.content,
    required this.colorHex,
    required this.createdAt,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();
}
