import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loja_gerencia/validators/login_validators.dart';
import 'package:rxdart/rxdart.dart';

class ClienteBloc extends BlocBase with LoginValidators {
  final _clientesController = BehaviorSubject<List>();

  Map<String, Map<String, dynamic>> _clientes = {};
  Firestore _firestore = Firestore.instance;

  Stream<List> get outClientes => _clientesController.stream;

  ClienteBloc() {
    _addUsersListener();
  }

  void getGastosCliente(String uid) async {
    _clientes[uid]['sub'] = await _firestore
        .collection('users')
        .document(uid)
        .collection('orders')
        .snapshots()
        .listen((orders) async {
      double gasto = 0.0;
      int numOrders = orders.documents.length;

      for (DocumentSnapshot d in orders.documents) {
        DocumentSnapshot order =
            await _firestore.collection("orders").document(d.documentID).get();

        if (order.data == null) continue;

        gasto += order.data["total"];
      }

      /* orders.documents.forEach((order) async {
        DocumentSnapshot _documentSnapshot = await _firestore
            .collection('orders')
            .document(order.documentID)
            .get();
        if (_documentSnapshot.data != null) {
          gasto += _documentSnapshot.data['total'];
        }
      });*/

      _clientes[uid]['gastoTotal'] = gasto;
      print(gasto);
      _clientes[uid]['quantidadePedidosTotal'] = numOrders;
      _clientesController.add(_clientes.values.toList());
    });
  }

  void _unSubToOrders(String uid) {
    _clientes[uid]['sub'].cancel();
  }

  void _addUsersListener() {
    _firestore.collection('users').snapshots().listen((snapshot) {
      snapshot.documentChanges.forEach((change) {
        String uid = change.document.documentID;
        switch (change.type) {
          case DocumentChangeType.added:
            _clientes[uid] = change.document.data;
            getGastosCliente(uid);
            break;
          case DocumentChangeType.modified:
            _clientes[uid].addAll(change.document.data);
            _clientesController.add(_clientes.values.toList());
            break;
          case DocumentChangeType.removed:
            _clientes.remove((uid));
            _unSubToOrders(uid);
            _clientesController.add(_clientes.values.toList());
            break;
        }
      });
    });
  }

  void onChangedSearch(String pesquisa) {
    if (pesquisa.trim().isEmpty) {
      _clientesController.add(_clientes.values.toList());
      return;
    }

    List<Map<String, dynamic>> _suporte = List.from(_clientes.values.toList());
    _suporte.retainWhere((element) {
      return element['nome'].toUpperCase().contains(pesquisa.toUpperCase());
    });
    _clientesController.add(_suporte);
  }

  Map<String, dynamic> getUser(String cid) {
    return _clientes[cid];
  }

  @override
  void dispose() {
    _clientesController.close;
  }
}
