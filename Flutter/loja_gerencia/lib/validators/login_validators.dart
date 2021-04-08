import 'dart:async';

import 'package:async/async.dart';

class LoginValidators {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains('@'))
      sink.add(email);
    else
      sink.addError('Insira um email valido');
  });

  final validateSenha =
      StreamTransformer<String, String>.fromHandlers(handleData: (senha, sink) {
    if (senha.length >= 6)
      sink.add(senha);
    else
      sink.addError('Insira uma senha valida com pelo menos 6 caracteres');
  });
}
