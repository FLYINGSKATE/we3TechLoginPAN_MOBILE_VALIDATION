import 'package:angel_broking_demo/screens/ImageUploadTrial.dart';
import 'package:angel_broking_demo/screens/ocr_validation_screen.dart';
import 'package:angel_broking_demo/screens/splash_screen.dart';
import 'package:angel_broking_demo/screens/email_validation.dart';
import 'package:angel_broking_demo/screens/mobile_validation.dart';
import 'package:angel_broking_demo/screens/pan_and_bank_validation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tech X Prototype',
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
        '/': (context) => SplashScreen(),
        '/mobilevalidation':(context)=>MobileValidation(),
        '/emailvalidation':(context)=>EmailValidation(),
        '/panandbankvalidation':(context)=>PanAndBankValidation(),
        '/ocrvalidation':(context)=>OcrValidationScreen(title: 'Image Picker Example'),
      },
    );
  }
}