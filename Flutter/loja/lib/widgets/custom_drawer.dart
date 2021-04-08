import 'package:flutter/material.dart';
import 'package:loja/helper/user_helper.dart';
import 'package:loja/tiles/drawer_tile.dart';
import 'package:loja/views/login.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController _pageController;
  CustomDrawer(this._pageController);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: [
              Container(
                height: 170.0,
                margin: EdgeInsets.only(bottom: 5.0),
                padding: EdgeInsets.all(1.5),
                child: Stack(
                  children: [
                    Positioned(
                        top: 8.0,
                        left: 0.0,
                        child: Text(
                          'Comidas',
                          style: TextStyle(fontSize: 32.0),
                          textAlign: TextAlign.center,
                        )),
                    Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        child: ScopedModelDescendant<UserHelper>(
                          builder: (context, child, model) {
                            print('logado ${model.isLoggedIn()}');
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.isLoggedIn()
                                      ? 'Olá ${model.userData['nome']}'
                                      : 'Olá',
                                  style: TextStyle(fontSize: 16.0),
                                  textAlign: TextAlign.center,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      model.isLoggedIn()
                                          ? model.signOut()
                                          : Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginPage()));
                                    },
                                    child: Text(
                                      model.isLoggedIn()
                                          ? 'Sair'
                                          : 'Entre ou se Cadastre> ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          color:
                                              Theme.of(context).primaryColor),
                                      textAlign: TextAlign.center,
                                    ))
                              ],
                            );
                          },
                        ))
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, 'Inicio', _pageController, 0),
              DrawerTile(Icons.list, 'Produtos', _pageController, 1),
              DrawerTile(
                  Icons.playlist_add_check, 'Meus Pedidos', _pageController, 2),
              DrawerTile(Icons.local_mall, 'Lojas', _pageController, 3),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 255, 153, 0),
          Color.fromARGB(255, 255, 255, 0),
          Colors.white
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomRight,
      )));
}
