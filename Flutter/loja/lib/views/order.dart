import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  String id;

  OrderPage(this.id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedido realizado'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check,
              color: Theme.of(context).primaryColor,
              size: 23.0,
            ),
            Text('Pedido realizado com sucesso'),
            Text(
              id,
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
