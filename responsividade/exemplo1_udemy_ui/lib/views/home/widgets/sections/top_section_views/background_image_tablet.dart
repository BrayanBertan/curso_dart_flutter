import 'package:exemplo1_udemy_ui/views/home/widgets/sections/top_section_views/info_card.dart';
import 'package:flutter/material.dart';

class BackGroundImageTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 250,
            child: Image.network(
              'https://miro.medium.com/max/3200/1*87v6lN9W2PNXih5j1pnMtw.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          InfoCard(
            top: 20.0,
            left: 20.0,
            width: 350.0,
            titleSize: 35.0,
            subtitleSize: 18.0,
          )
        ],
      ),
    );
  }
}
