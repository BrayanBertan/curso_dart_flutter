import 'package:exemplo1_udemy_ui/views/home/widgets/sections/top_section_views/info_card.dart';
import 'package:flutter/material.dart';

class BackGroundImageWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3.2,
      child: Stack(
        children: [
          AspectRatio(
              aspectRatio: 3.4,
              child: Image(
                image: NetworkImage(
                  'https://miro.medium.com/max/3200/1*87v6lN9W2PNXih5j1pnMtw.jpeg',
                ),
              )),
          InfoCard(
            top: 50.0,
            left: 50.0,
            width: 450.0,
            titleSize: 40.0,
            subtitleSize: 18.0,
          )
        ],
      ),
    );
  }
}
