import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_clone/models/anuncio.dart';
import 'package:xlo_clone/repositorios/anuncio_repositorio.dart';
import 'package:xlo_clone/stores/user_manager_store.dart';

part 'meu_anuncio_store.g.dart';

class MeuAnuncioStore = _MeuAnuncioStore with _$MeuAnuncioStore;

abstract class _MeuAnuncioStore with Store {
  _MeuAnuncioStore() {
    _getMeusAnuncios();
  }

  @observable
  List<Anuncio> allAds = [];

  @action
  Future<void> _getMeusAnuncios() async {
    final user = GetIt.I<UserManagerStore>().user;
    try {
      setLoading(true);
      allAds = await AnuncioRepositorio().getMeusAnuncios(user);
      setLoading(false);
    } catch (e) {
      print(e);
    }
  }

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @action
  Future<void> soldAd(Anuncio ad) async {
    loading = true;
    await AnuncioRepositorio().soldAd(ad);
    refresh();
  }

  @action
  Future<void> deleteAd(Anuncio ad) async {
    loading = true;
    await AnuncioRepositorio().deleteAd(ad);
    refresh();
  }

  @computed
  List<Anuncio> get activeAds =>
      allAds.where((ad) => ad.status == Adstatus.ATIVO).toList();

  @computed
  List<Anuncio> get pendentAds =>
      allAds.where((ad) => ad.status == Adstatus.PENDENTE).toList();

  @computed
  List<Anuncio> get soldAds =>
      allAds.where((ad) => ad.status == Adstatus.VENDIDO).toList();

  void refresh() => _getMeusAnuncios();
}
