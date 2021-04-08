import 'package:flutter/material.dart';

class StaggerAnimationPage extends StatelessWidget {
  final AnimationController controller;

  StaggerAnimationPage({this.controller})
      : buttonSqueeze = Tween<double>(begin: 320, end: 60.0).animate(
            CurvedAnimation(parent: controller, curve: Interval(0.0, 0.150))),
        buttonZoomOut = Tween<double>(begin: 60.0, end: 10000.0).animate(
            CurvedAnimation(
                parent: controller,
                curve: Interval(0.5, 1, curve: Curves.bounceInOut)));

  final Animation<double> buttonSqueeze;
  final Animation<double> buttonZoomOut;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Padding(
            padding: EdgeInsets.only(bottom: 50.0, top: 50.0),
            child: InkWell(
                onTap: () {
                  controller.forward();
                },
                child: Hero(
                  tag: 'fade',
                  child: buttonZoomOut.value <= 60
                      ? Container(
                          width: buttonSqueeze.value,
                          height: 60.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.green[500],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          child: buttonSqueeze.value > 75
                              ? Text(
                                  'Sign in',
                                  style: TextStyle(color: Colors.white),
                                )
                              : CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                ))
                      : Container(
                          width: buttonZoomOut.value,
                          height: buttonZoomOut.value,
                          decoration: BoxDecoration(
                              color: Colors.green[500],
                              shape: buttonZoomOut.value < 500
                                  ? BoxShape.circle
                                  : BoxShape.rectangle),
                        ),
                )),
          );
        });
  }
}
