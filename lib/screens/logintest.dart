import 'package:flutter/material.dart';

class LoginTest extends StatefulWidget {
  const LoginTest({Key? key}) : super(key: key);

  @override
  _LoginTestState createState() => _LoginTestState();
}

class _LoginTestState extends State<LoginTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset : true,
    appBar: AppBar(
    centerTitle: true,
        title: Text('Angel Broking'),
    leading: IconButton(
    onPressed: () {},
    icon: Icon(Icons.home),
    ),
    actions: [
    IconButton(
    onPressed: () {},
    icon: Icon(Icons.call),
    ),
    IconButton(
    onPressed: () {},
    icon: Icon(Icons.more_vert),
    ),
    ],
    ),
    body:Center(child:Column(
      children: [
        FlatButton(onPressed: _onPressed, child: Text("Click ME Buddy")),
        Text("You are logged in"),
      ],
    )));
  }

  void _onPressed() {
    print("Nothing");
  }
}
