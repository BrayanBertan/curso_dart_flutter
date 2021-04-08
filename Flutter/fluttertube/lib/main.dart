import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/api.dart';
import 'package:fluttertube/bloc/favorito_bloc.dart';
import 'package:fluttertube/bloc/video_bloc.dart';
import 'package:fluttertube/views/home.dart';

void main() {
  runApp(TubeApp());
  Api api = Api();
  api.search('Flow');
}

class TubeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        blocs: [
          Bloc((i) => VideosBloc(),),
          Bloc((i) => FavoritosBloc(),),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        ));
  }
}
