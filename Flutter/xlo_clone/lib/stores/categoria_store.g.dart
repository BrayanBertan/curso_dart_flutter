// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoria_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CategoriaStore on _CategoriaStore, Store {
  Computed<List<Categoria>> _$getAallCategoriasComputed;

  @override
  List<Categoria> get getAallCategorias => (_$getAallCategoriasComputed ??=
          Computed<List<Categoria>>(() => super.getAallCategorias,
              name: '_CategoriaStore.getAallCategorias'))
      .value;

  final _$errorAtom = Atom(name: '_CategoriaStore.error');

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$loadingAtom = Atom(name: '_CategoriaStore.loading');

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

  final _$_CategoriaStoreActionController =
      ActionController(name: '_CategoriaStore');

  @override
  dynamic setCategorias(List<Categoria> categorias) {
    final _$actionInfo = _$_CategoriaStoreActionController.startAction(
        name: '_CategoriaStore.setCategorias');
    try {
      return super.setCategorias(categorias);
    } finally {
      _$_CategoriaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String value) {
    final _$actionInfo = _$_CategoriaStoreActionController.startAction(
        name: '_CategoriaStore.setError');
    try {
      return super.setError(value);
    } finally {
      _$_CategoriaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_CategoriaStoreActionController.startAction(
        name: '_CategoriaStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_CategoriaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
error: ${error},
loading: ${loading},
getAallCategorias: ${getAallCategorias}
    ''';
  }
}
