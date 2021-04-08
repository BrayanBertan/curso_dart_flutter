import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja/views/produtos.dart';
class CategoriaTile extends StatelessWidget {
  final DocumentSnapshot categoria;
  CategoriaTile(this.categoria);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProdutosPage(categoria))
          );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        color: Colors.transparent,
        elevation: 15.0,
        child: Column(
          children: [
            CircleAvatar(
              minRadius:  MediaQuery.of(context).size.width * 0.2,
              backgroundImage: NetworkImage(categoria['url']),
            ),
            Text(categoria['titulo'])
          ],
        ),
      ),
    );
  }
}
