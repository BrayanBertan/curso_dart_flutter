import 'package:exemplo2_instagram_ui/views/home/widgets/suggestion_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_framework/responsive_framework.dart';

class RightPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveVisibility(
        visible: false,
        visibleWhen: [Condition.largerThan(name: TABLET)],
        child: Container(
          margin: const EdgeInsets.all(20),
          width: 300,
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 29,
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        'Brayan bertan',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, color: Colors.grey),
                      )
                    ],
                  )),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {},
                      child: Text('Sair',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, color: Colors.grey)),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Sugestões para você',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {},
                      child: Text('ver tudo',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, color: Colors.grey)),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SuggestionItem(),
                  SuggestionItem(),
                  SuggestionItem(),
                ],
              )
            ],
          ),
        ));
  }
}
