// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meu_anuncio_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MeuAnuncioStore on _MeuAnuncioStore, Store {
  Computed<List<Anuncio>> _$activeAdsComputed;

  @override
  List<Anuncio> get activeAds =>
      (_$activeAdsComputed ??= Computed<List<Anuncio>>(() => super.activeAds,
              name: '_MeuAnuncioStore.activeAds'))
          .value;
  Computed<List<Anuncio>> _$pendentAdsComputed;

  @override
  List<Anuncio> get pendentAds =>
      (_$pendentAdsComputed ??= Computed<List<Anuncio>>(() => super.pendentAds,
              name: '_MeuAnuncioStore.pendentAds'))
          .value;
  Computed<List<Anuncio>> _$soldAdsComputed;

  @override
  List<Anuncio> get soldAds =>
      (_$soldAdsComputed ??= Computed<List<Anuncio>>(() => super.soldAds,
              name: '_MeuAnuncioStore.soldAds'))
          .value;

  final _$allAdsAtom = Atom(name: '_MeuAnuncioStore.allAds');

  @override
  List<Anuncio> get allAds {
    _$allAdsAtom.reportRead();
    return super.allAds;
  }

  @override
  set allAds(List<Anuncio> value) {
    _$allAdsAtom.reportWrite(value, super.allAds, () {
      super.allAds = value;
    });
  }

  final _$loadingAtom = Atom(name: '_MeuAnuncioStore.loading');

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

  final _$_getMeusAnunciosAsyncAction =
      AsyncAction('_MeuAnuncioStore._getMeusAnuncios');

  @override
  Future<void> _getMeusAnuncios() {
    return _$_getMeusAnunciosAsyncAction.run(() => super._getMeusAnuncios());
  }

  final _$soldAdAsyncAction = AsyncAction('_MeuAnuncioStore.soldAd');

  @override
  Future<void> soldAd(Anuncio ad) {
    return _$soldAdAsyncAction.run(() => super.soldAd(ad));
  }

  final _$deleteAdAsyncAction = AsyncAction('_MeuAnuncioStore.deleteAd');

  @override
  Future<void> deleteAd(Anuncio ad) {
    return _$deleteAdAsyncAction.run(() => super.deleteAd(ad));
  }

  final _$_MeuAnuncioStoreActionController =
      ActionController(name: '_MeuAnuncioStore');

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_MeuAnuncioStoreActionController.startAction(
        name: '_MeuAnuncioStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_MeuAnuncioStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
allAds: ${allAds},
loading: ${loading},
activeAds: ${activeAds},
pendentAds: ${pendentAds},
soldAds: ${soldAds}
    ''';
  }
}
