import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_clone/helpers/extensions.dart';
import 'package:xlo_clone/models/user.dart';
import 'package:xlo_clone/repositorios/user_repositorio.dart';
import 'user_manager_store.dart';
part 'signup_store.g.dart';

class SignupStore = _SignupStore with _$SignupStore;

abstract class _SignupStore with Store {
  @observable
  String name;

  @observable
  String email;

  @observable
  String phone;

  @observable
  String senha;

  @observable
  String senhaC;

  @observable
  bool loading = false;

  @observable
  String error = null;

  @action
  void setName(String value) => name = value;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPhone(String value) => phone = value;
  @action
  void setSenha(String value) => senha = value;
  @action
  void setSenhaC(String value) => senhaC = value;

  @action
  Future<void> _signUp() async {
    loading = true;
    final user = User(name: name, email: email, phone: phone, senha: senha);
    try {
      final resultUser = await UserRepositorio().signUp(user);
      GetIt.I<UserManagerStore>().setUser(resultUser);
      error = null;
    } catch (e) {
      error = e;
    }
    loading = false;
  }

  @computed
  bool get nameValid => name != null && name.length > 6;
  String get nameError {
    if (name == null || nameValid)
      return null;
    else if (name.trim().isEmpty)
      return 'Campo obrigatório';
    else
      return 'Nome muito curto';
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
  bool get phoneValid => phone != null && phone.length >= 14;

  @computed
  String get phoneError {
    if (phone == null || phoneValid)
      return null;
    else if (phone.trim().isEmpty)
      return 'Campo obrigatório';
    else
      return 'telefone invalido';
  }

  @computed
  bool get senhaValid => senha != null && senha.length > 6;

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
  bool get senhaCValid => senhaC != null && senha == senhaC;

  @computed
  String get senhaCError {
    if (senhaC == null || senhaCValid)
      return null;
    else
      return 'senha invalida';
  }

  @computed
  bool get isFormValid =>
      emailValid && nameValid && phoneValid && senhaValid && senhaCValid;

  @computed
  Function get signUpValid => isFormValid ? _signUp : null;
}
