import 'package:flutter/material.dart';
import 'package:loja/helper/user_helper.dart';
import 'package:loja/views/cadastro.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _email = TextEditingController();
  final _senha = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Entrar'),
          centerTitle: true,
          actions: [
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => CadastroPage()));
                },
                child: Text(
                  'Criar conta',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: ScopedModelDescendant<UserHelper>(
          builder: (context, child, model) {
            return model.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Form(
                    key: _formKey,
                    child: ListView(
                      padding: EdgeInsets.all(12.5),
                      children: [
                        TextFormField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(hintText: 'E-mail'),
                          validator: (value) {
                            if (value.isEmpty || !value.contains('@')) {
                              return 'Inválido!';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        TextFormField(
                          controller: _senha,
                          obscureText: true,
                          decoration: InputDecoration(hintText: 'Senha'),
                          validator: (value) {
                            if (value.isEmpty || value.length < 6) {
                              return 'Inválido!';
                            } else {
                              return null;
                            }
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              if (_email.text.isEmpty) {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text('Email invalido'),
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 2),
                                ));
                              } else {
                                model.recoverPassword(_email.text);
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text('Confira o seu email'),
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 2),
                                ));
                              }
                            },
                            child: Text(
                              'Esqueci minha senha',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        SizedBox(
                          height: 44.0,
                          child: RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {}
                              model.signIn(
                                  email: _email.text,
                                  senha: _senha.text,
                                  onSucess: () {
                                    Navigator.of(context).pop();
                                  },
                                  onFail: () {
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text('Erro ao logar'),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 2),
                                    ));
                                  });
                            },
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              'entrar',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
          },
        ));
  }
}
