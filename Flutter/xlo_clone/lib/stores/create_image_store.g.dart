// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_image_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CreateImageStore on _CreateImageStore, Store {
  Computed<bool> _$imagesValidComputed;

  @override
  bool get imagesValid =>
      (_$imagesValidComputed ??= Computed<bool>(() => super.imagesValid,
              name: '_CreateImageStore.imagesValid'))
          .value;
  Computed<String> _$imagesErrorComputed;

  @override
  String get imagesError =>
      (_$imagesErrorComputed ??= Computed<String>(() => super.imagesError,
              name: '_CreateImageStore.imagesError'))
          .value;
  Computed<bool> _$tituloValidComputed;

  @override
  bool get tituloValid =>
      (_$tituloValidComputed ??= Computed<bool>(() => super.tituloValid,
              name: '_CreateImageStore.tituloValid'))
          .value;
  Computed<String> _$tituloErrorComputed;

  @override
  String get tituloError =>
      (_$tituloErrorComputed ??= Computed<String>(() => super.tituloError,
              name: '_CreateImageStore.tituloError'))
          .value;
  Computed<bool> _$descricaoValidComputed;

  @override
  bool get descricaoValid =>
      (_$descricaoValidComputed ??= Computed<bool>(() => super.descricaoValid,
              name: '_CreateImageStore.descricaoValid'))
          .value;
  Computed<String> _$descricaoErrorComputed;

  @override
  String get descricaoError =>
      (_$descricaoErrorComputed ??= Computed<String>(() => super.descricaoError,
              name: '_CreateImageStore.descricaoError'))
          .value;
  Computed<bool> _$categoriaValidComputed;

  @override
  bool get categoriaValid =>
      (_$categoriaValidComputed ??= Computed<bool>(() => super.categoriaValid,
              name: '_CreateImageStore.categoriaValid'))
          .value;
  Computed<String> _$categoriaErrorComputed;

  @override
  String get categoriaError =>
      (_$categoriaErrorComputed ??= Computed<String>(() => super.categoriaError,
              name: '_CreateImageStore.categoriaError'))
          .value;
  Computed<Address> _$addressComputed;

  @override
  Address get address =>
      (_$addressComputed ??= Computed<Address>(() => super.address,
              name: '_CreateImageStore.address'))
          .value;
  Computed<double> _$precoComputed;

  @override
  double get preco => (_$precoComputed ??=
          Computed<double>(() => super.preco, name: '_CreateImageStore.preco'))
      .value;
  Computed<bool> _$precoValidComputed;

  @override
  bool get precoValid =>
      (_$precoValidComputed ??= Computed<bool>(() => super.precoValid,
              name: '_CreateImageStore.precoValid'))
          .value;
  Computed<String> _$precoErrorComputed;

  @override
  String get precoError =>
      (_$precoErrorComputed ??= Computed<String>(() => super.precoError,
              name: '_CreateImageStore.precoError'))
          .value;
  Computed<bool> _$formValidComputed;

  @override
  bool get formValid =>
      (_$formValidComputed ??= Computed<bool>(() => super.formValid,
              name: '_CreateImageStore.formValid'))
          .value;
  Computed<Function> _$sendValidComputed;

  @override
  Function get sendValid =>
      (_$sendValidComputed ??= Computed<Function>(() => super.sendValid,
              name: '_CreateImageStore.sendValid'))
          .value;

  final _$categoriaAtom = Atom(name: '_CreateImageStore.categoria');

  @override
  Categoria get categoria {
    _$categoriaAtom.reportRead();
    return super.categoria;
  }

  @override
  set categoria(Categoria value) {
    _$categoriaAtom.reportWrite(value, super.categoria, () {
      super.categoria = value;
    });
  }

  final _$hidePhoneAtom = Atom(name: '_CreateImageStore.hidePhone');

  @override
  bool get hidePhone {
    _$hidePhoneAtom.reportRead();
    return super.hidePhone;
  }

  @override
  set hidePhone(bool value) {
    _$hidePhoneAtom.reportWrite(value, super.hidePhone, () {
      super.hidePhone = value;
    });
  }

  final _$tituloAtom = Atom(name: '_CreateImageStore.titulo');

  @override
  String get titulo {
    _$tituloAtom.reportRead();
    return super.titulo;
  }

  @override
  set titulo(String value) {
    _$tituloAtom.reportWrite(value, super.titulo, () {
      super.titulo = value;
    });
  }

  final _$descricaoAtom = Atom(name: '_CreateImageStore.descricao');

  @override
  String get descricao {
    _$descricaoAtom.reportRead();
    return super.descricao;
  }

  @override
  set descricao(String value) {
    _$descricaoAtom.reportWrite(value, super.descricao, () {
      super.descricao = value;
    });
  }

  final _$cepAtom = Atom(name: '_CreateImageStore.cep');

  @override
  String get cep {
    _$cepAtom.reportRead();
    return super.cep;
  }

  @override
  set cep(String value) {
    _$cepAtom.reportWrite(value, super.cep, () {
      super.cep = value;
    });
  }

  final _$precoTextAtom = Atom(name: '_CreateImageStore.precoText');

  @override
  String get precoText {
    _$precoTextAtom.reportRead();
    return super.precoText;
  }

  @override
  set precoText(String value) {
    _$precoTextAtom.reportWrite(value, super.precoText, () {
      super.precoText = value;
    });
  }

  final _$showErrosAtom = Atom(name: '_CreateImageStore.showErros');

  @override
  bool get showErros {
    _$showErrosAtom.reportRead();
    return super.showErros;
  }

  @override
  set showErros(bool value) {
    _$showErrosAtom.reportWrite(value, super.showErros, () {
      super.showErros = value;
    });
  }

  final _$loadingAtom = Atom(name: '_CreateImageStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$erroSendAtom = Atom(name: '_CreateImageStore.erroSend');

  @override
  String get erroSend {
    _$erroSendAtom.reportRead();
    return super.erroSend;
  }

  @override
  set erroSend(String value) {
    _$erroSendAtom.reportWrite(value, super.erroSend, () {
      super.erroSend = value;
    });
  }

  final _$anuncioAtom = Atom(name: '_CreateImageStore.anuncio');

  @override
  bool get anuncio {
    _$anuncioAtom.reportRead();
    return super.anuncio;
  }

  @override
  set anuncio(bool value) {
    _$anuncioAtom.reportWrite(value, super.anuncio, () {
      super.anuncio = value;
    });
  }

  final _$_CreateImageStoreActionController =
      ActionController(name: '_CreateImageStore');

  @override
  void setCategoria(Categoria value) {
    final _$actionInfo = _$_CreateImageStoreActionController.startAction(
        name: '_CreateImageStore.setCategoria');
    try {
      return super.setCategoria(value);
    } finally {
      _$_CreateImageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHidePhone(bool value) {
    final _$actionInfo = _$_CreateImageStoreActionController.startAction(
        name: '_CreateImageStore.setHidePhone');
    try {
      return super.setHidePhone(value);
    } finally {
      _$_CreateImageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTitulo(String value) {
    final _$actionInfo = _$_CreateImageStoreActionController.startAction(
        name: '_CreateImageStore.setTitulo');
    try {
      return super.setTitulo(value);
    } finally {
      _$_CreateImageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDescricao(String value) {
    final _$actionInfo = _$_CreateImageStoreActionController.startAction(
        name: '_CreateImageStore.setDescricao');
    try {
      return super.setDescricao(value);
    } finally {
      _$_CreateImageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCep(String value) {
    final _$actionInfo = _$_CreateImageStoreActionController.startAction(
        name: '_CreateImageStore.setCep');
    try {
      return super.setCep(value);
    } finally {
      _$_CreateImageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPrecoText(String value) {
    final _$actionInfo = _$_CreateImageStoreActionController.startAction(
        name: '_CreateImageStore.setPrecoText');
    try {
      return super.setPrecoText(value);
    } finally {
      _$_CreateImageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void invalidSendPressed() {
    final _$actionInfo = _$_CreateImageStoreActionController.startAction(
        name: '_CreateImageStore.invalidSendPressed');
    try {
      return super.invalidSendPressed();
    } finally {
      _$_CreateImageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_CreateImageStoreActionController.startAction(
        name: '_CreateImageStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_CreateImageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setErroSend(String value) {
    final _$actionInfo = _$_CreateImageStoreActionController.startAction(
        name: '_CreateImageStore.setErroSend');
    try {
      return super.setErroSend(value);
    } finally {
      _$_CreateImageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAnuncio(bool value) {
    final _$actionInfo = _$_CreateImageStoreActionController.startAction(
        name: '_CreateImageStore.setAnuncio');
    try {
      return super.setAnuncio(value);
    } finally {
      _$_CreateImageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
categoria: ${categoria},
hidePhone: ${hidePhone},
titulo: ${titulo},
descricao: ${descricao},
cep: ${cep},
precoText: ${precoText},
showErros: ${showErros},
loading: ${loading},
erroSend: ${erroSend},
anuncio: ${anuncio},
imagesValid: ${imagesValid},
imagesError: ${imagesError},
tituloValid: ${tituloValid},
tituloError: ${tituloError},
descricaoValid: ${descricaoValid},
descricaoError: ${descricaoError},
categoriaValid: ${categoriaValid},
categoriaError: ${categoriaError},
address: ${address},
preco: ${preco},
precoValid: ${precoValid},
precoError: ${precoError},
formValid: ${formValid},
sendValid: ${sendValid}
    ''';
  }
}
