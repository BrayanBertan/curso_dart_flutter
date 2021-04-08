import 'package:flutter/material.dart';
import 'package:loja_gerencia/views/login.dart';

void main() {
  runApp(LojaGerenciaApp());
}

class LojaGerenciaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(title: 'Flutter Demo Home Page'),
    );
  }
}
