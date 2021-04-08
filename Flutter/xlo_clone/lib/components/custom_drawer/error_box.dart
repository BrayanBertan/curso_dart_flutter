import 'package:flutter/material.dart';

class ErrorBox extends StatefulWidget {
  String message;

  ErrorBox({this.message});

  @override
  _ErrorBoxState createState() => _ErrorBoxState();
}

class _ErrorBoxState extends State<ErrorBox> {
  @override
  Widget build(BuildContext context) {
    return widget.message != null
        ? Container(
      padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(30.0)),
            child: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: Text(
                    'Oops! ${widget.message}',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          )
        : Container();
  }
}
