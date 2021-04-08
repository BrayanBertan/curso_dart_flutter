import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyaApp());
}

class MyaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const plataform = const MethodChannel('fb');
  int count = 0;

  @override
  void initState() {
    super.initState();
    plataform.setMethodCallHandler((call) {
      if (call.method == 'touch') {
        setState(() {
          count += 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('$count'),
            ElevatedButton(
                onPressed: () {
                  plataform
                      .invokeListMethod('isShowing')
                      .then((value) => print(value));
                },
                child: Text('is')),
            ElevatedButton(
                onPressed: () {
                  plataform.invokeListMethod("create");
                },
                child: Text('Create')),
            ElevatedButton(
                onPressed: () {
                  final response = plataform.invokeListMethod("show");
                },
                child: Text('Show')),
            ElevatedButton(
                onPressed: () {
                  plataform.invokeListMethod("hide");
                },
                child: Text('Hide')),
          ],
        ),
      ),
    );
  }
}
