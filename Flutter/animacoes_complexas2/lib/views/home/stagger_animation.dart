import 'package:flutter/material.dart';

class StaggerAnimationPage extends StatefulWidget {
  final AnimationController controller;
  StaggerAnimationPage({@required this.controller})
      : containerGrow = CurvedAnimation(parent: controller, curve: Curves.decelerate),
        listSlidePosition = EdgeInsetsTween(
                begin: EdgeInsets.only(bottom: 0),
                end: EdgeInsets.only(bottom: 80))
            .animate(CurvedAnimation(
                parent: controller,
                curve: Interval(0.325, 0.8, curve: Curves.ease))),
        fadeAnimation = ColorTween(begin: Colors.green[500], end: Colors.green[100],)
            .animate(
                CurvedAnimation(parent: controller, curve: Curves.easeInExpo));

  final Animation<double> containerGrow;
  final Animation<EdgeInsets> listSlidePosition;
  final Animation<Color> fadeAnimation;
  @override
  _StaggerAnimationPageState createState() => _StaggerAnimationPageState();
}

class _StaggerAnimationPageState extends State<StaggerAnimationPage> {
  final List<String> categorias = ['Trabalho', 'Estudos', 'Casa'];
  int categoria = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: AnimatedBuilder(
          animation: widget.controller,
          builder: (context, child) {
            return Stack(children: [
              ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('images/background.jpg'))),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Bem-Vindo, Brayan',
                            style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            width: widget.containerGrow.value * 120,
                            height: widget.containerGrow.value * 120,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('images/man.png'))),
                            child: Container(
                              width: widget.containerGrow.value * 35,
                              height: widget.containerGrow.value * 35,
                              decoration: BoxDecoration(
                                  color: Colors.pinkAccent,
                                  shape: BoxShape.circle),
                              margin: EdgeInsets.only(left: 80.0),
                              child: Center(
                                child: Text(
                                  '2',
                                  style: TextStyle(
                                      fontSize: widget.containerGrow.value * 15,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (categoria > 0)
                                        categoria--;
                                      else
                                        categoria = 2;
                                    });
                                  }),
                              Text(
                                categorias[categoria],
                                style: TextStyle(color: Colors.white),
                              ),
                              IconButton(
                                  icon: Icon(Icons.arrow_forward,
                                      color: Colors.white),
                                  onPressed: () {
                                    setState(() {
                                      print(categoria);
                                      if (categoria < 2) //disableColor Icon
                                        categoria++;
                                      else
                                        categoria = 0;
                                    });
                                  }),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        margin: widget.listSlidePosition.value,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                top: BorderSide(color: Colors.grey, width: 1.0),
                                bottom: BorderSide(
                                    color: Colors.grey, width: 1.0))),
                        child: Row(
                          children: [
                            Container(
                              width: 60.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage('images/man.png'))),
                            ),
                            Column(
                              children: [
                                Text(
                                  'Titulo',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'Titulo',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: widget.listSlidePosition.value * 0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                top: BorderSide(color: Colors.grey, width: 1.0),
                                bottom: BorderSide(
                                    color: Colors.grey, width: 1.0))),
                        child: Row(
                          children: [
                            Container(
                              width: 60.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage('images/man.png'))),
                            ),
                            Column(
                              children: [
                                Text(
                                  'Titulo',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'Titulo',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: widget.listSlidePosition.value * 1,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                top: BorderSide(color: Colors.grey, width: 1.0),
                                bottom: BorderSide(
                                    color: Colors.grey, width: 1.0))),
                        child: Row(
                          children: [
                            Container(
                              width: 60.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage('images/man.png'))),
                            ),
                            Column(
                              children: [
                                Text(
                                  'Titulo',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'Titulo',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: widget.listSlidePosition.value * 2,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                top: BorderSide(color: Colors.grey, width: 1.0),
                                bottom: BorderSide(
                                    color: Colors.grey, width: 1.0))),
                        child: Row(
                          children: [
                            Container(
                              width: 60.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage('images/man.png'))),
                            ),
                            Column(
                              children: [
                                Text(
                                  'Titulo',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'Titulo',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                 IgnorePointer(
                   child:  Hero(
                       tag: 'fade',
                       child: Container(
                         decoration:
                         BoxDecoration(color: widget.fadeAnimation.value),
                       )),
                 )
                ],
              ),
            ]);
          },
        ),
      ),
    );
  }
}
