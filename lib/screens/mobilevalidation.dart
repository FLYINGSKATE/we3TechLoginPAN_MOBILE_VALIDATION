import 'package:angel_broking_demo/ApiRepository/apirepository.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';


class MobileValidation extends StatefulWidget {
  const MobileValidation({Key? key}) : super(key: key);

  @override
  _MobileValidationState createState() => _MobileValidationState();
}

class _MobileValidationState extends State<MobileValidation> {

  late String OTPFromApi;

  List<Color> myGradientColor = <Color>[
    Color.fromARGB(255, 127, 0, 255),
    Color.fromARGB(255, 225, 0, 255)
  ];

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
                        onChanged: (phone) async {
                          print(phone.completeNumber.length);
                          if (phone.completeNumber.length >= 13) {
                            print(phone.completeNumber);
                            OTPFromApi = await ApiRepo().fetchOTP(phone.completeNumber);
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
                            setState(() {});
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
                    Container(
                      child: RaisedButton(
                        onPressed: () {
                          if(isValidOTP){
                            Navigator.pushNamed(context, '/emailvalidation');
                          }
                        },
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
                          child: Text("Next", textAlign: TextAlign.center,),
                        ),
                      ),
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
}
