import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_clone/stores/connectivity_store.dart';
import 'package:xlo_clone/stores/page_store.dart';
import 'package:xlo_clone/views/create_anuncio/create_anuncio_view.dart';
import 'package:xlo_clone/views/favorites_view/favorite_view.dart';
import 'package:xlo_clone/views/home/home_view.dart';
import 'package:xlo_clone/views/minha_conta/minha_conta_view.dart';
import 'package:xlo_clone/views/offline/offiline_view.dart';

class BasePage extends StatefulWidget {
  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final PageController pageController = PageController();

  final PageStore pageStore = GetIt.I<PageStore>();
  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();

  @override
  void initState() {
    super.initState();

    reaction((_) => pageStore.page, (page) {
      print('page reaction ${page}');
      Navigator.of(context).pop();
      pageController.jumpToPage(page);
    });

    autorun((_) {
      print(
          '========================conectadooooooooooooooo ${connectivityStore.connected}');
      if (!connectivityStore.connected) {
        Future.delayed(Duration(milliseconds: 250)).then((value) =>
            showDialog(context: context, builder: (_) => OfflinePage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) {
          return PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              HomePage(),
              CreateAnuncioPage(),
              Container(
                color: Colors.red,
              ),
              FavoritePage(),
              MinhaContaPage(),
            ],
          );
        },
      ),
    );
  }
}
