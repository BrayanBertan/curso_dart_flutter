import 'package:flutter/material.dart';
import 'package:loja/helper/cart_help.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPricePage extends StatelessWidget {

  final VoidCallback comprar;

  CartPricePage(this.comprar);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: ScopedModelDescendant<CartHelper>(
          builder: (context, child, model) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Resumo do pedido',
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sub total',
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      ' R\$ ${model.getProductsPrice()}',
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Desconto',
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      ' - R\$ ${model.getDesconto().toStringAsFixed(2)}',
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Entrega',
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      ' R\$  ${model.getFretePrice()}',
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      ' R\$  ${(model.getProductsPrice() - model.getDesconto())}',
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                SizedBox(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: comprar,
                    child: Text('Finalizar pedido'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
