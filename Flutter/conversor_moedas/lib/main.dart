import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?formart=json&key=54497d47";

void main() async {
  //print(await getData());
  runApp(ConversorMoedasApp());
}

class ConversorMoedasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            hintColor: Colors.pinkAccent,
            primaryColor: Colors.white,
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber)),
              hintStyle: TextStyle(color: Colors.pinkAccent),
            )),
        home: ConversorMoedasPage());
  }
}

Future<Map> getData() async {
  var response = await http.get(request);
  print('response ${response.body}');
  print('============================================');
  print('decode ${json.decode(response.body)}');
  print('================================================');
  print('encode ${json.encode(json.decode(response.body))}');

  return json.decode(response.body)["results"]["currencies"];
}



class ConversorMoedasPage extends StatefulWidget {
  @override
  _ConversorMoedasPageState createState() => _ConversorMoedasPageState();
}

class _ConversorMoedasPageState extends State<ConversorMoedasPage> {
  double dolar;
  double euro;
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  clearAll() {
     realController.text = "";
     dolarController.text = "";
     euroController.text = "";
  }

  _realChange(String text) {
    if(text.isEmpty) {
      clearAll();
    }
      double real = double.parse(text);
      dolarController.text = (real / dolar).toStringAsFixed(2);

      euroController.text = (real / euro).toStringAsFixed(2);
    }


  _dolarChange(String text) {
    if(text.isEmpty) {
      clearAll();
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);

    euroController.text = ((dolar * this.dolar) / euro).toStringAsFixed(2);
  }

  _euroChange(String text) {
    if(text.isEmpty) {
      clearAll();
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);

    dolarController.text = ((euro * this.euro) / dolar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text("Conversos de moedas"),
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text(
                    "Carregando dados...",
                    style: TextStyle(color: Colors.yellow, fontSize: 25.0),
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Carregando dados...",
                      style: TextStyle(color: Colors.yellow, fontSize: 25.0),
                    ),
                  );
                } else {
                  dolar = snapshot.data["USD"]["buy"];
                  euro = snapshot.data["EUR"]["buy"];
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(
                          Icons.monetization_on,
                          size: 155.0,
                          color: Colors.pink,
                        ),
                        buildTextField(
                            "Reais", "R\$", realController, _realChange),
                        Divider(),
                        buildTextField(
                            "Dolares", "U\$", dolarController, _dolarChange),
                        Divider(),
                        buildTextField(
                            "Euros", "EUR\$", euroController, _euroChange)
                      ],
                    ),
                  );
                }
            }
          }),
    );
  }
}

Widget buildTextField(
    String moeda, String simbolo, TextEditingController ctrl, Function change) {
  return TextField(
    controller: ctrl,
    decoration: InputDecoration(
        labelText: moeda,
        labelStyle: TextStyle(color: Colors.pinkAccent),
        border: OutlineInputBorder(),
        prefixText: simbolo),
    style: TextStyle(color: Colors.pink),
    onChanged: (valor) {
      change(valor);
    },
    keyboardType: TextInputType.number,
  );
}
