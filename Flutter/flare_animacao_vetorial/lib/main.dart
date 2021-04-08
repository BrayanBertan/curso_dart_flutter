import 'package:flare_animacao_vetorial/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String animacao = 'teste';

  Artboard _riveArtboard;
  RiveAnimationController _controller1, _controller2;
  @override
  void initState() {
    super.initState();
    reLoad();
   /* Future.delayed(Duration(seconds: 3)).then((value) => Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Home())));*/
    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
  }

  void reLoad() {
    rootBundle.load('assets/animacoes/$animacao.riv').then(
      (data) async {
        var file = RiveFile();

        // Load the RiveFile from the binary data.
        var success = file.import(data);
        if (success) {
          // The artboard is the root of the animation and is what gets drawn
          // into the Rive widget.
          var artboard = file.mainArtboard;
          // Add a controller to play back a known animation on the main/default
          // artboard.We store a reference to it so we can toggle playback.
          artboard.addController(_controller1 = SimpleAnimation("spin"));
          artboard.addController(
            _controller2 = SimpleAnimation("heart"),
          );
          setState(() => _riveArtboard = artboard);
          //setState(() {_controller.isActive=true;});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (animacao == 'spin') {
                      _controller2.isActive = false;
                      _controller1.isActive = true;
                      animacao = 'heart';
                    } else {
                      _controller1.isActive = false;
                      _controller2.isActive = true;
                      animacao = 'spin';
                    }
                    reLoad();
                  });
                },
                child: Container(
                    width: 200,
                    height: 200,
                    child: _riveArtboard == null
                        ? const SizedBox()
                        : Rive(artboard: _riveArtboard)))));
  }
}
