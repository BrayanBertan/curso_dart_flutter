import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_clone/models/user.dart';
import 'package:xlo_clone/repositorios/parse_errors.dart';
import 'package:xlo_clone/repositorios/table_keys.dart';

class UserRepositorio {
  Future<User> signUp(User user) async {
    final parseUser = ParseUser(user.email, user.senha, user.email);

    parseUser.set<String>(KEY_USER_NAME, user.name);
    parseUser.set<String>(KEY_USER_PHONE, user.phone);
    parseUser.set<int>(KEY_USER_TYPE, user.type.index);

    final response = await parseUser.signUp();
    if (response.success) {
      return MapParseToUser(response.result);
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<User> signInWithEmail(String email, String senha) async {
    final parseUser = ParseUser(email, senha, null);

    final response = await parseUser.login();
    if (response.success) {
      return MapParseToUser(response.result);
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<User> currentUser() async {
    final parseUser = await ParseUser.currentUser();

    if (parseUser != null) {
      final response =
          await ParseUser.getCurrentUserFromServer(parseUser.sessionToken);
      if (response.success) {
        return MapParseToUser(response.result);
      } else {
        await parseUser.logout();
      }
    }
    return null;
  }

  User MapParseToUser(ParseUser parseUser) {
    return User(
      id: parseUser.objectId,
      createdAt: parseUser.createdAt,
      name: parseUser.get(KEY_USER_NAME),
      email: parseUser.get(KEY_USER_EMAIL),
      phone: parseUser.get(KEY_USER_PHONE),
      type: UserType.values[parseUser.get(KEY_USER_TYPE)],
    );
  }

  Future<void> save(User user) async {
    final parseUser = await ParseUser.currentUser();
    if (parseUser != null) {
      parseUser.set<String>(KEY_USER_NAME, user.name);
      parseUser.set<String>(KEY_USER_PHONE, user.phone);
      parseUser.set<int>(KEY_USER_TYPE, user.type.index);

      if (user.senha != null) parseUser.password = user.senha;

      final response = await parseUser.save();

      if (!response.success)
        return Future.error(ParseErrors.getDescription(response.error.code));

      if (user.senha != null) {
        await parseUser.logout();

        final loginResponse =
            await parseUser(user.email, user.senha, user.email).login();

        if (!loginResponse.success)
          return Future.error(ParseErrors.getDescription(response.error.code));
      }
    }
  }

  Future<void> logout() async {
    final parseUser = await ParseUser.currentUser();
    await parseUser.logout();
  }
}
