import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja/helper/user_helper.dart';
import 'package:loja/model/cart_product.dart';
import 'package:loja/model/product_data.dart';
import 'package:scoped_model/scoped_model.dart';

class CartHelper extends Model {
  UserHelper user;
  List<CartProduct> products = [];
  bool isLoading = false;

  String cupomCode;
  int discountPercentage = 0;

  CartHelper(this.user) {
    if (user.isLoggedIn()) getCartItens();
  }

  static CartHelper of(BuildContext context) =>
      ScopedModel.of<CartHelper>(context);

  void addCartItem(CartProduct cartProduct, Produto produto) {
    products.add(cartProduct);
    Firestore.instance
        .collection('users')
        .document(user.user.uid)
        .collection('cart')
        .add(cartProduct.toMap(produto))
        .then((value) {
      cartProduct.cid = value.documentID;
    });
    print(' prods $products}');
    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    Firestore.instance
        .collection('users')
        .document(user.user.uid)
        .collection('cart')
        .document(cartProduct.cid)
        .delete();
    products.remove(cartProduct);
    notifyListeners();
  }

  Future<Null> getCartItens() async {
    QuerySnapshot qs = await Firestore.instance
        .collection('users')
        .document(user.user.uid)
        .collection('cart')
        .getDocuments();
    products.clear();
    qs.documents.forEach((element) {
      products.add(CartProduct.fromDocument(element));
    });
    notifyListeners();
  }

  void decProduct(CartProduct cp) async {
    cp.quantidade--;
    await Firestore.instance
        .collection('users')
        .document(user.user.uid)
        .collection('cart')
        .document(cp.cid)
        .updateData({'quantidade': cp.quantidade});
    notifyListeners();
  }

  void incProduct(CartProduct cp) async {
    cp.quantidade++;
    await Firestore.instance
        .collection('users')
        .document(user.user.uid)
        .collection('cart')
        .document(cp.cid)
        .updateData({'quantidade': cp.quantidade});
    notifyListeners();
  }

  void setCupom(String cupomCode, int porcentagem) {
    this.cupomCode = cupomCode;
    this.discountPercentage = porcentagem;
  }

  double getProductsPrice() {
    double price = 0;
    for (CartProduct produto in products) {
      if (produto.produto != null) {
        price += produto.quantidade * produto.produto.preco;
      }
    }
    return price;
  }

  double getFretePrice() {
    return 12.00;
  }

  double getDesconto() {
    return getProductsPrice() * (discountPercentage / 100);
  }

  void UpdatePrice() {
    notifyListeners();
  }

  Future<String> finishOrder() async {
    if (products.length == 0) return null;
    isLoading = true;
    notifyListeners();
    double productPrice = getProductsPrice();
    double frete = getFretePrice();
    double desconto = getDesconto();

    DocumentReference df = await Firestore.instance.collection('orders').add({
      'clientId': user.user.uid,
      'produtos': products.map((e) => e.toMap(e.produto)).toList(),
      'frete': frete,
      'preco': productPrice,
      'desconto': desconto,
      'total': productPrice - desconto + frete,
      'status': 1
    });

    await Firestore.instance
        .collection('users')
        .document(user.user.uid)
        .collection('orders')
        .document(df.documentID)
        .setData({'orderId': df.documentID});

    QuerySnapshot query = await Firestore.instance
        .collection('users')
        .document(user.user.uid)
        .collection('cart')
        .getDocuments();

    for (DocumentSnapshot ds in query.documents) {
      ds.reference.delete();
    }
    products.clear();
    cupomCode = null;
    discountPercentage = 0;
    isLoading = false;
    notifyListeners();
    return df.documentID;
  }
}
