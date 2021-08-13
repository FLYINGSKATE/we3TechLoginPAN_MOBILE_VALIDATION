import 'package:flutter/material.dart';

class WidgetHelper{
  Widget GradientButton(BuildContext context,var _onpressed) {
    return Container(
      child: RaisedButton(
        onPressed: _onpressed,
        textColor: Colors.white,
        padding: const EdgeInsets.all(0.0),
        child: Container(
          width: 300,
          decoration: BoxDecoration(
              gradient: new LinearGradient(
                colors: [
                  Color.fromARGB(255, 127, 0, 255),
                  Color.fromARGB(255, 225, 0, 255)
                ],
              )
          ),
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Next",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
