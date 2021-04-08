import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_gerencia/blocs/cliente_bloc.dart';

class OrderTile extends StatelessWidget {
  DocumentSnapshot _pedido;

  OrderTile(this._pedido);

  final states = [
    '',
    'Em preparação',
    'Em transporte',
    'Aguardando entrega',
    'Entregue'
  ];
  @override
  Widget build(BuildContext context) {
    final _clienteBloc = BlocProvider.of<ClienteBloc>(context);
    final _user = _clienteBloc.getUser(_pedido.data['clientId']);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        child: ExpansionTile(
          key: Key(_pedido.documentID),
          title: Text(
            '#${_pedido.documentID.substring(_pedido.documentID.length - 7, _pedido.documentID.length)} ${states[_pedido.data['status']]}',
            style: TextStyle(
                color: _pedido.data['status'] != 4
                    ? Colors.grey
                    : Colors.greenAccent),
          ),
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${_user['nome']}'),
                            Text('${_user['endereco']}'),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                              'produtos  R\$ ${_pedido.data['preco'].toStringAsFixed(2)}'),
                          Text(
                              'total  R\$ ${_pedido.data['total'].toStringAsFixed(2)}'),
                        ],
                      )
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _pedido.data['produtos'].map<Widget>((produto) {
                      return ListTile(
                        title: Text(
                            '${produto['produto']['descricao']} ${produto['size']}'),
                        subtitle:
                            Text('${produto['categoria']} - ${produto['pid']}'),
                        trailing: Text('${produto['quantidade']}'),
                        contentPadding: EdgeInsets.zero,
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlatButton(
                          onPressed: () {
                            Firestore.instance
                                .collection('users')
                                .document(_pedido.data['clientId'])
                                .collection('orders')
                                .document(_pedido.documentID)
                                .delete();
                            _pedido.reference.delete();
                          },
                          textColor: Colors.red,
                          child: Text('Excluir')),
                      FlatButton(
                          onPressed: _pedido.data['status'] > 1
                              ? () {
                                  _pedido.reference.updateData(
                                      {'status': _pedido.data['status'] - 1});
                                }
                              : null,
                          textColor: Colors.grey,
                          child: Text('Regredir')),
                      FlatButton(
                          onPressed: _pedido.data['status'] < 4
                              ? () {
                                  _pedido.reference.updateData(
                                      {'status': _pedido.data['status'] + 1});
                                }
                              : null,
                          textColor: Colors.green,
                          child: Text('Avançar'))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
