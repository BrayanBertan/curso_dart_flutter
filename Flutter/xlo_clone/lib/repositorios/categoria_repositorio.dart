import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_clone/models/categoria.dart';
import 'package:xlo_clone/repositorios/parse_errors.dart';
import 'package:xlo_clone/repositorios/table_keys.dart';

class CategoriaRepositorio {
  Future<List<Categoria>> getList() async {
    final queryBuilder = QueryBuilder(ParseObject(KEY_CATEGORIA_TABLE))
      ..orderByAscending(KEY_CATEGORIA_DESCRICAO);

    final response = await queryBuilder.query();

    if (response.success) {
      return response.results
          .map((categoria) => Categoria.fromParse(categoria))
          .toList();
    } else {
      throw ParseErrors.getDescription(response.error.code);
    }
  }
}
