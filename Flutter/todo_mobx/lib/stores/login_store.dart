import 'package:mobx/mobx.dart';
part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {



  @observable
  String email = '';

  @observable
  String senha = '';

  @observable
  bool isObscure = true;

  @observable
  bool isLoading = false;

  @observable
  bool isLoggedIn = false;

  @action
  void setEmail(String value) => email = value;

  @action
  void setSenha(String value) => senha = value;

  @action
  void setIsObscure() => isObscure = !isObscure;

  @action
  Future<void> login() async{
    isLoading = true;
   await Future.delayed(Duration(seconds: 2));
    isLoading = false;
    isLoggedIn = true;
  email = '';
  senha = '';
  }

  @computed
  get isEmailValid => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  @computed
  bool get isSenhaValid => senha.length > 6;

  @computed
  bool get isFormValid => isEmailValid && isSenhaValid;

  @computed
  Function get loginPressed => isFormValid && !isLoading? login:null;


  @action
  void logout() {
    isLoggedIn = false;
  }

  /*@computed
  bool get isFormValid => email.length > 6 && senha.length > 6;*/
}
