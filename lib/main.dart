import 'dart:io';

import 'package:angel_broking_demo/screens/nuniyo_aadhar_kyc_screen.dart';
import 'package:angel_broking_demo/screens/nuniyo_bank_email_pan_validation_screen.dart';
import 'package:angel_broking_demo/screens/nuniyo_congrats_screen.dart';
import 'package:angel_broking_demo/screens/nuniyo_esign_screen.dart';
import 'package:angel_broking_demo/screens/nuniyo_mobile_validation_screen.dart';
import 'package:angel_broking_demo/screens/nuniyo_options_screen.dart';
import 'package:angel_broking_demo/screens/nuniyo_personal_details_screen.dart';
import 'package:angel_broking_demo/screens/nuniyo_splash_screen.dart';
import 'package:angel_broking_demo/screens/nuniyo_upload_documents_and_signature.dart';
import 'package:angel_broking_demo/screens/razor_pay_demo.dart';
import 'package:angel_broking_demo/screens/demo_screen.dart';
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
        '/': (context) => SplashScreen(),
        '/mobilevalidationscreen':(context)=>MobileValidationLoginScreen(),
        '/bankemailpanvalidationscreen':(context)=>BankPanEmailValidationScreen(),
        '/uploaddocumentscreen':(context)=>UploadDocumentScreen(),
        '/personaldetailsscreen':(context)=>PersonalDetailsScreen(),
        '/optionsscreen':(context)=>OptionsScreen(),
        '/aadharkycscreen':(context)=>AadharKYCScreen(),
        '/rayzorpaydemoscreen':(context)=>RayzorPayDemoScreen(),
        '/esignscreen':(context)=>EsignScreen(),
        '/congratsscreen':(context)=>CongratsScreen(),
      },
    );
  }
}