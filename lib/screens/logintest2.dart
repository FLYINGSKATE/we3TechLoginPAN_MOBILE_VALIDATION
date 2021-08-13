import 'package:flutter/material.dart';


class LoginTest2 extends StatefulWidget {
  const LoginTest2({Key? key}) : super(key: key);

  @override
  _LoginTest2State createState() => _LoginTest2State();
}

class _LoginTest2State extends State<LoginTest2> {
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
        body:Center(child:Text("You are logged OUT",style: TextStyle(color: Colors.red),)));
  }
}
