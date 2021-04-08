import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fluttertube/models/video.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritosBloc implements BlocBase {
  Map<String, Video> _favoritos = {};

  final StreamController<Map<String, Video>> xd =
      StreamController<Map<String, Video>>.broadcast();

  final _favoritoController = BehaviorSubject<Map<String, Video>>();

  Stream<Map<String, Video>> get favoritoController =>
      _favoritoController.stream;

  void toggleFavorites(Video video) {
    if (_favoritos.containsKey(video.id))
      _favoritos.remove(video.id);
    else
      _favoritos[video.id] = video;

    _favoritoController.sink.add((_favoritos));
    _saveFav();
  }

  void _saveFav() async {
    /* SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();*/
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(
          'favoritos',
          json.encode(_favoritos.map((k, v) {

            return MapEntry(k, v.tojson());
          })));
    });
  }

  FavoritosBloc() {
   // return;
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.containsKey('favoritos')) {
        _favoritos = json.decode(prefs.getString('favoritos')).map((k, v) {

          return MapEntry(k, Video.fromJson(v));
        }).cast<String, Video>();
        _favoritoController.add(_favoritos);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _favoritoController.close();
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
