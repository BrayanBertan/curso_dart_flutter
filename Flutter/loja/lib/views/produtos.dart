import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja/tiles/product_tile.dart';

class ProdutosPage extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  ProdutosPage(this.documentSnapshot);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(documentSnapshot.data['titulo']),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            tabs: [
              Tab(
                icon: Icon(Icons.grid_on),
              ),
              Tab(
                icon: Icon(Icons.list),
              )
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance
              .collection('produtos')
              .document(documentSnapshot.documentID)
              .collection('itens')
              .getDocuments(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      GridView.builder(
                          padding: EdgeInsets.all(12.5),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 1.0,
                            mainAxisSpacing: 1.0,
                                childAspectRatio: 0.65
                          ),
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                               return ProductTile(snapshot.data.documents[index],0,documentSnapshot.documentID);
                          }),
                      ListView.builder(
                          padding: EdgeInsets.all(12.5),
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            return ProductTile(snapshot.data.documents[index],1,documentSnapshot.documentID);
                          }),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
