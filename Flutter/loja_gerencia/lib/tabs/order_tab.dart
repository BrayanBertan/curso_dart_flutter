import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:loja_gerencia/blocs/pedido_bloc.dart';
import 'package:loja_gerencia/tiles/order_tile.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pedidosBloc = BlocProvider.of<PedidoBloc>(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: StreamBuilder<List>(
          stream: _pedidosBloc.outPedidos,
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : snapshot.data.length == 0
                    ? Center(
                        child: Text('0 pedidos'),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          return OrderTile(snapshot.data[index]);
                        },
                        itemCount: snapshot.data.length,
                      );
          }),
    );
  }
}
