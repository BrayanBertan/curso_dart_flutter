import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SuggestionItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundImage: AssetImage('assets/images/perfil.jpg'),
          backgroundColor: Colors.transparent,
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'brayanbertan',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              'Brayan bertan',
              style: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
            )
          ],
        )),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {},
            child: Text('Ligar',
                style:
                    TextStyle(fontWeight: FontWeight.w400, color: Colors.grey)),
          ),
        )
      ],
    );
  }
}
