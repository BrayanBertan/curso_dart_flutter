// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FilterStore on _FilterStore, Store {
  Computed<String> _$precoErrorComputed;

  @override
  String get precoError =>
      (_$precoErrorComputed ??= Computed<String>(() => super.precoError,
              name: '_FilterStore.precoError'))
          .value;
  Computed<bool> _$isTypeParticularComputed;

  @override
  bool get isTypeParticular => (_$isTypeParticularComputed ??= Computed<bool>(
          () => super.isTypeParticular,
          name: '_FilterStore.isTypeParticular'))
      .value;
  Computed<bool> _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_FilterStore.isFormValid'))
          .value;

  final _$orderByAtom = Atom(name: '_FilterStore.orderBy');

  @override
  OrderBy get orderBy {
    _$orderByAtom.reportRead();
    return super.orderBy;
  }

  @override
  set orderBy(OrderBy value) {
    _$orderByAtom.reportWrite(value, super.orderBy, () {
      super.orderBy = value;
    });
  }

  final _$minAtom = Atom(name: '_FilterStore.min');

  @override
  int get min {
    _$minAtom.reportRead();
    return super.min;
  }

  @override
  set min(int value) {
    _$minAtom.reportWrite(value, super.min, () {
      super.min = value;
    });
  }

  final _$maxAtom = Atom(name: '_FilterStore.max');

  @override
  int get max {
    _$maxAtom.reportRead();
    return super.max;
  }

  @override
  set max(int value) {
    _$maxAtom.reportWrite(value, super.max, () {
      super.max = value;
    });
  }

  final _$vendorTypeAtom = Atom(name: '_FilterStore.vendorType');

  @override
  int get vendorType {
    _$vendorTypeAtom.reportRead();
    return super.vendorType;
  }

  @override
  set vendorType(int value) {
    _$vendorTypeAtom.reportWrite(value, super.vendorType, () {
      super.vendorType = value;
    });
  }

  final _$_FilterStoreActionController = ActionController(name: '_FilterStore');

  @override
  void setMin(int value) {
    final _$actionInfo =
        _$_FilterStoreActionController.startAction(name: '_FilterStore.setMin');
    try {
      return super.setMin(value);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMax(int value) {
    final _$actionInfo =
        _$_FilterStoreActionController.startAction(name: '_FilterStore.setMax');
    try {
      return super.setMax(value);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOrderBy(OrderBy value) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.setOrderBy');
    try {
      return super.setOrderBy(value);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectVendorType(int value) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.selectVendorType');
    try {
      return super.selectVendorType(value);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setVendorType(int type) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.setVendorType');
    try {
      return super.setVendorType(type);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetVendorType(int type) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.resetVendorType');
    try {
      return super.resetVendorType(type);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
orderBy: ${orderBy},
min: ${min},
max: ${max},
vendorType: ${vendorType},
precoError: ${precoError},
isTypeParticular: ${isTypeParticular},
isFormValid: ${isFormValid}
    ''';
  }
}
