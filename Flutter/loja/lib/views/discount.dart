import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja/helper/cart_help.dart';

class DiscountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text('Cupom de desconto'),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: [
          Padding(
            padding: EdgeInsets.all(8.5),
            child: TextFormField(
                onFieldSubmitted: (cupom) {
                  Firestore.instance
                      .collection('cupons')
                      .document(cupom.toUpperCase())
                      .get()
                      .then((docSnap) {
                    if (docSnap.data != null) {
                      CartHelper.of(context)
                          .setCupom(cupom, docSnap.data['percentage']);
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                        'Desconto de ${docSnap.data['percentage']}% aplicado',
                        style: TextStyle(color: Colors.green),
                      )));
                    } else {
                      CartHelper.of(context).setCupom(null, 0);
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                        'Cupom invalido',
                        style: TextStyle(color: Colors.red),
                      )));
                    }
                  });
                },
                initialValue: CartHelper.of(context).cupomCode ?? '',
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Digite o seu cupom',
                )),
          ),
        ],
      ),
    );
  }
}
