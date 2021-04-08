import 'package:exemplo1_udemy_ui/views/home/widgets/custom_search_field.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final top;
  final left;
  final width;
  final titleSize;
  final subtitleSize;
  InfoCard(
      {this.top, this.left, this.width, this.titleSize, this.subtitleSize});
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: top,
        left: left,
        child: Card(
          color: Colors.black,
          elevation: 3,
          child: Container(
            padding: const EdgeInsets.all(25),
            width: width,
            child: Column(
              children: [
                Text(
                  'Aprenda flutter com este curso',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                    'Aprenda flutter com este curso Aprenda '
                    'flutter com este curso '
                    'Aprenda flutter com este curso'
                    ' Aprenda flutter com este curso '
                    'Aprenda flutter com este curso ',
                    style:
                        TextStyle(color: Colors.white, fontSize: subtitleSize)),
                const SizedBox(
                  height: 16,
                ),
                CustomSearchField()
              ],
            ),
          ),
        ));
  }
}
