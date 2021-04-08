import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_clone/components/custom_drawer/error_box.dart';
import 'package:xlo_clone/stores/signup_store.dart';
import 'package:xlo_clone/views/signup/components/field_title.dart';

class SignUpPage extends StatelessWidget {
  final SignupStore signupStore = SignupStore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
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
                          message: signupStore.error,
                        );
                      }),
                      FieldTitle('Apelido', 'Como aparecerá em seus anuncios'),
                      Observer(builder: (_) {
                        return TextField(
                          onChanged: signupStore.setName,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Exemplo',
                            isDense: true,
                            errorText: signupStore.nameError,
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 16,
                      ),
                      FieldTitle(
                          'Email', 'Enviaremos um e-mail de configuração'),
                      Observer(builder: (_) {
                        return TextField(
                          onChanged: signupStore.setEmail,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Exemplo',
                              isDense: true,
                              errorText: signupStore.emailError),
                        );
                      }),
                      const SizedBox(
                        height: 16,
                      ),
                      FieldTitle('Celular', 'Proteja a sua conta'),
                      Observer(builder: (_) {
                        return TextField(
                          onChanged: signupStore.setPhone,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Exemplo',
                              isDense: true,
                              errorText: signupStore.phoneError),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter()
                          ],
                        );
                      }),
                      const SizedBox(
                        height: 16,
                      ),
                      FieldTitle('Senha', 'Senha forte'),
                      Observer(builder: (_) {
                        return TextField(
                          onChanged: signupStore.setSenha,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Exemplo',
                              isDense: true,
                              errorText: signupStore.senhaError),
                          obscureText: true,
                        );
                      }),
                      const SizedBox(
                        height: 16,
                      ),
                      FieldTitle('Confirmar senha', 'repita'),
                      Observer(builder: (_) {
                        return TextField(
                          onChanged: signupStore.setSenhaC,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Exemplo',
                              isDense: true,
                              errorText: signupStore.senhaCError),
                          obscureText: true,
                        );
                      }),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 12),
                        height: 50,
                        child: Observer(
                          builder: (_) {
                            return ElevatedButton(
                              onPressed: signupStore.signUpValid,
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.orange, // background
                                  onPrimary: Colors.white, // foreg
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25))),
                              child: Text('Cadastrar'),
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
                            Text('Ja tem uma conta?'),
                            GestureDetector(
                              onTap: Navigator.of(context).pop,
                              child: Text('Entre'),
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
                    signupStore.loading ? Colors.black26 : Colors.transparent,
                child: Center(
                    child: Text(signupStore.loading ? 'Carregando...' : '')),
              ),
              ignoring: !signupStore.loading,
            );
          })
        ],
      ),
    );
  }
}
