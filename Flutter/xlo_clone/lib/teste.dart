import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          color: Colors.blue,
          width: 300,
          child: Container(
            color: Colors.green,
            width: 100,
            height: 100,
          )),
    );
  }
}
