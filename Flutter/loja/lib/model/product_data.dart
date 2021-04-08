import 'package:cloud_firestore/cloud_firestore.dart';

class Produto {
  String id;
  String title;
  String descricao;
  double preco;
  String categoria;
  List url;
  List sizes;

  Produto.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    title = snapshot.data['titulo'];
    descricao = snapshot.data['descricao'];
    preco = snapshot.data['preco'] + 0.0;
    url = snapshot.data['url'];
    sizes = snapshot.data['sizes'];
  }

  Map<String, dynamic> toResumeMap() {
    return {'titulo': title, 'descricao': descricao, 'preco': preco};
  }
}
