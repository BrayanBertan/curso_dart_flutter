import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja/helper/user_helper.dart';
import 'package:loja/tiles/order_tile.dart';
import 'package:loja/views/login.dart';

class PedidosPage extends StatefulWidget {
  @override
  _PedidosPageState createState() => _PedidosPageState();
}

class _PedidosPageState extends State<PedidosPage> {
  @override
  Widget build(BuildContext context) {
    String uid = UserHelper.of(context).user.uid;
    return UserHelper.of(context).isLoggedIn()
        ? FutureBuilder<QuerySnapshot>(
            future: Firestore.instance
                .collection('users')
                .document(uid)
                .collection('orders')
                .getDocuments(),
            builder: (context, snapshot) {
              return !snapshot.hasData?
                  Center(
                    child: CircularProgressIndicator(),
                  )
              :
                  ListView(
                    children: snapshot.data.documents.map((e) =>
                        OrderTile(e.documentID)
                    ).toList(),
                  )

              ;
            })
        : Container(
            padding: EdgeInsets.all(15.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.view_list,
                  size: 150.0,
                ),
                Text(
                  'Faça login para acompanhar os seus pedidos',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text('Entrar'),
                  ),
                )
              ],
            ),
          );
    ;
  }
}
