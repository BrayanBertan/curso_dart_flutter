import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_clone/models/user.dart';
import 'package:xlo_clone/repositorios/user_repositorio.dart';
import 'package:xlo_clone/stores/user_manager_store.dart';

part 'edit_account_store.g.dart';

class EditAccountStore = _EditAccountStore with _$EditAccountStore;

abstract class _EditAccountStore with Store {
  _EditAccountStore() {
    user = userManagerStore.user;
    userType = user.type;
    nome = user.name;
    telefone = user.phone;
    senha = user?.senha ?? '';
    senhaConfirm = user?.senha ?? '';
  }

  User user;

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @observable
  UserType userType;

  @action
  void setUserType(int value) => userType = UserType.values[value];

  @observable
  String nome;

  @action
  void setNome(String value) => nome = value;

  @computed
  bool get nomeValid => nome != null && nome.length >= 6;

  @computed
  String get nomeError => nomeValid || nome == null ? '' : 'Campo obrigatorio';

  @observable
  String telefone;

  @action
  void setTelefone(String value) => telefone = value;

  @computed
  bool get telefoneValid => telefone != null && telefone.length >= 14;

  @computed
  String get telefoneError =>
      telefoneValid || telefone == null ? '' : 'Campo obrigatorio';

  @observable
  String senha = '';

  @action
  void setSenha(String value) => senha = value;

  @observable
  String senhaConfirm = '';

  @action
  void setSenhaConfirm(String value) => senhaConfirm = value;

  @computed
  bool get senhaConfirmValid =>
      senha == senhaConfirm && (senha.length >= 6 || senha.isEmpty);

  @computed
  String get senhaError =>
      senhaConfirmValid || senhaConfirm == null ? '' : 'Campo obrigatorio';

  @computed
  bool get isFormValid => nomeValid && telefoneValid && senhaConfirmValid;

  @computed
  Function get saveFormEdit => isFormValid ? _save : null;

  @observable
  bool isLoading = false;

  @action
  void IsLoading(bool value) => isLoading = value;

  Future<void> _save() async {
    IsLoading(true);
    try {
      user.name = nome;
      user.phone = telefone;
      user.type = userType;
      if (senha.isNotEmpty) {
        user.senha = senha;
      } else {
        user.senha = null;
      }
      await UserRepositorio().save(user);
      userManagerStore.setUser(user);
    } catch (e) {
      print(e);
    }
    IsLoading(false);
  }

  void logOut() {
    userManagerStore.logout();
  }
}
