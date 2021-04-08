import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_clone/repositorios/table_keys.dart';

class Categoria {
  Categoria(this.id, this.descricao);

  Categoria.fromParse(ParseObject parseObject)
      : id = parseObject.objectId,
        descricao = parseObject.get(KEY_CATEGORIA_DESCRICAO);

  String id;
  String descricao;

  @override
  String toString() {
    return 'Categoria{id: $id, descricao: $descricao}';
  }
}
