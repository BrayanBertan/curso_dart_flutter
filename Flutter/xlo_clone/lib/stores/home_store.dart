import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_clone/models/anuncio.dart';
import 'package:xlo_clone/models/categoria.dart';
import 'package:xlo_clone/repositorios/anuncio_repositorio.dart';
import 'package:xlo_clone/stores/connectivity_store.dart';
import 'package:xlo_clone/stores/filter_store.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();
  _HomeStore() {
    autorun((_) async {
      connectivityStore.connected;
      try {
        if (page == 0) setIsLoading(true);
        final newAds = await AnuncioRepositorio().getHomeAdsList(
            filter: filter, search: search, categoria: categoria, page: page);
        addNewAds(newAds);
        setError(null);
        setIsLoading(false);
      } catch (e) {
        setError(e);
      }
    });
  }

  void resetPage() {
    page = 0;
    adList.clear();
    lastPage = false;
  }

  @observable
  bool lastPage = false;
  @action
  void addNewAds(List<Anuncio> newAds) {
    if (newAds.length < 10) lastPage = true;
    adList.addAll(newAds);
  }

  @computed
  int get itemCount => lastPage ? adList.length : adList.length + 1;

  ObservableList<Anuncio> adList = ObservableList<Anuncio>();
  @observable
  String error;

  @observable
  bool isLoading = false;

  @action
  void setIsLoading(bool value) => isLoading = value;

  @action
  void setError(String value) => error = value;
  @observable
  String search = '';

  @observable
  Categoria categoria;

  @action
  void setSeartch(String value) {
    resetPage();
    search = value;
  }

  @action
  void setCategoria(Categoria value) {
    resetPage();
    categoria = value;
  }

  @observable
  FilterStore filter = FilterStore();

  FilterStore get cloneFilter => filter.clone();

  @action
  void setFilter(FilterStore value) {
    resetPage();
    filter = value;
  }

  @observable
  int page = 0;

  @action
  void loadPage() => page++;
}
