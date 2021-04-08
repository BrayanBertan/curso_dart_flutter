import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja/views/product.dart';

class ProductTile extends StatelessWidget {
  int tipo;
  DocumentSnapshot documentSnapshot;
  String categoria;
  ProductTile(this.documentSnapshot, this.tipo,this.categoria);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductPage(documentSnapshot,categoria)
        ));
      },
      child: Card(
          child: tipo == 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 0.8,
                      child: Image.network(
                        documentSnapshot['url'][0],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            documentSnapshot['titulo'],
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'R\$ ${documentSnapshot['preco']}',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ))
                  ],
                )
              : Row(
                  children: [
                    Flexible(
                        flex: 1,
                        child: Image.network(
                          documentSnapshot['url'][0],
                          fit: BoxFit.cover,
                          height: 250.0,
                        )),
                    Flexible(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                documentSnapshot['titulo'],
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'R\$ ${documentSnapshot['preco']}',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )),
                  ],
                )),
    );
  }
}
