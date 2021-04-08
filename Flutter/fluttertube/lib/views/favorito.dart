import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:fluttertube/bloc/favorito_bloc.dart';
import 'package:fluttertube/models/video.dart';
import 'package:fluttertube/api.dart';

class FavoritoPage extends StatelessWidget {
  final FavoritosBloc blocFavoritos = BlocProvider.getBloc<FavoritosBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
        centerTitle: true,
      ),
      body: StreamBuilder<Map<String, Video>>(
        initialData: {},
        stream: blocFavoritos.favoritoController,
        builder: (context, snapshot) {
          return ListView(
            children: snapshot.data.values.map<Widget>((video) {
              return InkWell(
                onTap: () {
                  FlutterYoutube.playYoutubeVideoById(apiKey: API_KEY, videoId: video.id);
                },
                onDoubleTap: () {
                  blocFavoritos.toggleFavorites(video);
                },
                child: Row(
                  children: [
                    Container(
                      width: 100.0,
                      height: 50.0,
                      child: Image.network(video.thumb),
                    ),
                    Expanded(child: Text(video.title))
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
