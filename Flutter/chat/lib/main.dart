import 'package:chat/ui_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(ChatOnlineApp());
}

class ChatOnlineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        iconTheme: IconThemeData(
          color: Colors.deepOrange
        )
      ),
      home: HomePage(),
    );
  }
}


