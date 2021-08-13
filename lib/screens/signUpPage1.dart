import 'dart:convert';
import 'dart:io';

import 'package:angel_broking_demo/screens/web_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:http/http.dart' as http;

class SignUpPage_One extends StatefulWidget {
  @override
  _SignUpPage_OneState createState() => _SignUpPage_OneState();
}

class _SignUpPage_OneState extends State<SignUpPage_One> {

  late String OTPFromApi;
  var headers = {
    'Authorization': 'Basic QUlZM0gxWFM1QVBUMkVNRkU1NFVXWjU2SVE4RlBLRlA6R083NUZXMllBWjZLUU0zRjFaU0dRVlVRQ1pQWEQ2T0Y=',
    'Content-Type': 'application/json'
  };

  bool isValidOTP = false;

  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {

    List<Color> myGradientColor = <Color>[
      Color(0x7f00ff),
      Color(0xe100ff)
    ];

    return Scaffold(resizeToAvoidBottomInset : true,
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
      body: SingleChildScrollView(

        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0,10.0,0,0),
                  child: Text("Full Name",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Your Full Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0,10.0,0,0),
                  child: Text("Mobile Number",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Flexible(
                  child: IntlPhoneField(
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                      print(phone.completeNumber.length);
                      if (phone.completeNumber.length >= 13) {
                        print(phone.completeNumber);
                        fetchOTP(phone.completeNumber);
                      }
                    },
                  )
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0,10.0,0,0),
                  child: Text("City",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Your City',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0,10.0,0,0),
                  child: Text("OTP",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Flexible(
                  child: TextField(
                    onChanged: (value){
                      if(value.length==4){
                        if(value==OTPFromApi){
                          print("Correct OTP");
                          isValidOTP = true;
                          setState(() {

                          });
                        }
                        else{
                          print("inncorrect OTP");
                        }
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      suffixIcon: isValidOTP ? Icon(Icons.check_circle,color: Colors.green,) : Icon(Icons.clear_outlined,color:Colors.red),
                      border: OutlineInputBorder(),
                      hintText: 'Enter OTP',
                    ),
                  ),
                ),
                Text("Regenerate OTP",style: TextStyle(fontWeight: FontWeight.bold),),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0,20.0,0,0),
                  child: Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'MMUMM',
                      ),
                    ),
                  ),
                ),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                      value: rememberMe,
                      onChanged: _onRememberMeChanged,
                  ),
                  Text("I agree to the Terms & Conditions"),
                ],
              ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(25),
                        child: FlatButton(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('OPEN AN ACCOUNT', style: TextStyle(fontSize: 20.0),),
                          ),
                          color:Colors.yellow,
                          textColor: Colors.black,
                          onPressed: () {
                            if(isValidOTP){
                              Navigator.pushNamed(context, '/signuppage2');
                            }
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BrowserView()),
                          );
                        },
                        child: Text("Continue To Your Existing Account",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }



  void _onRememberMeChanged(bool? newValue) {
    setState(() {
      rememberMe = newValue!;

      if (rememberMe) {
        // TODO: Here goes your functionality that remembers the user.
        print("Checked");
      } else {
        // TODO: Forget the user
        print("unchecked");
      }
    });
  }
  Future<void> fetchOTP(String phoneNumber) async {
    var request = http.Request('POST', Uri.parse('http://localhost:44300/api/Notify/smsAPI'));
    request.body = json.encode({
      "smsContact": phoneNumber
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String result = await response.stream.bytesToString();
      Map valueMap = jsonDecode(result);
      //print(await response.stream.bytesToString());
      print("Your OTP IS"+valueMap["jsonotpBKC"]);
      OTPFromApi = valueMap["jsonotpBKC"];
    }
    else {
      print(response.reasonPhrase);
    }
  }
}
