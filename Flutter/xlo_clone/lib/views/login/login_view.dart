import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_clone/components/custom_drawer/error_box.dart';
import 'package:xlo_clone/stores/login_store.dart';
import 'package:xlo_clone/stores/user_manager_store.dart';
import 'package:xlo_clone/views/signup/signup_view.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginStore loginStore = LoginStore();
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  void initState() {
    super.initState();

    when((_) => userManagerStore.user != null, () {
      Navigator.of(context).pop(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Entrar'),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 32.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 8,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Observer(builder: (_) {
                          return ErrorBox(
                            message: loginStore.error,
                          );
                        }),
                        Text(
                          'Acessar com Email?',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[500]),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'Email',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[500]),
                          ),
                        ),
                        Observer(builder: (_) {
                          return TextField(
                            onChanged: loginStore.setEmail,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                errorText: loginStore.emailError,
                                isDense: true),
                            keyboardType: TextInputType.emailAddress,
                          );
                        }),
                        SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Senha',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey[500]),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'Esqueceu a sua senha?',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[500],
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Observer(builder: (_) {
                          return TextField(
                            onChanged: loginStore.setSenha,
                            decoration: InputDecoration(
                                errorText: loginStore.senhaError,
                                border: const OutlineInputBorder(),
                                isDense: true),
                            obscureText: true,
                          );
                        }),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 12),
                          height: 50,
                          child: Observer(
                            builder: (_) {
                              return ElevatedButton(
                                onPressed: loginStore.loginValid,
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.orange, // background
                                    onPrimary: Colors.white, // foreg
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25))),
                                child: Text('Entrar'),
                              );
                            },
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                          height: 3,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              Text('Não tem conta?'),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => SignUpPage()));
                                },
                                child: Text('Cadastre-se'),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Observer(builder: (_) {
              return IgnorePointer(
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 1,
                  color:
                      loginStore.loading ? Colors.black26 : Colors.transparent,
                  child: Center(
                      child: Text(loginStore.loading ? 'Carregando...' : '')),
                ),
                ignoring: !loginStore.loading,
              );
            })
          ],
        ));
  }
}
