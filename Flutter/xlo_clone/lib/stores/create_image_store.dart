import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_clone/models/address.dart';
import 'package:xlo_clone/models/anuncio.dart';
import 'package:xlo_clone/models/categoria.dart';
import 'package:xlo_clone/repositorios/anuncio_repositorio.dart';
import 'package:xlo_clone/stores/cep_store.dart';
import 'package:xlo_clone/stores/user_manager_store.dart';

part 'create_image_store.g.dart';

class CreateImageStore = _CreateImageStore with _$CreateImageStore;

abstract class _CreateImageStore with Store {
  _CreateImageStore(this.ad) {
    titulo = ad.titulo;
    descricao = ad.titulo;
    images = ad.images.asObservable();
    categoria = ad.categoria;
    precoText = ad.preco?.toStringAsFixed(2) ?? '0.0';
    hidePhone = ad.hidePhone;
    if (ad.address != null) {
      cepStore = CepStore(ad.address.cep);
    } else {
      cepStore = CepStore(null);
    }
  }

  final Anuncio ad;

  CepStore cepStore;
  ObservableList images = ObservableList();

  @observable
  Categoria categoria;

  @observable
  bool hidePhone = false;

  @observable
  String titulo = '';

  @observable
  String descricao = '';

  @observable
  String cep = '';

  @observable
  String precoText = '0';
  @observable
  bool showErros = false;

  @observable
  bool loading = false;

  @observable
  String erroSend;

  @observable
  bool anuncio = false;

  @action
  void setCategoria(Categoria value) => categoria = value;

  @action
  void setHidePhone(bool value) => hidePhone = value;

  @action
  void setTitulo(String value) => titulo = value;

  @action
  void setDescricao(String value) => descricao = value;

  @action
  void setCep(String value) => cep = value;

  @action
  void setPrecoText(String value) => precoText = value;
  @action
  void invalidSendPressed() => showErros = true;

  @action
  void setLoading(bool value) => loading = value;

  @action
  void setErroSend(String value) => erroSend = value;

  @action
  void setAnuncio(bool value) => anuncio = value;

  @computed
  bool get imagesValid => images.isNotEmpty;

  @computed
  String get imagesError {
    if (!showErros || imagesValid)
      return null;
    else
      return 'Insira imagens';
  }

  @computed
  bool get tituloValid => titulo != null && titulo.length >= 5;

  @computed
  String get tituloError {
    if (!showErros || tituloValid)
      return null;
    else if (titulo.isEmpty)
      return 'Insira um titulo';
    else
      return 'Titulo muito curto';
  }

  @computed
  bool get descricaoValid => descricao != null && descricao.length >= 5;

  @computed
  String get descricaoError {
    if (!showErros || descricaoValid)
      return null;
    else if (descricao.isEmpty)
      return 'Insira uma descrição';
    else
      return 'Descrição muito curta';
  }

  @computed
  bool get categoriaValid => categoria != null;

  @computed
  String get categoriaError {
    if (categoriaValid)
      return null;
    else if (!showErros)
      return '';
    else
      return 'Categoria é  obrigatoria';
  }

  @computed
  Address get address => cepStore.address;
  bool get addressValid => address != null;
  String get addressError {
    if (!showErros || addressValid)
      return null;
    else
      return ' campo obrigátorio';
  }

  @computed
  double get preco {
    if (precoText == null) precoText == '0.0';
    if (precoText.contains(',')) {
      return double.tryParse(precoText.replaceAll(RegExp('[^0-9]'), ''));
    } else {
      return double.tryParse(precoText);
    }
  }

  @computed
  bool get precoValid => preco != null && preco > 0.0;

  @computed
  String get precoError {
    if (!showErros || precoValid)
      return null;
    else
      return 'Preço é  obrigatorio';
  }

  @computed
  bool get formValid =>
      tituloValid &&
      descricaoValid &&
      categoriaValid &&
      addressValid &&
      precoValid &&
      imagesValid;

  @computed
  Function get sendValid => formValid ? _send : null;

  Future<void> _send() async {
    ad.titulo = titulo;
    ad.descricao = descricao;
    ad.preco = preco;
    ad.categoria = categoria;
    ad.address = cepStore.address;
    ad.hidePhone = hidePhone ?? false;
    ad.images = images ?? [];
    ad.created = DateTime.now();
    ad.user = GetIt.I<UserManagerStore>().user;
    setLoading(true);
    try {
      await AnuncioRepositorio().save(ad);
      setAnuncio(true);
    } catch (e) {
      setErroSend(e);
    }
    setLoading(false);
  }
}
