import 'package:flutter/material.dart';

class EmptyCardPage extends StatelessWidget {
  final String text;
  EmptyCardPage({this.text});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.all(32),
      child: Column(
        children: [
          Expanded(
              flex: 4,
              child: Icon(
                Icons.border_clear,
                size: 250,
              )),
          Divider(),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Text('Hmmm...'), Text(text)],
          )),
        ],
      ),
    );
  }
}
