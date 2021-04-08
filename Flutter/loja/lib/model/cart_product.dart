import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja/model/product_data.dart';

class CartProduct {
  String cid;
  String categoria;
  String pid;
  int quantidade;
  String size;

  Produto produto;

  CartProduct();
  CartProduct.fromDocument(DocumentSnapshot doc) {
    cid = doc.documentID;
    categoria = doc.data['categoria'];
    pid = doc.data['pid'];
    quantidade = doc.data['quantidade'];
    size = doc.data['size'];
  }

  Map<String, dynamic> toMap(Produto produto) {
    return {
      'categoria': categoria,
      'pid': pid,
      'quantidade': quantidade,
      'size': size,
      'produto': produto.toResumeMap()
    };
  }
}
