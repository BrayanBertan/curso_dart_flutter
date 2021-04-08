import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:loja_gerencia/blocs/cliente_bloc.dart';
import 'package:loja_gerencia/tiles/cliente_tile.dart';

class ClientesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _clienteBloc = BlocProvider.of<ClienteBloc>(context);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              onChanged: _clienteBloc.onChangedSearch,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  hintText: 'Pesquisar',
                  hintStyle: TextStyle(color: Colors.white),
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  border: InputBorder.none),
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: _clienteBloc.outClientes,
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : snapshot.data.length == 0
                          ? Center(
                              child: Text('0 clientes'),
                            )
                          : ListView.separated(
                              itemBuilder: (context, index) =>
                                  ClienteTile(snapshot.data[index]),
                              separatorBuilder: (context, index) => Divider(
                                    color: Colors.white,
                                  ),
                              itemCount: snapshot.data.length);
                }),
          )
        ],
      ),
    );
  }
}
