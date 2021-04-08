import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CourseItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.network(
          'https://miro.medium.com/max/3840/1*qLw7bQ7iKrXWLtL2p-lzdw.png',
          fit: BoxFit.fitWidth,
        ),
        const SizedBox(
          height: 4,
        ),
        Flexible(
          child: AutoSizeText(
            'Titulo curso criação de apps responsivo',
            maxLines: 2,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
          ),
        ),
        Text(
          'Professor Tooru Nishimura',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 12.5, color: Colors.white),
        ),
        Text(
          'R\$24,99',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
        )
      ],
    );
  }
}
