import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja/tiles/loja_tile.dart';

class LojasTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection('lojas').getDocuments(),
        builder: (context, snapshot) {
     if(!snapshot.hasData) {
      return  Center(
         child: CircularProgressIndicator(),
       );
     }else{
       return ListView(
         children: snapshot.data.documents.map((e) => LojaTile(e)).toList(),
       );
     }
    });
  }
}
