import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'main.dart';

class SplashOne extends StatefulWidget {
  @override
  _SplashOneState createState() => new _SplashOneState();
}

class _SplashOneState extends State<SplashOne> {
  @override
  Widget build(BuildContext context) {
    return  SplashScreen(
      image:  Image.asset(
          'assets/linux.png'),
      seconds: 8,
      navigateAfterSeconds: FirstPage(),
      backgroundColor: Color(0xFF8185E2),
     styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: () => print("Flutter Egypt"),
      loaderColor: Colors.white,
       title: Text("Linux Terminal App",
      style: TextStyle(fontSize: 28.0,
       fontWeight: FontWeight.bold,
       color: Colors.white,
      ),
     )
    );
  }
}
