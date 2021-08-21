import 'package:angel_broking_demo/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({Key? key}) : super(key: key);

  @override
  _DemoScreenState createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {

  List<Color> myGradientColor = <Color>[
    Color.fromARGB(255, 127, 0, 255),
    Color.fromARGB(255, 225, 0, 255)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: myGradientColor,
                )
            )),
        centerTitle: true,
        title: Text('Tech X'),
      ),
      body: Center(child: Column(
        children: [
          SizedBox(height: 20.0,),
          Text('API & MOBILE UI DEMO',textAlign: TextAlign.center,style: (TextStyle(fontSize: 40)),),
          SizedBox(height: 20.0,),
          WidgetHelper().GradientButton(context, (){Navigator.pushNamed(context, '/mobilevalidation');},'MOBILE AUTHENTICATION'),
          SizedBox(height: 20.0,),
          WidgetHelper().GradientButton(context, (){Navigator.pushNamed(context, '/emailvalidation');},'EMAIL AUTHENTICATION'),
          SizedBox(height: 20.0,),
          WidgetHelper().GradientButton(context, (){Navigator.pushNamed(context, '/panandbankvalidation');},'PAN & BANK AUTHENTICATION'),
          SizedBox(height: 20.0,),
          WidgetHelper().GradientButton(context, (){Navigator.pushNamed(context, '/ocrvalidation');},'OCR DOCUMENTS AUTHENTICATION'),
          SizedBox(height: 20.0,),
          WidgetHelper().GradientButton(context, (){Navigator.pushNamed(context, '/personaldetails');},'PERSONAL DETAILS PAGE'),
          SizedBox(height: 20.0,),
          WidgetHelper().GradientButton(context, (){Navigator.pushNamed(context, '/signaturepad');},'SIGNATURE PAD DEMO'),
        ],
      )),
    );
  }
}
