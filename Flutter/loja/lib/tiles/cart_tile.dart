import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja/helper/cart_help.dart';
import 'package:loja/model/cart_product.dart';
import 'package:loja/model/product_data.dart';

class CartTile extends StatefulWidget {
  CartProduct produto;
  CartTile(this.produto);
  @override
  _CartTileState createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  @override
  Widget build(BuildContext context) {
    CartHelper.of(context).UpdatePrice();
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: widget.produto.produto == null
          ? FutureBuilder<DocumentSnapshot>(
              future: Firestore.instance
                  .collection('produtos')
                  .document(widget.produto.categoria)
                  .collection('itens')
                  .document(widget.produto.pid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  widget.produto.produto = Produto.fromDocument(snapshot.data);
                  return _buildContent();
                } else {
                  return Container(
                    alignment: Alignment.center,
                    height: 70.0,
                    child: CircularProgressIndicator(),
                  );
                }
              })
          : _buildContent(),
    );
  }

  Widget _buildContent() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(5.0),
          width: 120.0,
          child: AspectRatio(
            aspectRatio: 0.8,
            child: Image.network(
              widget.produto.produto.url[0],
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
            child: Container(
          padding: EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.produto.produto.title),
              Text('Tamanho ${widget.produto.size}'),
              Text('R\$ ${widget.produto.produto.preco.toStringAsFixed(2)}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: widget.produto.quantidade > 1
                          ? () {
                              CartHelper.of(context).decProduct(widget.produto);
                            }
                          : null),
                  Text('${widget.produto.quantidade}'),
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        CartHelper.of(context).incProduct(widget.produto);
                      }),
                  FlatButton(
                      onPressed: () {
                        CartHelper.of(context).removeCartItem(widget.produto);
                      },
                      child: Text('Remover'))
                ],
              )
            ],
          ),
        ))
      ],
    );
  }
}
