import 'package:xlo_clone/models/cidade.dart';
import 'package:xlo_clone/models/uf.dart';

class Address {
  UF uf;
  Cidade cidade;
  String cep;
  String distrito;

  Address({this.uf, this.cidade, this.cep, this.distrito});

  @override
  String toString() {
    return 'address{uf: $uf, cidade: $cidade, cpf: $cep, distrito: $distrito}';
  }
}
