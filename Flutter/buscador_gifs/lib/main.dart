import 'package:buscador_gifs/ui/gif_page.dart';
import 'package:buscador_gifs/ui/home_page.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(BuscadorGifsApp());
}

class BuscadorGifsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        hintColor: Colors.pink
      ),
      home: HomePage(),
    );
  }
}


