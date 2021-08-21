import 'dart:io';

import 'package:angel_broking_demo/screens/screen_one.dart';
import 'package:angel_broking_demo/screens/demo_screen.dart';
import 'package:angel_broking_demo/screens/ocr_validation_screen.dart';
import 'package:angel_broking_demo/screens/personal_details_screen.dart';
import 'package:angel_broking_demo/screens/sample_Location.dart';
import 'package:angel_broking_demo/screens/screen_three.dart';
import 'package:angel_broking_demo/screens/screen_two.dart';
import 'package:angel_broking_demo/screens/signature_pad_screen.dart';
import 'package:angel_broking_demo/screens/splash_screen.dart';
import 'package:angel_broking_demo/screens/email_validation_screen.dart';
import 'package:angel_broking_demo/screens/mobile_validation_screen.dart';
import 'package:angel_broking_demo/screens/pan_and_bank_validation_screen.dart';
import 'package:flutter/material.dart';

void main() {
  ///To Override SSL Certificate when used with HTTPS Apis
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host,
          int port) => true;
  }
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tech X Prototype',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          focusColor: Color(0xff6A4EEE),
          focusedBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Color(0xff6A4EEE), width: 2.0),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(),
              borderRadius: BorderRadius.circular(8.0)
          ),
          contentPadding: EdgeInsets.all(26.0),
          labelStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
        ),
        //This is the theme of your application.
        //
        //Try running your application with "flutter run". You'll see the
        //application has a blue toolbar. Then, without quitting the app, try
        //changing the primarySwatch below to Colors.green and then invoke
        //"hot reload" (press "r" in the console where you ran "flutter run",
        //or simply save your changes to "hot reload" in a Flutter IDE).
        //Notice that the counter didn't reset back to zero; the application
        //is not restarted.

        //#6A4EEE

        primaryColor: Color(0xff6A4EEE),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ScreenOne(),
        '/screenone':(context)=>ScreenOne(),
        '/screentwo':(context)=>ScreenTwo(),
        '/screenthree':(context)=>ScreenThree(),
        '/mobilevalidation':(context)=>MobileValidation(),
        '/emailvalidation':(context)=>EmailValidation(),
        '/panandbankvalidation':(context)=>PanAndBankValidation(),
        '/ocrvalidation':(context)=>OcrValidationScreen(title: 'Tech X Lab'),
        '/personaldetails':(context)=>PersonalDetailsScreen(),
        '/signaturepad':(context)=>SignaturePadScreen(),
        '/demoscreen':(context)=>DemoScreen(),
      },
    );
  }
}