import 'package:angel_broking_demo/screens/web_view.dart';
import 'package:angel_broking_demo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailValidation extends StatefulWidget {
  const EmailValidation({Key? key}) : super(key: key);

  @override
  _EmailValidationState createState() => _EmailValidationState();
}

class _EmailValidationState extends State<EmailValidation> {

  late String OTPFromApi;

  List<Color> myGradientColor = <Color>[
    Color.fromARGB(255, 127, 0, 255),
    Color.fromARGB(255, 225, 0, 255)
  ];

  var headers = {
    'Authorization': 'Basic QUlZM0gxWFM1QVBUMkVNRkU1NFVXWjU2SVE4RlBLRlA6R083NUZXMllBWjZLUU0zRjFaU0dRVlVRQ1pQWEQ2T0Y=',
    'Content-Type': 'application/json'
  };

  bool isValidOTP = false;

  @override
  Widget build(BuildContext context) {
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
                    child: Text("Enter Your Email",style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'ABC@XYZ.COM',
                        ),
                        onChanged: (value) {
                            String pattern =
                                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                r"{0,253}[a-zA-Z0-9])?)*$";
                            RegExp regex = new RegExp(pattern);
                            if (!regex.hasMatch(value) || value == null){
                              print('Enter a valid email address');
                              fetchEmailOTP(value.trim());
                            }
                            else {
                              print("Noice Email");
                            }
                          },
                      )
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
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        WidgetHelper().GradientButton(context,()=>Navigator.pushNamed(context, '/panvalidation')),
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

  Future<void> fetchEmailOTP(String emailID) async {
    var request = http.Request('POST', Uri.parse('http://localhost:44300/api/Notify/smsAPI'));
    request.body = json.encode({
      "smsContact": emailID
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