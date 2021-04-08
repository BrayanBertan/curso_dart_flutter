import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_clone/helpers/extensions.dart';
import 'package:xlo_clone/repositorios/user_repositorio.dart';

import 'user_manager_store.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  String email;

  @observable
  String senha;

  @observable
  bool loading = false;

  @observable
  String error = null;
  @action
  void setEmail(String value) => email = value;
  @action
  void setSenha(String value) => senha = value;

  @action
  Future<void> _signIn() async {
    loading = true;
    try {
      error = null;
      final user = await UserRepositorio().signInWithEmail(email, senha);
      error = null;
      GetIt.I<UserManagerStore>().setUser(user);
    } catch (e) {
      error = e;
    }
    loading = false;
  }

  @computed
  bool get emailValid => email != null && email.isEmailValid();

  @computed
  String get emailError {
    if (email == null || emailValid)
      return null;
    else if (email.trim().isEmpty)
      return 'Campo obrigatório';
    else
      return 'Email invalido';
  }

  @computed
  bool get senhaValid => senha != null && senha.length >= 4;

  @computed
  String get senhaError {
    if (senha == null || senhaValid)
      return null;
    else if (senha.trim().isEmpty)
      return 'Campo obrigatório';
    else
      return 'senha invalida';
  }

  @computed
  Function get loginValid => emailValid && senhaValid ? _signIn : null;
}
