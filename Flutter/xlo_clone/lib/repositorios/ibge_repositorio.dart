import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xlo_clone/models/cidade.dart';
import 'package:xlo_clone/models/uf.dart';

class IbgeRepositorio {
  Future<List<UF>> getUFList() async {
    final preference = await SharedPreferences.getInstance();
    if (preference.containsKey('UF_LIST')) {
      return json
          .decode(preference.getString('UF_LIST'))
          .map<UF>((uf) => UF.fromJson(uf))
          .toList()
            ..sort((UF a, UF b) =>
                a.nome.toLowerCase().compareTo(b.nome.toLowerCase()));
    }
    const endpoint =
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados';
    try {
      final response = await Dio().get<List>(endpoint);

      final list = response.data.map<UF>((uf) => UF.fromJson(uf)).toList()
        ..sort((UF a, UF b) =>
            a.nome.toLowerCase().compareTo(b.nome.toLowerCase()));

      preference.setString('UF_LIST', json.encode(response.data));
      return list;
    } on DioError {
      return Future.error('Falha ao obter lista de estados');
    }
  }

  Future<List<Cidade>> getCidadeListFromApi(UF uf) async {
    final endpoint =
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados/${uf.id}/municipios';
    try {
      final response = await Dio().get<List>(endpoint);

      return response.data
          .map<Cidade>((cidade) => Cidade.fromJson(cidade))
          .toList()
            ..sort((Cidade a, Cidade b) =>
                a.nome.toLowerCase().compareTo(b.nome.toLowerCase()));
    } on DioError {
      return Future.error('Falha ao obter lista de municipios');
    }
  }
}
