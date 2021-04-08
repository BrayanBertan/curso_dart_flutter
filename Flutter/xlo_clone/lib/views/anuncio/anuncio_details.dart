import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:readmore/readmore.dart';
import 'package:xlo_clone/helpers/extensions.dart';
import 'package:xlo_clone/models/anuncio.dart';
import 'package:xlo_clone/stores/favorite_store.dart';
import 'package:xlo_clone/stores/user_manager_store.dart';
import 'package:xlo_clone/views/anuncio/components/bottom_bar.dart';

class AnuncioDetailsPage extends StatefulWidget {
  Anuncio anuncio;
  AnuncioDetailsPage({this.anuncio});
  @override
  _AnuncioDetailsPageState createState() => _AnuncioDetailsPageState();
}

class _AnuncioDetailsPageState extends State<AnuncioDetailsPage> {
  final FavoriteStore favoriteStore = GetIt.I<FavoriteStore>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Anuncio'),
          centerTitle: true,
          actions: [
            widget.anuncio.status == Adstatus.ATIVO &&
                    GetIt.I<UserManagerStore>().isLoggedIn
                ? Observer(builder: (_) {
                    return IconButton(
                        icon: Icon(favoriteStore.favoriteList
                                .any((an) => an.id == widget.anuncio.id)
                            ? Icons.favorite
                            : Icons.favorite_border),
                        onPressed: () {
                          favoriteStore.toggleFavorites(widget.anuncio);
                        });
                  })
                : Container()
          ],
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                CarouselSlider(
                  options: CarouselOptions(aspectRatio: 1.2, autoPlay: true),
                  items: widget.anuncio.images.map((image) {
                    return Builder(
                      builder: (BuildContext context) {
                        return CachedNetworkImage(
                          imageUrl: image,
                          fit: BoxFit.cover,
                        );
                      },
                    );
                  }).toList(),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          widget.anuncio.preco.formattedMoney(),
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 2.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          widget.anuncio.titulo,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Publicado em ${widget.anuncio.created.formattedDate()}',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w300),
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Descrição',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: ReadMoreText(
                          widget.anuncio.descricao,
                          textAlign: TextAlign.justify,
                          trimLines: 2,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Ver mais',
                          trimExpandedText: '...menos',
                          colorClickableText: Colors.purple,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w300),
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Localização',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('CEP'),
                                SizedBox(
                                  height: 5,
                                ),
                                Text('Municipio'),
                                SizedBox(
                                  height: 5,
                                ),
                                Text('Bairro'),
                              ],
                            )),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.anuncio.address.cep),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(widget.anuncio.address.cidade.nome),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(widget.anuncio.address.distrito),
                              ],
                            )),
                            Divider(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Anunciante',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              widget.anuncio.user.name,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Na XLO desde ${widget.anuncio.created.formattedDate()}',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w300),
                            ),
                            SizedBox(
                              height: 120,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            if (widget.anuncio.status != Adstatus.PENDENTE)
              BottomBarPage(
                anuncio: widget.anuncio,
              ),
          ],
        ));
  }
}
