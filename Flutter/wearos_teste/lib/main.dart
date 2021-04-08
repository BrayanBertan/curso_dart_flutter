import 'package:flutter/material.dart';
import 'package:wear/wear.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: WatchShape(
            builder: (context, shape, child) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/corno.jpg')
                  )
                ),
              );
            },
            child: AmbientMode(
              builder: (context, mode, child) {
                return Text(
                  '',
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}