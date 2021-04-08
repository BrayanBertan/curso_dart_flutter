import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertube/api.dart';
import 'package:fluttertube/models/video.dart';

class VideosBloc implements BlocBase {
  Api api;
  List<Video> videos = [];
  String teste = 'pegou';

  final StreamController<List<Video>>   _videoController = StreamController<List<Video>>();

  Stream get videoController => _videoController.stream;
  final StreamController _searchController = StreamController<String>();

  Sink get searchController => _searchController.sink;

  VideosBloc() {
    api = Api();
    _searchController.stream.listen((d) async {
      if (d != null) {
        videos.clear();
        _videoController.sink.add(videos);
        videos = await api.search(d);
      } else {
        videos += await api.nextPage();
      }
      _videoController.sink.add(videos);
    });
  }
  void _search(String search) async {
    print(search);
    /*
    if (search != null) {
      _videoController.sink.add([]);
      videos = await api.search(search);
    }*/

    //_videoController.sink(videos);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _videoController.close();
    _searchController.close();
  }

  @override
  void addListener(void Function() listener) {
    // TODO: implement addListener
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(void Function() listener) {
    // TODO: implement removeListener
  }
}
