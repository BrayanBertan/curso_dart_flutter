import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class PedidoBloc extends BlocBase {
  final _pedidoController = BehaviorSubject<List>();

  List<DocumentSnapshot> _pedidos = [];

  Firestore _firestore = Firestore.instance;

  Stream<List> get outPedidos => _pedidoController.stream;

  int status = 0;

  PedidoBloc() {
    _addPedidosListener();
  }

  void _addPedidosListener() {
    _firestore.collection('orders').snapshots().listen((pedido) {
      pedido.documentChanges.forEach((change) {
        String oid = change.document.documentID;
        switch (change.type) {
          case DocumentChangeType.added:
            _pedidos.add(change.document);
            break;
          case DocumentChangeType.modified:
            _pedidos.removeWhere((pedido) => pedido.documentID == oid);
            _pedidos.add(change.document);
            break;
          case DocumentChangeType.removed:
            _pedidos.removeWhere((pedido) => pedido.documentID == oid);
            break;
        }
      });
      orderByStatus(status);
    });
  }

  void orderByStatus(int statusParam) {
    print(statusParam);
    status = statusParam;
    if (statusParam == 0) {
      _pedidos.sort((a, b) {
        return a.data['status'] < b.data['status'] ? -1 : 1;
      });
    } else {
      _pedidos.sort((a, b) {
        return a.data['status'] > b.data['status'] ? -1 : 1;
      });
    }
    _pedidoController.add(_pedidos);
  }

  @override
  void dispose() {
    _pedidoController.close();
  }
}
