import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_gerencia/views/produto.dart';
import 'package:loja_gerencia/widgets/edit_categoria.dart';

class CategoriaTile extends StatelessWidget {
  DocumentSnapshot documentSnapshot;

  CategoriaTile(this.documentSnapshot);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        child: ExpansionTile(
          leading: GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => EditCategoriaDialog(documentSnapshot));
            },
            child: CircleAvatar(
              child: Image.network(documentSnapshot.data['url']),
            ),
          ),
          title: Text(documentSnapshot.data['titulo']),
          children: [
            StreamBuilder<QuerySnapshot>(
              stream:
                  documentSnapshot.reference.collection('itens').snapshots(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Column(
                        children: snapshot.data.documents.map((produto) {
                          return ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProdutoPage(
                                      documentSnapshot.documentID, produto)));
                            },
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(produto.data['url'][0]),
                            ),
                            title: Text(produto.data['titulo']),
                            trailing: Text('R\$ ${produto.data['preco']}'),
                          );
                        }).toList()
                          ..add(ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProdutoPage(
                                      documentSnapshot.documentID, null)));
                            },
                            leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                            ),
                            title: Text('Adicionar'),
                          )),
                      )
                    : Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
