import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xlo_clone/models/anuncio.dart';

class BottomBarPage extends StatelessWidget {
  Anuncio anuncio;
  BottomBarPage({this.anuncio});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Container(
            height: 38,
            margin: EdgeInsets.symmetric(horizontal: 26),
            decoration: BoxDecoration(
                color: Colors.orange, borderRadius: BorderRadius.circular(19)),
            child: Row(
              children: [
                if (!anuncio.hidePhone)
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      final telefoneClear =
                          anuncio.user.phone.replaceAll(RegExp('[^0-9]'), '');
                      launch('tel:$telefoneClear');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border(right: BorderSide(color: Colors.black))),
                      height: 19,
                      child: Text(
                        'Ligar',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
                Expanded(
                    child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 19,
                    child: Text(
                      'Chat',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ))
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              border: Border(top: BorderSide(color: Colors.grey[400])),
            ),
            child: Text('${anuncio.user.name} anunciante'),
          )
        ],
      ),
    );
  }
}
