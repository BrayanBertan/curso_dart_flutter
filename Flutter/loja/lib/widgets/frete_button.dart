import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja/helper/cart_help.dart';

class FretePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text('Frete'),
        leading: Icon(Icons.location_on),
        trailing: Icon(Icons.arrow_circle_down),
        children: [
          Padding(
            padding: EdgeInsets.all(8.5),
            child: TextFormField(
                onFieldSubmitted: (cep) {},
                initialValue: '',
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Digite o seu cep',
                )),
          ),
        ],
      ),
    );
  }
}
