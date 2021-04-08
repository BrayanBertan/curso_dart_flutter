


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LojaTile extends StatelessWidget {
  DocumentSnapshot ds;

  LojaTile(this.ds);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 100.0,
            child: Image.network(
              ds.data['url'],
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${ds.data['nome']}',
                  textAlign: TextAlign.start,
                ),
                Text(
                  '${ds.data['endereco']}',
                  textAlign: TextAlign.start,
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                onPressed: () {
                  launch('https://www.google.com/maps/search/?api=1&query='
                      '${ds.data['lat']},${ds.data['long']}');
                },
                child: Text('Ver no mapa'),
                textColor: Colors.blue,
                padding: EdgeInsets.zero,
              ),
              FlatButton(
                onPressed: () {
                  launch('tel:${ds.data['fone']}');
                },
                child: Text('Ligar'),
                textColor: Colors.blue,
                padding: EdgeInsets.zero,
              ),
            ],
          )
        ],
      ),
    );
  }
}

/*  Flexible(flex: 1, child:  Image.network(ds.data['url'])),
          Flexible(flex: 1, child: Image.network(ds.data['url'])),  */