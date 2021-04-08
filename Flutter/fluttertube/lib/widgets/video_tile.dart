import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:fluttertube/bloc/favorito_bloc.dart';
import 'package:fluttertube/models/video.dart';
import 'package:fluttertube/api.dart';

class VideoTile extends StatelessWidget {
  final Video video;
  final FavoritosBloc blocFavoritos = BlocProvider.getBloc<FavoritosBloc>();
  VideoTile(this.video);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FlutterYoutube.playYoutubeVideoById(apiKey: API_KEY, videoId: video.id);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16.0 / 9.0,
              child: Image.network(
                video.thumb,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            video.title,
                            maxLines: 2,
                            style: TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            video.channel,
                            style: TextStyle(color: Colors.white, fontSize: 14.0),
                          ),
                        ),
                      ],
                    )),
                StreamBuilder<Map<String, Video>>(
                  initialData: {},
                  stream: blocFavoritos.favoritoController,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return IconButton(
                          icon: Icon(
                            snapshot.data.containsKey(video.id)
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            blocFavoritos.toggleFavorites(video);
                          });
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
