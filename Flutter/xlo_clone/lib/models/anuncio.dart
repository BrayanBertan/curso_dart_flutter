import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_clone/models/address.dart';
import 'package:xlo_clone/models/categoria.dart';
import 'package:xlo_clone/models/cidade.dart';
import 'package:xlo_clone/models/uf.dart';
import 'package:xlo_clone/models/user.dart';
import 'package:xlo_clone/repositorios/table_keys.dart';
import 'package:xlo_clone/repositorios/user_repositorio.dart';

enum Adstatus { PENDENTE, ATIVO, VENDIDO, DELETADO }

class Anuncio {
  String id;
  String titulo;
  String descricao;
  double preco;
  Categoria categoria;
  Address address;
  bool hidePhone = false;
  List images = [];
  Adstatus status;
  DateTime created;
  User user;
  int views;

  Anuncio(
      {this.id,
      this.titulo,
      this.descricao,
      this.preco,
      this.categoria,
      this.address,
      this.hidePhone = false,
      this.images,
      this.status = Adstatus.PENDENTE,
      this.created,
      this.user,
      this.views}) {
    images = images ?? [];
    hidePhone = hidePhone ?? false;
    titulo = titulo ?? '';
    descricao = descricao ?? '';
  }

  factory Anuncio.fromParse(ParseObject obj) {
    return Anuncio(
        id: obj.objectId,
        titulo: obj.get<String>(keyAdTitle),
        descricao: obj.get<String>(keyAdDescription),
        preco: obj.get<double>(keyAdPrice),
        address: Address(
            distrito: obj.get<String>(keyAdDistrict),
            uf: UF(sigla: obj.get<String>(keyAdFederativeUnit)),
            cidade: Cidade(nome: obj.get<String>(keyAdCity)),
            cep: obj.get<String>(keyAdPostalCode)),
        hidePhone: obj.get<bool>(keyAdHidePhone),
        images: obj.get<List>(keyAdImages).map((file) => file.url).toList(),
        created: obj.createdAt,
        views: obj.get<int>(keyAdViews, defaultValue: 0),
        user: UserRepositorio().MapParseToUser(obj.get<ParseUser>(keyAdOwner)),
        categoria: Categoria.fromParse(obj.get<ParseObject>(keyAdCategory)),
        status: Adstatus.values[obj.get<int>(keyAdStatus)]);
  }
}
