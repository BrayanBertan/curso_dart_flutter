import 'package:flutter/material.dart';
import 'package:loja/helper/cart_help.dart';
import 'package:loja/helper/user_helper.dart';
import 'package:loja/tiles/cart_tile.dart';
import 'package:loja/views/discount.dart';
import 'package:loja/views/login.dart';
import 'package:loja/views/order.dart';
import 'package:loja/widgets/cart_price.dart';
import 'package:loja/widgets/frete_button.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu carrinho'),
        centerTitle: true,
        actions: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 8.5),
            child: ScopedModelDescendant<CartHelper>(
                builder: (context, child, model) {
              int quantidadeProdutos = model.products.length;
              return Text(
                '${quantidadeProdutos ?? 0}  '
                '${quantidadeProdutos == 1 ? 'item' : 'itens'}',
                style: TextStyle(fontSize: 20.0),
              );
            }),
          )
        ],
      ),
      body: ScopedModelDescendant<CartHelper>(builder: (context, child, model) {
        if (model.isLoading && UserHelper.of(context).isLoggedIn()) {
          return Center(child: CircularProgressIndicator());
        } else if (!UserHelper.of(context).isLoggedIn()) {
          return Container(
            padding: EdgeInsets.all(15.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.remove_shopping_cart_sharp,
                  size: 150.0,
                ),
                Text(
                  'Faça login para adicionar produtos',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text('Entrar'),
                  ),
                )
              ],
            ),
          );
        } else if (model.products == null || model.products.length < 1) {
          return Container(
            //ou center
            alignment: AlignmentDirectional.center,
            child: Text(
              'Sem itens no carrinho',
              style: TextStyle(fontSize: 30.0),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return Column(
            children: [
              Flexible(
                  flex: 5,
                  child: ListView(
                    padding: EdgeInsets.all(12.5),
                    children: [
                      Column(
                        children: model.products.map((produto) {
                          return CartTile(produto);
                        }).toList(),
                      )
                    ],
                  )),
              Flexible(
                  flex: 7,
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          DiscountPage(),
                          FretePage(),
                          CartPricePage(() async {
                            String orderId = await model.finishOrder();
                            if (orderId != null) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          OrderPage(orderId)));
                            } else {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('Erro ao finalizar pedido')));
                            }
                          })
                        ],
                      )
                    ],
                  ))
            ],
          );
        }
      }),
    );
  }
}
