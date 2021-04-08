import 'package:flutter/material.dart';
import 'package:loja/tabs/home_tab.dart';
import 'package:loja/tabs/loja_tab.dart';
import 'package:loja/views/meus_pedidos.dart';
import 'package:loja/widgets/cart_button.dart';
import 'package:loja/widgets/custom_drawer.dart';
import 'package:loja/tabs/categoria_tab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Scaffold(
            body: HomeTabPage(),
            drawer: CustomDrawer(_pageController),
            floatingActionButton: CartButton(),
          ),
          Scaffold(
            appBar: AppBar(
              title: Text('Categorias'),
              centerTitle: true,
            ),
            drawer: CustomDrawer(_pageController),
            body: CategoriasTab(),
            floatingActionButton: CartButton(),
          ),
          Scaffold(
            appBar: AppBar(
              title: Text('Meus Pedidos'),
              centerTitle: true,
            ),
            drawer: CustomDrawer(_pageController),
            body: PedidosPage(),
          ),
          Scaffold(
            appBar: AppBar(
              title: Text('Lojas'),
              centerTitle: true,
            ),
            drawer: CustomDrawer(_pageController),
            body: LojasTab(),
          ),
        ]);
  }
}
