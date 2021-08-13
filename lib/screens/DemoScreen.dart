import 'package:flutter/material.dart';

class DemoScreen extends StatefulWidget {
  @override
  _DemoScreenState createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  List<int> text = [1,2,3,4,5];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          for ( var i in text )
          Container(
            margin: EdgeInsets.all(25),
            child: FlatButton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('SIGN UP PAGE '+i.toString(), style: TextStyle(fontSize: 20.0),),
              ),
              color: Colors.yellow,
              textColor: Colors.black,
              onPressed: () {
                Navigator.pushNamed(context, '/signuppage'+i.toString());
              },
            ),
          ),

        ],
      ),
    );
  }
}
