import 'package:animacoes_complexas2/views/home/home.dart';
import 'package:animacoes_complexas2/widgets/form_container.dart';
import 'package:animacoes_complexas2/widgets/sign_up_button.dart';
import 'package:animacoes_complexas2/widgets/stagger_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))..addStatusListener((status) {
          if(status == AnimationStatus.completed) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage())
            );
          }
        });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 3;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.jpg'), fit: BoxFit.cover)),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: 70.0, bottom: 32.0),
                        child: Image.asset('images/check.png',
                            width: 150.0, height: 150.0, fit: BoxFit.cover)),
                    FormContainerPage(),
                    SignUpButtonPage()
                  ],
                ),
                StaggerAnimationPage(controller: controller.view),
              ],
            )
          ],
        ),
      ), // T// his trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
