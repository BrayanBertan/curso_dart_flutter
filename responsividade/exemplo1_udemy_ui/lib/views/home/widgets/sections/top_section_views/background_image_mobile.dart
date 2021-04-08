import 'package:exemplo1_udemy_ui/views/home/widgets/sections/top_section_views/info_card.dart';
import 'package:flutter/material.dart';

class BackGroundImageMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 3.2,
          child: Image(
            image: NetworkImage(
              'https://miro.medium.com/max/3200/1*87v6lN9W2PNXih5j1pnMtw.jpeg',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(0),
          child: Column(
            //  crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 400,
                  height: 250,
                  child: Stack(
                    children: [
                      InfoCard(
                        left: 0.0,
                        top: 0.0,
                        width: 300.0,
                        titleSize: 25.0,
                        subtitleSize: 12.0,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
