import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:loja_gerencia/blocs/cliente_bloc.dart';
import 'package:loja_gerencia/blocs/pedido_bloc.dart';
import 'package:loja_gerencia/tabs/cliente_tab.dart';
import 'package:loja_gerencia/tabs/order_tab.dart';
import 'package:loja_gerencia/tabs/categoria_tab.dart';
import 'package:loja_gerencia/widgets/edit_categoria.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageviewController;
  int _page = 0;

  ClienteBloc _clienteBloc;
  PedidoBloc _pedidoBloc;

  @override
  void initState() {
    super.initState();
    pageviewController = PageController();
    _clienteBloc = ClienteBloc();
    _pedidoBloc = PedidoBloc();
  }

  @override
  void dispose() {
    pageviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[800],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Colors.pinkAccent,
              primaryColor: Colors.white,
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(caption: TextStyle(color: Colors.white))),
          child: BottomNavigationBar(
            currentIndex: _page,
            onTap: (pag) {
              pageviewController.animateToPage(pag,
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Clientes'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: 'Pedidos'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list), label: 'Produtos'),
            ],
          ),
        ),
        body: SafeArea(
          child: BlocProvider<ClienteBloc>(
            bloc: _clienteBloc,
            child: BlocProvider(
              bloc: _pedidoBloc,
              child: PageView(
                onPageChanged: (page) {
                  setState(() {
                    _page = page;
                  });
                },
                controller: pageviewController,
                children: [
                  ClientesTab(),
                  OrdersTab(),
                  CategoriaTab(),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: _page == 0
            ? null
            : _page == 1
                ? SpeedDial(
                    children: [
                      SpeedDialChild(
                          onTap: () {
                            _pedidoBloc.orderByStatus(0);
                          },
                          label: 'Concluidos abaixo',
                          child: Center(
                            child: Icon(Icons.arrow_downward),
                          )),
                      SpeedDialChild(
                          onTap: () {
                            _pedidoBloc.orderByStatus(1);
                          },
                          label: 'Concluidos acima',
                          child: Center(
                            child: Icon(Icons.arrow_upward),
                          )),
                    ],
                  )
                : FloatingActionButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => EditCategoriaDialog(null));
                    },
                    child: Icon(Icons.plus_one),
                  ));
  }
}
