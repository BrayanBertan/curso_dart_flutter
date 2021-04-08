import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_clone/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_clone/stores/user_manager_store.dart';
import 'package:xlo_clone/views/favorites_view/favorite_view.dart';
import 'package:xlo_clone/views/meus_anuncios/meus_anuncios_view.dart';
import 'package:xlo_clone/views/minha_conta/edit_account_view.dart';

class MinhaContaPage extends StatefulWidget {
  @override
  _MinhaContaPageState createState() => _MinhaContaPageState();
}

class _MinhaContaPageState extends State<MinhaContaPage> {
  final UserManagerStore user = GetIt.I<UserManagerStore>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha página'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: EdgeInsets.all(30),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => EditAccountPage()));
                        },
                        child: Text(
                          'Editar',
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        )),
                  ),
                  Observer(builder: (_) {
                    return Column(
                      children: [
                        Text(
                          user.user.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          user.user.email,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    );
                  }),
                  SizedBox(
                    height: 50,
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Meus anúncios',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.purple,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                      IconButton(
                          icon: Icon(Icons.arrow_right),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => MeusAnunciosPages()));
                          })
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Favoritos',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.purple,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                      IconButton(
                          icon: Icon(Icons.arrow_right),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => FavoritePage(hide: true)));
                          })
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
