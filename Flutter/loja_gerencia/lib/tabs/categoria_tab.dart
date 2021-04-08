import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_gerencia/tiles/categoria_tile.dart';

class CategoriaTab extends StatefulWidget {
  @override
  _CategoriaTabtate createState() => _CategoriaTabtate();
}

class _CategoriaTabtate extends State<CategoriaTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('produtos').snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return CategoriaTile(snapshot.data.documents[index]);
                  });
        });
  }

  @override
  bool get wantKeepAlive => true;
}
