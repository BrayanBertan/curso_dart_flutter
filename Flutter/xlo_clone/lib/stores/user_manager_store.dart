import 'package:mobx/mobx.dart';
import 'package:xlo_clone/models/user.dart';
import 'package:xlo_clone/repositorios/user_repositorio.dart';

part 'user_manager_store.g.dart';

class UserManagerStore = _UserManagerStore with _$UserManagerStore;

abstract class _UserManagerStore with Store {
  _UserManagerStore() {
    _getCurrentUser();
  }
  @observable
  User user;
  @action
  void setUser(User value) => user = value;

  @computed
  bool get isLoggedIn => user != null;

  Future<void> _getCurrentUser() async {
    final user = await UserRepositorio().currentUser();
    setUser(user);
  }

  Future<void> logout() async {
    await UserRepositorio().logout();
    setUser(null);
  }
}
