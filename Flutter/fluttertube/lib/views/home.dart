import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/bloc/favorito_bloc.dart';
import 'package:fluttertube/bloc/video_bloc.dart';
import 'package:fluttertube/delegates/data_search.dart';
import 'package:fluttertube/views/favorito.dart';
import 'package:fluttertube/widgets/video_tile.dart';
import 'package:fluttertube/api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final VideosBloc blocVideos = BlocProvider.getBloc<VideosBloc>();
  final FavoritosBloc blocFavoritos = BlocProvider.getBloc<FavoritosBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset('images/logo.png'),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
        actions: [
          Align(
            alignment: Alignment.center,
            child: StreamBuilder(
              initialData: {},
              stream: blocFavoritos.favoritoController,
              builder: (context,snapshot){
                return Text('${snapshot.data.length}');
              },
            ),
          ),
          IconButton(icon: Icon(Icons.star), onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) =>FavoritoPage())
            );
          }),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                String result =
                    await showSearch(context: context, delegate: DataSearch());
                if (result != null) {
                  blocVideos.searchController.add(result);
                }
              })
        ],
      ),
      body: StreamBuilder(
        stream: blocVideos.videoController,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length + 1,
              itemBuilder: (context, index) {
                if (index < snapshot.data.length) {
                  return VideoTile(snapshot.data[index]);
                } else {
                  blocVideos.searchController.add(null);
                  return Container(
                    width: 40.0,
                    height: 40.0,
                    alignment: Alignment.center,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
