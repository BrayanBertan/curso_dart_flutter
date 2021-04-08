import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_clone/helpers/extensions.dart'
    '';
import 'package:xlo_clone/models/anuncio.dart';
import 'package:xlo_clone/stores/meu_anuncio_store.dart';
import 'package:xlo_clone/views/anuncio/anuncio_details.dart';
import 'package:xlo_clone/views/create_anuncio/create_anuncio_view.dart';
import 'package:xlo_clone/views/meus_anuncios/components/empty_card_view.dart';

class MeusAnunciosPages extends StatefulWidget {
  final int pageInicial;

  MeusAnunciosPages({this.pageInicial = 0});
  @override
  _MeusAnunciosPagesState createState() => _MeusAnunciosPagesState();
}

class _MeusAnunciosPagesState extends State<MeusAnunciosPages>
    with SingleTickerProviderStateMixin {
  final MeuAnuncioStore meuAnuncioStore = MeuAnuncioStore();
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: 3, vsync: this, initialIndex: widget.pageInicial);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Anuncios'),
        centerTitle: true,
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              child: Text('Ativos'),
            ),
            Tab(
              child: Text('Pendentes'),
            ),
            Tab(
              child: Text('Vendidos'),
            )
          ],
          indicatorColor: Colors.orange,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          Observer(builder: (_) {
            if (meuAnuncioStore.activeAds.isEmpty)
              return EmptyCardPage(
                text: 'Sem anúncios ativos',
              );
            if (meuAnuncioStore.loading)
              return Center(
                child: CircularProgressIndicator(),
              );
            return ListView.builder(
                itemCount: meuAnuncioStore.activeAds.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      //editAd(context, meuAnuncioStore.activeAds[index]);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => AnuncioDetailsPage(
                                anuncio: meuAnuncioStore.activeAds[index],
                              )));
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 4,
                      child: Container(
                        height: 80,
                        child: Row(
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: CachedNetworkImage(
                                imageUrl: meuAnuncioStore
                                    .activeAds[index].images.first,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 9,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(meuAnuncioStore.activeAds[index].titulo),
                                Text(meuAnuncioStore.activeAds[index].preco
                                    .formattedMoney()),
                                Text(
                                    '${meuAnuncioStore.activeAds[index].views} visitas'),
                              ],
                            )),
                            Column(
                              children: [
                                PopupMenuButton(
                                    icon: Icon(
                                      Icons.more_vert,
                                      size: 20,
                                    ),
                                    onSelected: (value) {
                                      switch (value) {
                                        case 0:
                                          editAd(
                                              context,
                                              meuAnuncioStore.activeAds[index],
                                              meuAnuncioStore);
                                          break;
                                        case 1:
                                          soldAd(
                                              context,
                                              meuAnuncioStore.activeAds[index],
                                              meuAnuncioStore);
                                          break;
                                        case 2:
                                          deleteAd(
                                              context,
                                              meuAnuncioStore.activeAds[index],
                                              meuAnuncioStore);
                                          break;
                                      }
                                    },
                                    itemBuilder: (_) {
                                      return [
                                        PopupMenuItem(
                                            value: 0,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.edit,
                                                  size: 20,
                                                  color: Colors.purple,
                                                ),
                                                SizedBox(
                                                  width: 9,
                                                ),
                                                Text(
                                                  'Editar',
                                                  style: TextStyle(
                                                      color: Colors.purple),
                                                )
                                              ],
                                            )),
                                        PopupMenuItem(
                                            value: 1,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.thumb_up_rounded,
                                                  size: 20,
                                                  color: Colors.purple,
                                                ),
                                                SizedBox(
                                                  width: 9,
                                                ),
                                                Text(
                                                  'Já vendi',
                                                  style: TextStyle(
                                                      color: Colors.purple),
                                                )
                                              ],
                                            )),
                                        PopupMenuItem(
                                            value: 2,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.delete_forever,
                                                  size: 20,
                                                  color: Colors.purple,
                                                ),
                                                SizedBox(
                                                  width: 9,
                                                ),
                                                Text(
                                                  'Excluir',
                                                  style: TextStyle(
                                                      color: Colors.purple),
                                                )
                                              ],
                                            ))
                                      ];
                                    }),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
          Observer(builder: (_) {
            if (meuAnuncioStore.pendentAds.isEmpty)
              return EmptyCardPage(
                text: 'Sem anúncios pendentes',
              );
            if (meuAnuncioStore.loading)
              return Center(
                child: CircularProgressIndicator(),
              );
            return ListView.builder(
                itemCount: meuAnuncioStore.pendentAds.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => AnuncioDetailsPage(
                                anuncio: meuAnuncioStore.pendentAds[index],
                              )));
                    },
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 4,
                      child: Container(
                        height: 80,
                        child: Row(
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: CachedNetworkImage(
                                imageUrl: meuAnuncioStore
                                    .pendentAds[index].images.first,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 9,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(meuAnuncioStore.pendentAds[index].titulo),
                                Text(meuAnuncioStore.pendentAds[index].preco
                                    .formattedMoney()),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.watch_later_outlined,
                                      color: Colors.yellow[800],
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Pendente',
                                      style:
                                          TextStyle(color: Colors.yellow[800]),
                                    ),
                                  ],
                                )
                              ],
                            )),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
          Observer(builder: (_) {
            if (meuAnuncioStore.soldAds.isEmpty)
              return EmptyCardPage(
                text: 'Sem anúncios vendidos',
              );
            if (meuAnuncioStore.loading)
              return Center(
                child: CircularProgressIndicator(),
              );
            return ListView.builder(
                itemCount: meuAnuncioStore.soldAds.length,
                itemBuilder: (context, index) {
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 4,
                    child: Container(
                      height: 80,
                      child: Row(
                        children: [
                          AspectRatio(
                            aspectRatio: 1,
                            child: CachedNetworkImage(
                              imageUrl:
                                  meuAnuncioStore.soldAds[index].images.first,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 9,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(meuAnuncioStore.soldAds[index].titulo),
                              Text(meuAnuncioStore.soldAds[index].preco
                                  .formattedMoney()),
                            ],
                          )),
                          IconButton(
                              icon: Icon(Icons.delete_forever),
                              onPressed: () {
                                deleteAd(
                                    context,
                                    meuAnuncioStore.soldAds[index],
                                    meuAnuncioStore);
                              })
                        ],
                      ),
                    ),
                  );
                });
          }),
        ],
      ),
    );
  }

  Future<void> editAd(
      BuildContext context, Anuncio ad, MeuAnuncioStore meuAnuncioStore) async {
    final success = await Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => CreateAnuncioPage(
              anuncio: ad,
            )));
    if (success != null && success) {
      meuAnuncioStore.refresh();
    }
  }

  void soldAd(
      BuildContext context, Anuncio ad, MeuAnuncioStore meuAnuncioStore) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Vendido'),
            content: Text('Confirmar a venda de ${ad.titulo}?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Não')),
              TextButton(
                  style: TextButton.styleFrom(primary: Colors.red),
                  onPressed: () {
                    meuAnuncioStore.soldAd(ad);
                    Navigator.of(context).pop();
                  },
                  child: Text('Sim'))
            ],
          );
        });
  }

  void deleteAd(
      BuildContext context, Anuncio ad, MeuAnuncioStore meuAnuncioStore) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Deletar'),
            content: Text('Confirmar a a exclusão de ${ad.titulo}?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Não')),
              TextButton(
                  style: TextButton.styleFrom(primary: Colors.red),
                  onPressed: () {
                    meuAnuncioStore.deleteAd(ad);
                    Navigator.of(context).pop();
                  },
                  child: Text('Sim'))
            ],
          );
        });
  }
}
