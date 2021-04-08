import 'dart:io';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:path/path.dart' as path;
import 'package:xlo_clone/models/anuncio.dart';
import 'package:xlo_clone/models/categoria.dart';
import 'package:xlo_clone/models/user.dart';
import 'package:xlo_clone/repositorios/parse_errors.dart';
import 'package:xlo_clone/repositorios/table_keys.dart';
import 'package:xlo_clone/stores/filter_store.dart';

class AnuncioRepositorio {
  Future<void> save(Anuncio ad) async {
    try {
      final parseImages = await saveImages(ad.images);
      final parseUser = ParseUser('', '', '')..set(KEY_USER_ID, ad.user.id);
      final parseObject = ParseObject(KEY_ANUNCIO_TABLE);
      if (ad.id != null) parseObject.objectId = ad.id;
      final parseAcl = ParseACL(owner: parseUser);
      parseAcl.setPublicReadAccess(allowed: true);
      parseAcl.setPublicWriteAccess(allowed: false);
      parseObject.setACL(parseAcl);

      parseObject.set<String>(keyAdTitle, ad.titulo);
      parseObject.set<String>(keyAdDescription, ad.descricao);
      parseObject.set<double>(keyAdPrice, ad.preco);
      parseObject.set<bool>(keyAdHidePhone, ad.hidePhone);
      parseObject.set<int>(keyAdStatus, ad.status.index);
      parseObject.set<String>(keyAdDistrict, ad.address.distrito);
      parseObject.set<String>(keyAdCity, ad.address.cidade.nome);
      parseObject.set<String>(keyAdFederativeUnit, ad.address.uf.sigla);
      parseObject.set<String>(keyAdPostalCode, ad.address.cep);

      parseObject.set<List<ParseFile>>(keyAdImages, parseImages);

      parseObject.set<ParseUser>(keyAdOwner, parseUser);
      parseObject.set<ParseObject>(keyAdCategory,
          ParseObject(KEY_CATEGORIA_TABLE)..set('objectId', ad.categoria.id));

      final response = await parseObject.save();
      if (response.success) {
        return;
      }
    } catch (e) {
      Future.error('Erro ao salvar anuncio');
    }
  }

  Future<List<ParseFile>> saveImages(List images) async {
    final parseImages = <ParseFile>[];
    try {
      for (final image in images) {
        if (image is File) {
          final parseFile = ParseFile(image, name: path.basename(image.path));
          final response = await parseFile.save();
          if (!response.success) {
            return Future.error(
                ParseErrors.getDescription(response.error.code));
          }
          parseImages.add(parseFile);
        } else {
          final parseFile = ParseFile(null);
          parseFile.name = path.basename(image);
          parseFile.url = image;
          parseImages.add(parseFile);
        }
      }
      return parseImages;
    } catch (e) {
      Future.error(('Erro ao subir as fotos'));
    }
  }

  Future<List<Anuncio>> getHomeAdsList(
      {FilterStore filter,
      String search,
      Categoria categoria,
      int page}) async {
    try {
      final queryBuilder =
          QueryBuilder<ParseObject>(ParseObject(KEY_ANUNCIO_TABLE));
      queryBuilder.includeObject([keyAdOwner, keyAdCategory]);
      queryBuilder.setAmountToSkip(page * 10);
      queryBuilder.setLimit(10);

      queryBuilder.whereEqualTo(keyAdStatus, Adstatus.ATIVO.index);

      if (search != null && search.trim().isNotEmpty)
        queryBuilder.whereContains(keyAdTitle, search, caseSensitive: false);

      if (categoria != null && categoria.id != '*')
        queryBuilder.whereEqualTo(
            keyAdCategory,
            (ParseObject(KEY_CATEGORIA_TABLE)..set('objectId', categoria.id))
                .toPointer());

      switch (filter.orderBy) {
        case OrderBy.PRICE:
          queryBuilder.orderByAscending(keyAdPrice);
          break;
        case OrderBy.DATE:
          queryBuilder.orderByDescending(keyAdCreatedAt);
          break;
        default:
          queryBuilder.orderByAscending(keyAdTitle);
      }

      final userQuery = QueryBuilder<ParseUser>(ParseUser.forQuery());

      if (filter.min != null && filter.min > 0)
        queryBuilder.whereGreaterThanOrEqualsTo(keyAdPrice, filter.min);

      if (filter.max != null && filter.max > 0)
        queryBuilder.whereLessThanOrEqualTo(keyAdPrice, filter.max);

      if (filter.vendorType != null &&
          filter.vendorType > 0 &&
          filter.vendorType <
              (VENDOR_TYPE_PROFISISONAL | VENDOR_TYPE_PARTICULAR)) {
        if (filter.vendorType == VENDOR_TYPE_PARTICULAR)
          userQuery.whereEqualTo(KEY_USER_TYPE, UserType.PARTICULAR.index);
        if (filter.vendorType == VENDOR_TYPE_PROFISISONAL)
          userQuery.whereEqualTo(KEY_USER_TYPE, UserType.PROFESSIONAL.index);
      }
      queryBuilder.whereMatchesQuery(keyAdOwner, userQuery);

      final response = await queryBuilder.query();

      if (response.success && response.results != null) {
        return response.results.map((ad) => Anuncio.fromParse(ad)).toList();
      } else if (response.success && response.results == null) {
        return [];
      } else {
        return Future.error(ParseErrors.getDescription(response.error.code));
      }
    } catch (e) {
      return Future.error('Falha na conexão');
    }
  }

  Future<List<Anuncio>> getMeusAnuncios(User user) async {
    final currentUser = ParseUser('', '', '')..set(KEY_USER_ID, user.id);
    final queryBuilder =
        QueryBuilder<ParseObject>(ParseObject(KEY_ANUNCIO_TABLE));
    queryBuilder.setLimit(100);
    queryBuilder.orderByDescending(keyAdCreatedAt);
    queryBuilder.whereEqualTo(keyAdOwner, currentUser.toPointer());
    queryBuilder.includeObject([keyAdCategory, keyAdOwner]);
    final response = await queryBuilder.query();
    if (response.success && response.results != null) {
      return response.results.map((ad) => Anuncio.fromParse(ad)).toList();
    } else if (response.success && response.results == null) {
      return [];
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<void> soldAd(Anuncio ad) async {
    final parseObject = ParseObject(KEY_ANUNCIO_TABLE)
      ..set(keyAdId, ad.id)
      ..set<int>(keyAdStatus, Adstatus.VENDIDO.index);
    await parseObject.save();
  }

  Future<void> deleteAd(Anuncio ad) async {
    final parseObject = ParseObject(KEY_ANUNCIO_TABLE)
      ..set(keyAdId, ad.id)
      ..set<int>(keyAdStatus, Adstatus.DELETADO.index);
    await parseObject.save();
  }
}
