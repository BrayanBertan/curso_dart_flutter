import 'package:agenda_de_contatos/ui/contact_page.dart';
import 'package:agenda_de_contatos/ui/home_page.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(ContatosApp());
}

class ContatosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}



