import 'package:flutter/material.dart';

class StoryCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                colors: [Colors.blue, Colors.green],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft),
          ),
          child: Container(
            alignment: Alignment.center,
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black87,
            ),
            child: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage('assets/images/perfil.jpg'),
            ),
          ),
        ),
        Text(
          'Brayan.Bertan',
          style: TextStyle(color: Colors.white, fontSize: 12),
        )
      ],
    );
  }
}
