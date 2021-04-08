import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(ImcApp());
}

class ImcApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImcPage(),
    );
  }
}

class ImcPage extends StatefulWidget {
  @override
  _ImcPageState createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String infoText = "Informe os seus dados";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  weightController.text = "";
                  heightController.text = "";
                  setState(() {
                    infoText = "Informe os seus dados";
                    _formKey = GlobalKey<FormState>();
                  });
                })
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.person_outline, size: 150, color: Colors.green),
                  TextFormField(
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso (kg)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green),
                    validator: (value) {
                      if (value.isEmpty) {
                        return  "Insira o seu peso";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: heightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira a seu altura";
                      }
                      return null;
                    },
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Container(
                        height: 50.0,
                        child: RaisedButton(
                          child: Text(
                            "Calcular",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              double weight =
                                  double.parse(weightController.text);
                              double height =
                                  double.parse(heightController.text) / 100;
                              double imc = weight / (height * height);
                              print(imc);
                              setState(() {
                                if (imc < 18.6) {
                                  infoText =
                                      "Abaixo do peso (${imc.toStringAsPrecision(4)})";
                                }
                              });
                            }
                          },
                          color: Colors.green,
                        ),
                      )),
                  Text(
                    infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green),
                  )
                ],
              )),
        ));
  }
}
