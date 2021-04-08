import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja/helper/cart_help.dart';
import 'package:loja/helper/user_helper.dart';
import 'package:loja/model/cart_product.dart';
import 'package:loja/model/product_data.dart';
import 'package:loja/views/cart.dart';
import 'package:loja/views/login.dart';

class ProductPage extends StatefulWidget {
  DocumentSnapshot documentSnapshot;
  String _categoria;
  ProductPage(this.documentSnapshot, this._categoria);
  @override
  _ProductPageState createState() => _ProductPageState(documentSnapshot);
}

class _ProductPageState extends State<ProductPage> {
  DocumentSnapshot documentSnapshot;
  _ProductPageState(this.documentSnapshot);
  String tamanho = '';
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(documentSnapshot['titulo']),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 1.2,
            child: Carousel(
              images: documentSnapshot['url'].map((url) {
                return NetworkImage(url);
              }).toList(),
              dotSize: 5.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  documentSnapshot['titulo'],
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                  maxLines: 3,
                ),
                Text(
                  'R\$ ${documentSnapshot['preco']}',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Tamanho',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                  maxLines: 3,
                ),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.5),
                    children: documentSnapshot['sizes'].map<Widget>((size) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            tamanho = size;
                          });
                        },
                        child: Container(
                          width: 50.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              border: Border.all(
                                  color: size == tamanho
                                      ? primaryColor
                                      : Colors.grey,
                                  width: 3.0)),
                          child: Text(size),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: tamanho.isNotEmpty
                        ? () {
                            if (UserHelper.of(context).isLoggedIn()) {
                              print('categoria ${widget._categoria}');
                              CartProduct cp = CartProduct();
                              cp.size = tamanho;
                              cp.quantidade = 1;
                              cp.pid = documentSnapshot.documentID;
                              cp.categoria = widget._categoria;
                              CartHelper.of(context).addCartItem(
                                  cp, Produto.fromDocument(documentSnapshot));
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CartPage()));
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                            }
                          }
                        : null,
                    color: primaryColor,
                    child: Text(
                      UserHelper.of(context).isLoggedIn()
                          ? 'Adicionar ao carrinho'
                          : 'Entre para comprar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Descricão',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                  maxLines: 3,
                ),
                Text(
                  documentSnapshot['descricao'],
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
