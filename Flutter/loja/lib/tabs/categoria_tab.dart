import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja/tiles/categoria_tile.dart';

class CategoriasTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection('produtos').getDocuments(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? GridView.builder(
                  padding: EdgeInsets.all(12.5),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 1.0,
                  ),
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return CategoriaTile(snapshot.data.documents[index]);
                  })
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }
}
