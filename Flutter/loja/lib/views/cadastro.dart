import 'package:flutter/material.dart';
import 'package:loja/helper/user_helper.dart';
import 'package:scoped_model/scoped_model.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _senha = TextEditingController();
  final _endereco = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Criar conta'),
        centerTitle: true,
        actions: [],
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
                        controller: _nome,
                        decoration: InputDecoration(hintText: 'Nome Completo'),
                        validator: (value) {
                          if (value.isEmpty) {
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
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        controller: _endereco,
                        decoration: InputDecoration(hintText: 'Endereço'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Inválido!';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      SizedBox(
                        height: 44.0,
                        child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              model.signUp(
                                  dataUser: {
                                    'nome': _nome.text,
                                    'email': _email.text,
                                    'endereco': _endereco.text
                                  },
                                  password: _senha.text,
                                  onSucess: () {
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text('Usuario criado'),
                                      backgroundColor: Colors.green,
                                      duration: Duration(seconds: 2),
                                    ));
                                    Future.delayed(Duration(seconds: 2)).then(
                                        (value) => Navigator.of(context).pop());
                                  },
                                  onFail: () {
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text('Erro ao criar usuario'),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 2),
                                    ));
                                  });
                            }
                          },
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            'criar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}
