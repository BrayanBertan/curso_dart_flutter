import 'package:mobx/mobx.dart';
import 'package:xlo_clone/models/address.dart';
import 'package:xlo_clone/repositorios/cep_repositorio.dart';

part 'cep_store.g.dart';

class CepStore = _CepStore with _$CepStore;

abstract class _CepStore with Store {
  _CepStore(String cep) {
    autorun((_) {
      if (clearCep.length != 8) {
        setError(null);
        setAddress(null);
      } else {
        _searchCep();
      }
    });
    setCep(cep);
  }
  @observable
  String cep = '';

  @observable
  Address address;

  @observable
  String error = null;

  @observable
  bool loading = false;

  @action
  void setCep(String value) => cep = value;

  @action
  void setAddress(Address value) => address = value;

  @action
  void setError(String value) => error = value;

  @action
  void setLoading(bool value) => loading = value;

  @computed
  String get clearCep => cep.replaceAll(RegExp('[^0-9]'), '');

  Future<void> _searchCep() async {
    setLoading(true);
    try {
      final response = await CepRepositorio().getAddressFromApi(clearCep);
      setAddress(response);
      error = null;
    } catch (e) {
      setError(e);
      setAddress(null);
    }
    setLoading(false);
  }
}
