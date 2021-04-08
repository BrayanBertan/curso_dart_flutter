import 'package:flutter/material.dart';
import 'package:loja/helper/cart_help.dart';
import 'package:loja/views/home.dart';
import 'package:loja/views/login.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:loja/helper/user_helper.dart';

void main() {
  runApp(LojaApp());
}

class LojaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserHelper>(
        model: UserHelper(),
        child: ScopedModelDescendant<UserHelper>(
          builder: (context, child, model) {
            return ScopedModel<CartHelper>(
              model: CartHelper(model),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                    primarySwatch: Colors.deepOrange,
                    primaryColor: Color.fromARGB(255, 204, 102, 0)),
                home: HomePage(),
              ),
            );
          },
        ));
  }
}
