import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:xlo_clone/stores/edit_account_store.dart';
import 'package:xlo_clone/stores/page_store.dart';

class EditAccountPage extends StatelessWidget {
  final EditAccountStore store = EditAccountStore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Conta'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(25),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 8,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LayoutBuilder(builder: (_, constraints) {
                      return ToggleSwitch(
                        minWidth: constraints.biggest.width / 2.01,
                        labels: ['Particular', 'Profissional'],
                        cornerRadius: 16,
                        activeBgColor: Colors.purple,
                        inactiveBgColor: Colors.grey,
                        activeFgColor: Colors.white,
                        inactiveFgColor: Colors.white,
                        initialLabelIndex: store.userType.index,
                        onToggle: store.setUserType,
                      );
                    }),
                    SizedBox(
                      height: 16,
                    ),
                    Observer(builder: (_) {
                      return TextFormField(
                        initialValue: store.nome,
                        onChanged: store.setNome,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            errorText: store.nomeError,
                            labelText: 'Nome*'),
                      );
                    }),
                    SizedBox(
                      height: 8,
                    ),
                    Observer(builder: (_) {
                      return TextFormField(
                        initialValue: store.telefone,
                        onChanged: store.setTelefone,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            errorText: store.telefoneError,
                            labelText: 'Telefone*'),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter()
                        ],
                      );
                    }),
                    SizedBox(
                      height: 8,
                    ),
                    Observer(builder: (_) {
                      return TextFormField(
                        initialValue: store.senha,
                        onChanged: store.setSenha,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            errorText: store.senhaError,
                            labelText: 'Senha'),
                      );
                    }),
                    SizedBox(
                      height: 8,
                    ),
                    Observer(builder: (_) {
                      return TextFormField(
                        initialValue: store.senhaConfirm,
                        onChanged: store.setSenhaConfirm,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            errorText: store.senhaError,
                            labelText: 'Confirmar senha'),
                      );
                    }),
                    SizedBox(
                      height: 16,
                    ),
                    Observer(builder: (_) {
                      return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.orange,
                              onSurface: Colors.orange,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16))),
                          onPressed: store.saveFormEdit,
                          child: Text('Salvar'));
                    }),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16))),
                        onPressed: () async {
                          store.logOut();
                          GetIt.I<PageStore>().setPage(0);
                          await Future.delayed(Duration(seconds: 2));
                          Navigator.of(context).pop();
                        },
                        child: Text('Sair'))
                  ],
                ),
              ),
            ),
          ),
          Observer(builder: (_) {
            return store.isLoading
                ? IgnorePointer(
                    ignoring: false,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 1,
                      color: Colors.black26,
                      child: Padding(
                        padding: EdgeInsets.all(50),
                        child: Center(
                          child: LinearProgressIndicator(
                            minHeight: 20,
                            backgroundColor: Colors.purple,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container();
          })
        ],
      ),
    );
  }
}
