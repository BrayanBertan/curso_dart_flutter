import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  String pid;
  OrderTile(this.pid);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream:
              Firestore.instance.collection('orders').document(pid).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Código do pedido: ${snapshot.data.documentID}'),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text('Status do pedido: ${snapshot.data['status']}'),
                  Text(_buildProductsText(snapshot.data)),
                  SizedBox(
                    height: 4.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCircle(
                          '1', 'Preparação', snapshot.data['status'], 1),
                      Container(
                        width: 40.0,
                        height: 1.0,
                        color: Colors.grey[500],
                      ),
                      _buildCircle(
                          '2', 'Transporte', snapshot.data['status'], 2),
                      Container(
                        width: 40.0,
                        height: 1.0,
                        color: Colors.grey[500],
                      ),
                      _buildCircle('2', 'Entregue', snapshot.data['status'], 3),
                    ],
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  String _buildProductsText(DocumentSnapshot ds) {
    String text = 'Descrição:\n';
    for (LinkedHashMap p in ds.data['produtos']) {
      text += "${p['quantidade']} x "
          "${p['produto']['titulo']} "
          "(R\$ ${p['produto']['preco'].toStringAsFixed(2)})\n"
          "";
    }

    text += "Total: R\$ ${ds.data['total'].toStringAsFixed(2)}";

    return text;
  }

  Widget _buildCircle(
      String titulo, String subTitulo, int status, int thisStatus) {
    Color backColor;
    Widget child;
    if (status < thisStatus) {
      backColor = Colors.grey[500];
      child = Text(
        titulo,
        style: TextStyle(color: Colors.white),
      );
    } else if (status == thisStatus) {
      backColor = Colors.blue[500];
      child = Stack(alignment: Alignment.center, children: [
        Text(
          titulo,
          style: TextStyle(color: Colors.white),
        ),
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        )
      ]);
    } else {
      backColor = Colors.green[500];
      child = Icon(Icons.check);
    }

    return Column(
      children: [
        CircleAvatar(
          radius: 20.0,
          backgroundColor: backColor,
          child: child,
        ),
        Text(subTitulo)
      ],
    );
  }
}
