import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_clone/models/anuncio.dart';
import 'package:xlo_clone/repositorios/favorite_repositorio.dart';
import 'package:xlo_clone/stores/user_manager_store.dart';

part 'favorite_store.g.dart';

class FavoriteStore = _FavoriteStore with _$FavoriteStore;

abstract class _FavoriteStore with Store {
  _FavoriteStore() {
    reaction((_) => GetIt.I<UserManagerStore>().isLoggedIn, (_) {
      _getFavoriteList();
    });
  }
  ObservableList<Anuncio> favoriteList = ObservableList<Anuncio>();

  @action
  Future<void> _getFavoriteList() async {
    try {
      favoriteList.clear();
      final response = await FavoriteRepositorio()
          .getAllFavorite(GetIt.I<UserManagerStore>().user);
      favoriteList.addAll(response);
      print('success');
    } catch (e) {
      print(e);
    }
  }

  @action
  Future<void> toggleFavorites(Anuncio ad) async {
    try {
      if (favoriteList.any((an) => an.id == ad.id)) {
        favoriteList.removeWhere((an) => an.id == ad.id);
        await FavoriteRepositorio()
            .unsetFavorite(ad, GetIt.I<UserManagerStore>().user);
      } else {
        favoriteList.add(ad);
        await FavoriteRepositorio()
            .setFavorite(ad, GetIt.I<UserManagerStore>().user);
      }
    } catch (e) {
      print(e);
    }
  }
}
