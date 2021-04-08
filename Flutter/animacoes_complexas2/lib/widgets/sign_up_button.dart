import 'package:flutter/material.dart';

class SignUpButtonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        padding: EdgeInsets.only(top: 160.0),
        onPressed: () {},
        child: Text(
          'Não possui uma conta? Cadastra-se',
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.white,
              fontSize: 12.5,
              letterSpacing: 0.5),
        ));
  }
}
