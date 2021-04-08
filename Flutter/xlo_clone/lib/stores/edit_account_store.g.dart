// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_account_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EditAccountStore on _EditAccountStore, Store {
  Computed<bool> _$nomeValidComputed;

  @override
  bool get nomeValid =>
      (_$nomeValidComputed ??= Computed<bool>(() => super.nomeValid,
              name: '_EditAccountStore.nomeValid'))
          .value;
  Computed<String> _$nomeErrorComputed;

  @override
  String get nomeError =>
      (_$nomeErrorComputed ??= Computed<String>(() => super.nomeError,
              name: '_EditAccountStore.nomeError'))
          .value;
  Computed<bool> _$telefoneValidComputed;

  @override
  bool get telefoneValid =>
      (_$telefoneValidComputed ??= Computed<bool>(() => super.telefoneValid,
              name: '_EditAccountStore.telefoneValid'))
          .value;
  Computed<String> _$telefoneErrorComputed;

  @override
  String get telefoneError =>
      (_$telefoneErrorComputed ??= Computed<String>(() => super.telefoneError,
              name: '_EditAccountStore.telefoneError'))
          .value;
  Computed<bool> _$senhaConfirmValidComputed;

  @override
  bool get senhaConfirmValid => (_$senhaConfirmValidComputed ??= Computed<bool>(
          () => super.senhaConfirmValid,
          name: '_EditAccountStore.senhaConfirmValid'))
      .value;
  Computed<String> _$senhaErrorComputed;

  @override
  String get senhaError =>
      (_$senhaErrorComputed ??= Computed<String>(() => super.senhaError,
              name: '_EditAccountStore.senhaError'))
          .value;
  Computed<bool> _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_EditAccountStore.isFormValid'))
          .value;
  Computed<Function> _$saveFormEditComputed;

  @override
  Function get saveFormEdit =>
      (_$saveFormEditComputed ??= Computed<Function>(() => super.saveFormEdit,
              name: '_EditAccountStore.saveFormEdit'))
          .value;

  final _$userTypeAtom = Atom(name: '_EditAccountStore.userType');

  @override
  UserType get userType {
    _$userTypeAtom.reportRead();
    return super.userType;
  }

  @override
  set userType(UserType value) {
    _$userTypeAtom.reportWrite(value, super.userType, () {
      super.userType = value;
    });
  }

  final _$nomeAtom = Atom(name: '_EditAccountStore.nome');

  @override
  String get nome {
    _$nomeAtom.reportRead();
    return super.nome;
  }

  @override
  set nome(String value) {
    _$nomeAtom.reportWrite(value, super.nome, () {
      super.nome = value;
    });
  }

  final _$telefoneAtom = Atom(name: '_EditAccountStore.telefone');

  @override
  String get telefone {
    _$telefoneAtom.reportRead();
    return super.telefone;
  }

  @override
  set telefone(String value) {
    _$telefoneAtom.reportWrite(value, super.telefone, () {
      super.telefone = value;
    });
  }

  final _$senhaAtom = Atom(name: '_EditAccountStore.senha');

  @override
  String get senha {
    _$senhaAtom.reportRead();
    return super.senha;
  }

  @override
  set senha(String value) {
    _$senhaAtom.reportWrite(value, super.senha, () {
      super.senha = value;
    });
  }

  final _$senhaConfirmAtom = Atom(name: '_EditAccountStore.senhaConfirm');

  @override
  String get senhaConfirm {
    _$senhaConfirmAtom.reportRead();
    return super.senhaConfirm;
  }

  @override
  set senhaConfirm(String value) {
    _$senhaConfirmAtom.reportWrite(value, super.senhaConfirm, () {
      super.senhaConfirm = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_EditAccountStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$_EditAccountStoreActionController =
      ActionController(name: '_EditAccountStore');

  @override
  void setUserType(int value) {
    final _$actionInfo = _$_EditAccountStoreActionController.startAction(
        name: '_EditAccountStore.setUserType');
    try {
      return super.setUserType(value);
    } finally {
      _$_EditAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNome(String value) {
    final _$actionInfo = _$_EditAccountStoreActionController.startAction(
        name: '_EditAccountStore.setNome');
    try {
      return super.setNome(value);
    } finally {
      _$_EditAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTelefone(String value) {
    final _$actionInfo = _$_EditAccountStoreActionController.startAction(
        name: '_EditAccountStore.setTelefone');
    try {
      return super.setTelefone(value);
    } finally {
      _$_EditAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSenha(String value) {
    final _$actionInfo = _$_EditAccountStoreActionController.startAction(
        name: '_EditAccountStore.setSenha');
    try {
      return super.setSenha(value);
    } finally {
      _$_EditAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSenhaConfirm(String value) {
    final _$actionInfo = _$_EditAccountStoreActionController.startAction(
        name: '_EditAccountStore.setSenhaConfirm');
    try {
      return super.setSenhaConfirm(value);
    } finally {
      _$_EditAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void IsLoading(bool value) {
    final _$actionInfo = _$_EditAccountStoreActionController.startAction(
        name: '_EditAccountStore.IsLoading');
    try {
      return super.IsLoading(value);
    } finally {
      _$_EditAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userType: ${userType},
nome: ${nome},
telefone: ${telefone},
senha: ${senha},
senhaConfirm: ${senhaConfirm},
isLoading: ${isLoading},
nomeValid: ${nomeValid},
nomeError: ${nomeError},
telefoneValid: ${telefoneValid},
telefoneError: ${telefoneError},
senhaConfirmValid: ${senhaConfirmValid},
senhaError: ${senhaError},
isFormValid: ${isFormValid},
saveFormEdit: ${saveFormEdit}
    ''';
  }
}
