import 'dart:io';

import 'package:agenda_de_contatos/helpers/contact_helper.dart';
import 'package:agenda_de_contatos/ui/contact_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

enum OrderOptions { orderaz, orderza }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();
  List<Contact> list = List();

  @override
  void initState() {
    super.initState();
    helper.getAllContact().then((value) {
      setState(() {
        list = value;
        print(list);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text("Contatos"),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<OrderOptions>(
            itemBuilder: (context) {
              return <PopupMenuEntry<OrderOptions>>[
                 PopupMenuItem<OrderOptions>(
                    child: Text("Ordenar de A-Z"),
                   value: OrderOptions.orderaz,
              ),
                 PopupMenuItem<OrderOptions>(child: Text("Ordenar de Z-A"),
                   value: OrderOptions.orderza,
                 )
              ];
            },
            onSelected: (value) {
              print("testeeeeeee $value");
              switch (value) {
                case OrderOptions.orderaz:
                  list.sort((a, b) {
                    return a.nome.toLowerCase().compareTo(b.nome.toLowerCase());
                  });
                  break;
                case OrderOptions.orderza:
                  list.sort((a, b) {
                    return b.nome.toLowerCase().compareTo(a.nome.toLowerCase());
                  });
                  break;
              }
              setState(() {});
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showContactPage();
        },
        backgroundColor: Colors.yellow,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(25.0),
          itemCount: list.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return BottomSheet(
                          onClosing: () {},
                          builder: (context) {
                            return Container(
                              child: Container(
                                padding: EdgeInsets.all(12.5),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FlatButton(
                                        onPressed: () {
                                          launch("tel:${list[index].telefone}");
                                          Navigator.pop(context);
                                        },
                                        child: Text("Ligar")),
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          _showContactPage(
                                              contact: list[index]);
                                        },
                                        child: Text("Editar")),
                                    FlatButton(
                                        onPressed: () async {
                                          await helper
                                              .deleteContact(list[index].id);
                                          Navigator.pop(context);
                                          await helper
                                              .getAllContact()
                                              .then((value) {
                                            setState(() {
                                              list = value;
                                            });
                                          });
                                        },
                                        child: Text("Deletar"))
                                  ],
                                ),
                              ),
                            );
                          });
                    });
              },
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: list[index].img != null
                                    ? FileImage(File(list[index].img))
                                    : AssetImage("images/profile.png"))),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            list[index].nome ?? "",
                            style: TextStyle(fontSize: 23.0),
                          ),
                          Text(
                            list[index].email ?? "",
                            style: TextStyle(fontSize: 15.0),
                          ),
                          Text(
                            list[index].telefone ?? "",
                            style: TextStyle(fontSize: 15.0),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  void _showContactPage({Contact contact}) async {
    final con = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ContactPage(
                  contato: contact,
                )));
    //print("contact $contact");
    //print("con $con");
    if (con != null) {
      print("1");
      if (contact != null) {
        print("2");
        await helper.updateContact(con);
      } else {
        print("salvar $con");
        await helper.saveContact(con);
      }
    }

    setState(() {
      helper.getAllContact().then((value) {
        setState(() {
          list = value;
        });
      });
    });
  }
}
