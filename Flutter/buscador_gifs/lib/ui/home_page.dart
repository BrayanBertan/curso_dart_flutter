import 'dart:convert';

import 'package:buscador_gifs/ui/gif_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search;
  int _offset = 0;
  Future<Map> _getGifs() async {
    http.Response response;
    if (_search == null) {
      response = await http.get(
          "https://api.giphy.com/v1/gifs/trending?api_key=3ZQnTIxfPCzOqC3AB0wxfmDItvJfgsA9&limit=4&rating=g");
    } else {
      response = await http.get(
          "https://api.giphy.com/v1/gifs/search?api_key=3ZQnTIxfPCzOqC3AB0wxfmDItvJfgsA9&q=$_search&limit=4&offset=$_offset&rating=g&lang=en");
    }

    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    _getGifs().then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.network(
            "https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12.5),
            child: TextField(
              decoration: InputDecoration(
                  labelText: "Pesquise",
                  labelStyle: TextStyle(color: Colors.black)),
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
              onSubmitted: (value) {
                setState(() {
                  _search = value;
                  _offset = 0;
                });
              },
            ),
          ),
          Expanded(child: FutureBuilder(
            future: _getGifs(),
            builder: (context,snapshot){
               switch(snapshot.connectionState) {
                 case ConnectionState.waiting:
                 case ConnectionState.none:
                   return Container(
                     width: 200.0,
                     height: 200.0,
                     alignment: Alignment.center,
                     child: CircularProgressIndicator(
                       valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                       strokeWidth: 8.0,
                     ),
                   );
                 default:
                    if(snapshot.hasError){
                      return Container();
                   }else{
                      return GridView.builder(
                        padding: EdgeInsets.all(12.5),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemCount: snapshot.data["data"].length+2,
                          itemBuilder: (context,index){
                              return index < snapshot.data["data"].length?
                              GestureDetector(
                                child: FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image:  snapshot.data["data"][index]["images"]["fixed_height"]["url"],
                                  height: 300.0,
                                  fit: BoxFit.cover,

                                ),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>GifPage(snapshot.data["data"][index])));
                                },
                                onLongPress: () {
                                  Share.share(snapshot.data["data"][index]["images"]["fixed_height"]["url"]);
                                },
                              )
                                  :
                              index  == snapshot.data["data"].length?

                                  GestureDetector(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.exit_to_app,color: Colors.black,),
                                        Text("voltar")
                                      ],
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _offset-=4;
                                      });
                                    },
                                  )
                                  :

                              GestureDetector(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add,color: Colors.black,),
                                    Text("Carregar")
                                  ],
                                ),
                                onTap: () {
                                  setState(() {
                                    _offset+=4;
                                  });
                                },
                              );
                          })
                      ;
                    }
              }
            },
          ))
        ],
      ),
    );
  }
}
