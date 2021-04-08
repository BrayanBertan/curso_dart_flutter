import 'package:dio/dio.dart';
import 'package:xlo_clone/models/address.dart';
import 'package:xlo_clone/models/cidade.dart';
import 'package:xlo_clone/repositorios/ibge_repositorio.dart';

class CepRepositorio {
  Future<Address> getAddressFromApi(String cep) async {
    if (cep == null || cep.trim().isEmpty) {
      return Future.error('CEP INVÁLIDO 1');
    }
    final clearCep = cep.replaceAll(RegExp('[^0-9]'), '');
    if (clearCep.length != 8) {
      return Future.error('CEP INVÁLIDO 2');
    }

    final endpoint = 'https://viacep.com.br/ws/$clearCep/json/';
    try {
      final response = await Dio().get<Map>(endpoint);
      if (response.data.containsKey('erro') && response.data['erro']) {
        return Future.error('CEP INVÁLIDO 3');
      }
      final ufList = await IbgeRepositorio().getUFList();
      return Address(
          cep: response.data['cep'],
          distrito: response.data['bairro'],
          cidade: Cidade(nome: response.data['localidade']),
          uf: ufList.firstWhere((uf) => uf.sigla == response.data['uf']));
    } catch (error) {
      Future.error('Falha ao buscar cep: $error');
    }
  }
}
