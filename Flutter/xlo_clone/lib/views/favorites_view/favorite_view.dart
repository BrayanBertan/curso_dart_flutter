import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_clone/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_clone/helpers/extensions.dart';
import 'package:xlo_clone/stores/favorite_store.dart';
import 'package:xlo_clone/views/anuncio/anuncio_details.dart';
import 'package:xlo_clone/views/meus_anuncios/components/empty_card_view.dart';

class FavoritePage extends StatelessWidget {
  final bool hide;
  FavoritePage({this.hide = false});
  final FavoriteStore favoriteStore = GetIt.I<FavoriteStore>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: hide ? null : CustomDrawer(),
      appBar: AppBar(
        title: Text('Favoritos'),
        centerTitle: true,
      ),
      body: Observer(
        builder: (_) {
          return favoriteStore.favoriteList.isEmpty
              ? EmptyCardPage(
                  text: 'Nenhum anúncio favoritado',
                )
              : ListView.builder(
                  padding: EdgeInsets.all(12),
                  itemCount: favoriteStore.favoriteList.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => AnuncioDetailsPage(
                                  anuncio: favoriteStore.favoriteList[index],
                                )));
                      },
                      child: Container(
                        height: 100,
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          elevation: 8,
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: favoriteStore
                                        .favoriteList[index].images.isNotEmpty
                                    ? favoriteStore
                                        .favoriteList[index].images.first
                                    : 'https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png',
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.all(5),
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${favoriteStore.favoriteList[index].titulo}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        '${favoriteStore.favoriteList[index].preco.formattedMoney()}'),
                                    Text(
                                        ' ${favoriteStore.favoriteList[index].created.formattedDate()} - ${favoriteStore.favoriteList[index].address.cidade.nome} - ${favoriteStore.favoriteList[index].address.uf.sigla}'),
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                    );
                  });
        },
      ),
    );
  }
}
