import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_clone/models/anuncio.dart';
import 'package:xlo_clone/models/user.dart';
import 'package:xlo_clone/repositorios/parse_errors.dart';
import 'package:xlo_clone/repositorios/table_keys.dart';

class FavoriteRepositorio {
  Future<void> setFavorite(Anuncio anuncio, User user) async {
    final favoriteObject = ParseObject(KEY_FAVORITES_TABLE);
    favoriteObject.set<String>(KEY_FAVORITES_OWNER, user.id);
    favoriteObject.set<ParseObject>(KEY_FAVORITES_AD,
        ParseObject(KEY_ANUNCIO_TABLE)..set<String>(keyAdId, anuncio.id));

    final response = await favoriteObject.save();
    if (!response.success) {
      Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<void> unsetFavorite(Anuncio anuncio, User user) async {
    final queryBuilder = QueryBuilder(ParseObject(KEY_FAVORITES_TABLE));

    queryBuilder.whereEqualTo(KEY_FAVORITES_OWNER, user.id);
    queryBuilder.whereEqualTo(KEY_FAVORITES_AD,
        ParseObject(KEY_ANUNCIO_TABLE)..set<String>(keyAdId, anuncio.id));
    final response = await queryBuilder.query();

    if (response.success && response.results != null) {
      response.results.forEach((element) async {
        await element.delete();
      });
    } else {
      Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<List<Anuncio>> getAllFavorite(User user) async {
    final queryBuilder = QueryBuilder(ParseObject(KEY_FAVORITES_TABLE));

    queryBuilder.whereEqualTo(KEY_FAVORITES_OWNER, user.id);

    queryBuilder.includeObject([KEY_FAVORITES_AD, 'ad.owner']);
    final response = await queryBuilder.query();

    if (response.success && response.results != null) {
      return response.results
          .map((e) => Anuncio.fromParse(e.get<ParseObject>(KEY_FAVORITES_AD)))
          .toList();
    } else if (response.success && response.results == null) {
      return [];
    } else {
      Future.error(ParseErrors.getDescription(response.error.code));
    }
  }
}
