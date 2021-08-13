import 'package:angel_broking_demo/screens/DemoScreen.dart';
import 'package:angel_broking_demo/screens/SignUpPage2.dart';
import 'package:angel_broking_demo/screens/SignUpPage3.dart';
import 'package:angel_broking_demo/screens/SignUpPage4.dart';
import 'package:angel_broking_demo/screens/SplashScreen.dart';
import 'package:angel_broking_demo/screens/emailvalidation.dart';
import 'package:angel_broking_demo/screens/mobilevalidation.dart';
import 'package:angel_broking_demo/screens/panvalidation.dart';
import 'package:angel_broking_demo/screens/signUpPage1.dart';
import 'package:angel_broking_demo/screens/signUpPage5.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,

      ),
      initialRoute: '/',
      routes: {
        '/': (context) => PanValidation(),
        '/demoscreen':(context) => DemoScreen(),
        '/mobilevalidation':(context)=>MobileValidation(),
        '/panvalidation':(context)=>PanValidation(),
        '/emailvalidation':(context)=>EmailValidation(),

        '/signuppage1': (context) => SignUpPage_One(),
        '/signuppage2': (context) => SignUpPage_Two(),
        '/signuppage3': (context) => SignUpPage_Three(),
        '/signuppage4': (context) => SignUpPage_Four(),
        '/signuppage5': (context) => SignUpPage_Five(),
      },
    );
  }
}