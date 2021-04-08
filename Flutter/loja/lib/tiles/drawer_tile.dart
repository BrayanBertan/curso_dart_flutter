import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final PageController pageController;
  final IconData icon;
  final String texto;
  final int controller;
  DrawerTile(this.icon,this.texto,this.pageController,this.controller);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
              pageController.jumpToPage(controller);
        },
        child: Container(
          height: 60.0,
          child: Row(
            children: [
              Icon(icon,size: 32.0,color: pageController.page.round() == controller?
              Theme.of(context).primaryColor: Colors.grey,),
              SizedBox(width: 32.0,),
              Text(texto,style: TextStyle(
                  fontSize: 16.0,
                  color: pageController.page.round() == controller?
                  Theme.of(context).primaryColor: Colors.grey),)
            ],
          ),
        ),
      ),
    );
  }
}
