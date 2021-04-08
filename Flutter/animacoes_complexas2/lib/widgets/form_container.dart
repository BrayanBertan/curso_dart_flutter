import 'package:animacoes_complexas2/widgets/input_field.dart';
import 'package:flutter/material.dart';

class FormContainerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        child: Column(
          children: [
            InputFieldPage(
              hint: 'Nome',
              obscure: false,
              icon: Icons.person,
            ),
            InputFieldPage(
              hint: 'Senha',
              obscure: true,
              icon: Icons.lock,
            )
          ],
        ),
      ),
    );
  }
}
