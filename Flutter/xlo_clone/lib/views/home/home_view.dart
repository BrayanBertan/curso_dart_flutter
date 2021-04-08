import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_clone/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_clone/components/custom_drawer/error_box.dart';
import 'package:xlo_clone/helpers/extensions.dart';
import 'package:xlo_clone/stores/home_store.dart';
import 'package:xlo_clone/views/anuncio/anuncio_details.dart';
import 'package:xlo_clone/views/categoria/categoria_view.dart';
import 'package:xlo_clone/views/filter/filter_view.dart';
import 'package:xlo_clone/views/home/components/created_ad_button.dart';
import 'package:xlo_clone/views/home/components/search_dialog.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController scrollController = ScrollController();

  HomeStore homeStore = GetIt.I<HomeStore>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: Observer(
            builder: (_) {
              return homeStore.search.isEmpty
                  ? Container()
                  : GestureDetector(
                      onTap: () {
                        openSearch(context);
                      },
                      child: LayoutBuilder(
                        builder: (_, constraints) {
                          return Container(
                            width: constraints.biggest.width,
                            child: Text(homeStore.search),
                          );
                        },
                      ),
                    );
            },
          ),
          actions: [
            Observer(builder: (_) {
              return IconButton(
                icon:
                    Icon(homeStore.search.isEmpty ? Icons.search : Icons.close),
                onPressed: () {
                  homeStore.search.isEmpty
                      ? openSearch(context)
                      : homeStore.setSeartch('');
                },
              );
            }),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(5),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: Colors.white, width: 2),
                                  right: BorderSide(
                                      color: Colors.white, width: 1))),
                          height: 50,
                          child: TextButton(
                            onPressed: () async {
                              final response = await showDialog(
                                  context: context,
                                  builder: (_) {
                                    return CategoriaPage(
                                      selected: homeStore.categoria,
                                      ShowAll: true,
                                    );
                                  });
                              homeStore.setCategoria(response);
                            },
                            child: Observer(
                              builder: (_) {
                                return Text(
                                  homeStore.categoria?.descricao ??
                                      'Categorias',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: Colors.white, width: 2),
                                  left: BorderSide(
                                      color: Colors.white, width: 1))),
                          height: 50,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => FilterPage()));
                            },
                            child: Text(
                              'Filtros',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: Observer(
                    builder: (_) {
                      return homeStore.error != null
                          ? Center(
                              child: ErrorBox(
                                message: homeStore.error,
                              ),
                            )
                          : homeStore.isLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  ),
                                )
                              : homeStore.adList.isEmpty
                                  ? Center(
                                      child: ErrorBox(
                                        message: 'Nenhum anuncio encontrado',
                                      ),
                                    )
                                  : ListView.builder(
                                      controller: scrollController,
                                      itemCount: homeStore.itemCount,
                                      itemBuilder: (context, index) {
                                        if (index < homeStore.adList.length)
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          AnuncioDetailsPage(
                                                            anuncio: homeStore
                                                                .adList[index],
                                                          )));
                                            },
                                            child: Container(
                                              height: 100,
                                              child: Card(
                                                clipBehavior: Clip.antiAlias,
                                                color: Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16)),
                                                elevation: 8,
                                                child: Row(
                                                  children: [
                                                    CachedNetworkImage(
                                                      imageUrl: homeStore
                                                              .adList[index]
                                                              .images
                                                              .isNotEmpty
                                                          ? homeStore
                                                              .adList[index]
                                                              .images
                                                              .first
                                                          : 'https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Expanded(
                                                        child: Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      color: Colors.white,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            '${homeStore.adList[index].titulo}',
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                              '${homeStore.adList[index].preco.formattedMoney()}'),
                                                          Text(
                                                              ' ${homeStore.adList[index].created.formattedDate()} - ${homeStore.adList[index].address.cidade.nome} - ${homeStore.adList[index].address.uf.sigla}'),
                                                        ],
                                                      ),
                                                    ))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        else {
                                          homeStore.loadPage();
                                          return Container(
                                            child: LinearProgressIndicator(),
                                          );
                                        }
                                      });
                    },
                  ))
                ],
              ),
              Positioned(
                bottom: -50,
                left: 0,
                right: 0,
                child: CreateAdButton(scrollController),
              )
            ],
          ),
        ),
      ),
    );
  }

  openSearch(BuildContext context) async {
    final search = await showDialog(
        context: context, builder: (_) => SearchDialog(homeStore.search));
    if (search != null) homeStore.setSeartch(search);
  }
}
