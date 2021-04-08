import 'package:exemplo1_udemy_ui/breakpoints.dart';
import 'package:flutter/material.dart';

class VantagemSection extends StatelessWidget {
  Widget buildAdavantage(String title, String subtitle) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.star_border,
          color: Colors.white,
          size: 50,
        ),
        const SizedBox(
          width: 8,
        ),
        Column(
          children: [
            Text(title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget buildAdavantageVertical(String title, String subtitle) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.star_border,
          color: Colors.white,
          size: 50,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold)),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= MOBILE_BREAKPOINT)
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey))),
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            runSpacing: 16,
            spacing: 8,
            children: [
              buildAdavantage('+45k alunos', 'Didática garantida'),
              buildAdavantage('+45k alunos', 'Didática garantida'),
              buildAdavantage('+45k alunos', 'Didática garantida')
            ],
          ),
        );
      else
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey))),
          child: Row(
            children: [
              Expanded(
                child: buildAdavantageVertical(
                    '+45k alunos', 'Didática garantida'),
              ),
              Expanded(
                child: buildAdavantageVertical(
                    '+45k alunos', 'Didática garantida'),
              ),
              Expanded(
                child: buildAdavantageVertical(
                    '+45k alunos', 'Didática garantida'),
              ),
            ],
          ),
        );
    });
  }
}
