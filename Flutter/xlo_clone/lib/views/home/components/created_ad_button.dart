import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:xlo_clone/views/create_anuncio/create_anuncio_view.dart';

class CreateAdButton extends StatefulWidget {
  ScrollController scrollController;
  CreateAdButton(this.scrollController);
  @override
  _CreateAdButtonState createState() => _CreateAdButtonState();
}

class _CreateAdButtonState extends State<CreateAdButton>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> buttonAnimation;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    buttonAnimation = Tween<double>(begin: 0, end: 70).animate(
        CurvedAnimation(parent: controller, curve: Interval(0.4, 0.6)));
    widget.scrollController.addListener(() {
      final s = widget.scrollController.position;
      if (s.userScrollDirection == ScrollDirection.forward)
        controller.forward();
      else
        controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: buttonAnimation,
        builder: (_, __) {
          return FractionallySizedBox(
            widthFactor: 0.6,
            child: Container(
              height: 50,
              margin: EdgeInsets.only(
                  bottom: buttonAnimation.value, left: 25, right: 25),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => CreateAnuncioPage()));
                },
                style: ElevatedButton.styleFrom(primary: Colors.orange),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [Icon(Icons.camera_alt), Text('Anunciar agora')],
                ),
              ),
            ),
          );
        });
  }
}
