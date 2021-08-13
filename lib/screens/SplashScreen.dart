import 'dart:async';

import 'package:angel_broking_demo/screens/DemoScreen.dart';
import 'package:angel_broking_demo/screens/mobilevalidation.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}
class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => MobileValidation()
            )
        )
    );
  }
  List<Color> myGradientColor = <Color>[
    Colors.deepPurple,
    Colors.cyan];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: myGradientColor,
          )
        ),
        child:Center(child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FlutterLogo(size:70.0),
        ))
    );
  }
}