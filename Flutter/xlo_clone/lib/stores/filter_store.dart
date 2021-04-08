import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_clone/stores/home_store.dart';

part 'filter_store.g.dart';

enum OrderBy { DATE, PRICE }
const VENDOR_TYPE_PARTICULAR = 1 << 0;
const VENDOR_TYPE_PROFISISONAL = 1 << 1;

class FilterStore = _FilterStore with _$FilterStore;

abstract class _FilterStore with Store {
  _FilterStore(
      {this.orderBy = OrderBy.DATE,
      this.min,
      this.max,
      this.vendorType = VENDOR_TYPE_PARTICULAR});
  @observable
  OrderBy orderBy;

  @observable
  int min;

  @observable
  int max;

  @action
  void setMin(int value) => min = value;

  @action
  void setMax(int value) => max = value;

  @action
  void setOrderBy(OrderBy value) => orderBy = value;

  @computed
  String get precoError => max != null && min != null && min > max
      ? 'Faixa de preço inválida'
      : null;

  @observable
  int vendorType;

  @action
  void selectVendorType(int value) => vendorType = value;
  @action
  void setVendorType(int type) => vendorType = vendorType | type;
  @action
  void resetVendorType(int type) => vendorType = vendorType & ~type;

  @computed
  bool get isTypeParticular => (vendorType & VENDOR_TYPE_PARTICULAR) != 0;
  bool get isTypeProfissional => (vendorType & VENDOR_TYPE_PROFISISONAL) != 0;

  @computed
  bool get isFormValid => precoError == null;

  void setFilter() {
    GetIt.I<HomeStore>().setFilter(this);
  }

  FilterStore clone() {
    return FilterStore(
        max: max, min: min, orderBy: orderBy, vendorType: vendorType);
  }
}
