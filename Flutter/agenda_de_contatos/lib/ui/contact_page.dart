import 'dart:io';

import 'package:agenda_de_contatos/helpers/contact_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ContactPage extends StatefulWidget {
  Contact contato;
  ContactPage({this.contato});
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  Contact _editedContact;
  bool edited = false;
  final _nameFocus = FocusNode();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.contato == null) {
      _editedContact = Contact(null, null, null, null);
    } else {
      _editedContact = Contact.fromMap(widget.contato.toMap());
    }
    _nomeController.text = _editedContact.nome;
    _emailController.text = _editedContact.email;
    _telefoneController.text = _editedContact.telefone;
    print(_editedContact.nome);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.yellow,
            title: Text(
              _editedContact.nome ?? "Novo Contato",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (_editedContact.nome != null &&
                  _editedContact.nome.isNotEmpty) {
                print(_editedContact);
                Navigator.pop(context, _editedContact);
              } else {
                print("2");
                FocusScope.of(context).requestFocus(_nameFocus);
              }
            },
            backgroundColor: Colors.yellow,
            child: Icon(Icons.save),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(12.5),
            child: Column(
              children: [
                Text("$edited"),
                GestureDetector(
                  onTap: () {
                    ImagePicker()
                        .getImage(source: ImageSource.camera)
                        .then((value) {
                      if (value == null) return;
                      setState(() {
                        _editedContact.img = value.path;
                      });
                    });
                  },
                  child: Container(
                      width: 180.0,
                      height: 180.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: _editedContact.img != null
                                  ? FileImage(File(_editedContact.img))
                                  : AssetImage("images/profile.png")))),
                ),
                TextField(
                  controller: _nomeController,
                  focusNode: _nameFocus,
                  decoration: InputDecoration(labelText: "Nome"),
                  onChanged: (value) {
                    setState(() {
                      edited = true;
                      _editedContact.nome = value;
                    });
                  },
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: "Email"),
                  onChanged: (value) {
                    edited == true;
                    _editedContact.email = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  controller: _telefoneController,
                  decoration: InputDecoration(labelText: "Fone"),
                  onChanged: (value) {
                    edited == true;
                    _editedContact.telefone = value;
                  },
                  keyboardType: TextInputType.phone,
                )
              ],
            ),
          ),
        ),
        onWillPop: pop);
  }

  Future<bool> pop() {
    if (edited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Descartar as alterações?"),
              content: Text("Se você sair as alterações serão perdidas"),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancelar")),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text("Sim"))
              ],
            );
          });
      return Future.value((false));
    } else {
      return Future.value((true));
    }
  }
}
