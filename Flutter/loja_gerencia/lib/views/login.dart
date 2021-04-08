import 'package:flutter/material.dart';
import 'package:loja_gerencia/blocs/login_bloc.dart';
import 'package:loja_gerencia/views/home.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    _loginBloc.outState.listen((state) {
      switch (state) {
        case LoginState.SUCCESS:
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()));
          break;
        case LoginState.FAIL:
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('Erro'),
                    content: Text('Permisão negada!'),
                  ));
          break;
        case LoginState.LOADING:
        case LoginState.IDLE:
      }
    });
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  final _loginBloc = LoginBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: SafeArea(
        child: StreamBuilder<LoginState>(
            initialData: LoginState.LOADING,
            stream: _loginBloc.outState,
            builder: (context, snapshot) {
              switch (snapshot.data) {
                case LoginState.LOADING:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                  break;
                case LoginState.FAIL:
                case LoginState.SUCCESS:
                case LoginState.IDLE:
                default:
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(),
                      SingleChildScrollView(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Icon(
                              Icons.store_rounded,
                              color: Colors.pinkAccent,
                              size: 200.0,
                            ),
                            Form(
                              child: Column(
                                children: [
                                  StreamBuilder<String>(
                                      stream: _loginBloc.outEmail,
                                      builder: (context, snapshot) {
                                        return TextFormField(
                                          onChanged: (value) {
                                            _loginBloc.changeEmail(value);
                                          },
                                          style: TextStyle(color: Colors.white),
                                          decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  left: 5.0,
                                                  right: 30.0,
                                                  bottom: 30.0,
                                                  top: 30.0),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .pinkAccent)),
                                              icon: Icon(
                                                Icons.person,
                                                color: Colors.white,
                                              ),
                                              hintText: 'Usuário',
                                              hintStyle: TextStyle(
                                                  color: Colors.white),
                                              errorText: snapshot.hasError
                                                  ? snapshot.error
                                                  : null),
                                        );
                                      }),
                                  StreamBuilder<String>(
                                      stream: _loginBloc.outSenha,
                                      builder: (context, snapshot) {
                                        return TextFormField(
                                          onChanged: (value) {
                                            _loginBloc.changeSenha(value);
                                          },
                                          style: TextStyle(color: Colors.white),
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  left: 5.0,
                                                  right: 30.0,
                                                  bottom: 30.0,
                                                  top: 30.0),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .pinkAccent)),
                                              icon: Icon(
                                                Icons.lock,
                                                color: Colors.white,
                                              ),
                                              hintText: 'Senha',
                                              hintStyle: TextStyle(
                                                  color: Colors.white),
                                              errorText: snapshot.hasError
                                                  ? snapshot.error
                                                  : null),
                                        );
                                      }),
                                ],
                              ),
                            ),
                            SizedBox(height: 30.0),
                            StreamBuilder<bool>(
                                stream: _loginBloc.outSubmitValid,
                                builder: (context, snapshot) {
                                  return SizedBox(
                                    height: 50.0,
                                    child: RaisedButton(
                                      color: Colors.pinkAccent,
                                      disabledColor:
                                          Colors.pinkAccent.withAlpha(140),
                                      onPressed: snapshot.hasData
                                          ? _loginBloc.submit
                                          : null,
                                      child: Text(
                                        'Entrar',
                                      ),
                                      textColor: Colors.white,
                                      disabledTextColor: Colors.white,
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
                    ],
                  );
                  break;
              }
            }),
      ),
    );
  }
}
