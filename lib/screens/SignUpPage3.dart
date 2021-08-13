import 'package:flutter/material.dart';

class SignUpPage_Three extends StatefulWidget {
  @override
  _SignUpPage_ThreeState createState() => _SignUpPage_ThreeState();
}

class _SignUpPage_ThreeState extends State<SignUpPage_Three> {
  // value set to false
  bool _manually = false;
  bool _instant = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('BANK DETAILS'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.translate),
            ),
          ],
        ),
        body: Padding(
        padding: const EdgeInsets.all(20.0),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text("Please Help Us With Your Personal Details",),
                Text("Choose From The Options Below"),
                SizedBox(height:40),
                CheckboxListTile(
                  title: const Text('Instant A/C Opening with DigiLocker'),
                  subtitle: const Text('Ensure that your mobile number is linked with Aadhar.'),
                  secondary: const Icon(Icons.supervised_user_circle_sharp),
                  autofocus: false,
                  activeColor: Colors.green,
                  checkColor: Colors.white,
                  selected: _instant,
                  value: _instant,
                  onChanged: (value) {
                    setState(() {
                      _instant = value!;
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.all(25),
                                    child: Column(
                                      children: [
                                        FlatButton(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('SHARE YOUR KYC DETAILS', style: TextStyle(fontSize: 20.0),),
                                          ),
                                          color: Colors.yellow,
                                          textColor: Colors.black,
                                          onPressed: () {

                                          },
                                        ),
                                        SizedBox(height: 20,),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            });
                    });
                  },
                ),
                Text("NEED HELP WITH UPLOADING ?",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                SizedBox(height:20),
                CheckboxListTile(
                  title: const Text('Enter Details Manually'),
                  subtitle: const Text('(Keep Your PAN Card , Aadhar , Address Proof & Photo Ready to Upload).'),
                  secondary: const Icon(Icons.supervised_user_circle_sharp),
                  autofocus: false,
                  activeColor: Colors.green,
                  checkColor: Colors.white,
                  selected: _manually,
                  value: _manually,
                  onChanged: (value) {
                    setState(() {
                      _manually = value!;
                    });
                  },
                ),
              ]
            ),
          ),
        )
    );
  }
}
