import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ClienteTile extends StatelessWidget {
  final Map<String, dynamic> cliente;

  ClienteTile(this.cliente);
  @override
  Widget build(BuildContext context) {
    return !cliente.containsKey('gastoTotal')
        ? Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            height: 20,
            child: Shimmer.fromColors(child: Container(color: Colors.white.withAlpha(50),margin: EdgeInsets.symmetric(vertical: 4),
            ), baseColor: Colors.white, highlightColor: Colors.grey),
          ),
          SizedBox(
            width: 50,
            height: 20,
            child: Shimmer.fromColors(child: Container(color: Colors.white.withAlpha(50),margin: EdgeInsets.symmetric(vertical: 4),
            ), baseColor: Colors.white, highlightColor: Colors.grey),
          )
        ],
      ),
    )
        : ListTile(
            title: Text(
              cliente['nome'],
              style: TextStyle(color: Colors.white),
            ),
            subtitle:
                Text(cliente['email'], style: TextStyle(color: Colors.white)),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Gasto total:  ${cliente['quantidadePedidosTotal']}',
                    style: TextStyle(color: Colors.white)),
                Text(
                    'Gasto total: R\$ ${cliente['gastoTotal'].toStringAsFixed(2)}',
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          );
  }
}
