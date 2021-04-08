import 'package:exemplo1_udemy_ui/views/home/widgets/app_bar/web_app_bar_content.dart';
import 'package:flutter/material.dart';

class WebAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      toolbarHeight: 72,
      title: Row(
        children: [
          Text('Flutter'),
          const SizedBox(
            width: 32,
          ),
          WebAppBarContent(),
          const SizedBox(
            width: 24,
          ),
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
          const SizedBox(
            width: 24,
          ),
          SizedBox(
            height: 38,
            child: OutlinedButton(
                onPressed: () {},
                child: Text('Fazer login'),
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  side: BorderSide(width: 2, color: Colors.white),
                )),
          ),
          const SizedBox(
            width: 8,
          ),
          SizedBox(
            height: 40,
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Cadastre-se'),
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.black,
                primary: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
