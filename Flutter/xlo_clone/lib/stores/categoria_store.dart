import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_clone/models/categoria.dart';
import 'package:xlo_clone/repositorios/categoria_repositorio.dart';
import 'package:xlo_clone/stores/connectivity_store.dart';

part 'categoria_store.g.dart';

class CategoriaStore = _CategoriaStore with _$CategoriaStore;

abstract class _CategoriaStore with Store {
  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();
  _CategoriaStore() {
    autorun((_) {
      if (connectivityStore.connected && categoriasList.isEmpty)
        _loadCategorias();
    });
  }

  ObservableList<Categoria> categoriasList = ObservableList<Categoria>();

  @observable
  String error;

  @observable
  bool loading = false;

  @action
  setCategorias(List<Categoria> categorias) {
    categoriasList.clear();
    categoriasList.addAll(categorias);
  }

  @action
  void setError(String value) => error = value;

  @action
  void setLoading(bool value) => loading = value;

  @computed
  List<Categoria> get getAallCategorias =>
      List.from(categoriasList)..insert(0, Categoria('*', 'Todos'));

  Future<void> _loadCategorias() async {
    setLoading(true);
    try {
      final categorias = await CategoriaRepositorio().getList();
      setCategorias(categorias);
      setLoading(false);
    } catch (e) {
      setError(e);
    }
  }
}
