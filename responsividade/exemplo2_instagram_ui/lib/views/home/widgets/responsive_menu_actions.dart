import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResponsiveMenuActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ResponsiveVisibility(
            visible: false,
            visibleWhen: [Condition.smallerThan(name: TABLET)],
            child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 15,
                ),
                onPressed: () {})),
        SizedBox(
          width: 4,
        ),
        IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.white,
              size: 15,
            ),
            onPressed: () {}),
        SizedBox(
          width: 4,
        ),
        IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.white,
              size: 15,
            ),
            onPressed: () {}),
        SizedBox(
          width: 4,
        ),
        IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: Colors.white,
              size: 15,
            ),
            onPressed: () {}),
        SizedBox(
          width: 16,
        ),
        CircleAvatar(
          radius: 16,
          backgroundImage: AssetImage('assets/images/perfil.jpg'),
        )
      ],
    );
  }
}
