import 'package:angel_broking_demo/ApiRepository/apirepository.dart';
import 'package:angel_broking_demo/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ScreenTwo extends StatefulWidget {
  const ScreenTwo({Key? key}) : super(key: key);

  @override
  _ScreenTwoState createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {

  TextEditingController _ifscCodeTextEditingController = TextEditingController();
  TextEditingController _bankTextEditingController = TextEditingController();

  bool isPanValidatedSuccessfully = false;
  bool isBankValidatedSuccessfully = false;

  Color primaryColorOfApp = Color(0xff6A4EEE);

  late FocusNode _emailTextFieldFocusNode,_otpTextFieldFocusNode,_panTextFieldFocusNode,_bankTextFieldFocusNode,_ifscTextFieldFocusNode;

  @override
  void initState() {
    super.initState();
    _emailTextFieldFocusNode = FocusNode();
    _otpTextFieldFocusNode = FocusNode();
    _panTextFieldFocusNode = FocusNode();
    _bankTextFieldFocusNode = FocusNode();
    _ifscTextFieldFocusNode = FocusNode();
  }

  void _requestEmailIdTextFieldFocus(){
    setState(() {
      FocusScope.of(context).requestFocus(_emailTextFieldFocusNode);
    });
  }

  void _requestPanTextFieldFocus(){
    setState(() {
      FocusScope.of(context).requestFocus(_panTextFieldFocusNode);
    });
  }

  void _requestBankTextFieldFocus(){
    setState(() {
      FocusScope.of(context).requestFocus(_bankTextFieldFocusNode);
    });
  }

  void _requestIfscTextFieldFocus(){
    setState(() {
      FocusScope.of(context).requestFocus(_ifscTextFieldFocusNode);
    });
  }

  void _requestOtpTextFieldFocus(){
    setState(() {
      FocusScope.of(context).requestFocus(_otpTextFieldFocusNode);
    });
  }

  @override
  void dispose() {
    _emailTextFieldFocusNode.dispose();
    _otpTextFieldFocusNode.dispose();
    _bankTextFieldFocusNode.dispose();
    _ifscTextFieldFocusNode.dispose();
    _panTextFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: Icon(Icons.ac_unit,color: Colors.black,),
        title: Text('Nuniyo',style: GoogleFonts.openSans(textStyle: TextStyle(color: Colors.black, letterSpacing: .5,fontWeight: FontWeight.bold)),),
        backgroundColor: Color(0xffF0ECFF),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height:30.0),
                WidgetHelper().DetailsTitle('Let\'s get started'),
                //SizedBox(height: 20,),
                Flexible(
                    child: TextField(
                      cursorColor: primaryColorOfApp,
                      style :GoogleFonts.openSans(textStyle: TextStyle(color: Colors.black, letterSpacing: .5,fontSize: 14,fontWeight: FontWeight.bold)),
                      focusNode: _emailTextFieldFocusNode,
                      onTap: _requestEmailIdTextFieldFocus,
                      decoration: InputDecoration(
                        counter: Offstage(),
                        labelText: _emailTextFieldFocusNode.hasFocus ? 'Email ID' : 'Enter Email ID',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold,
                              color: _emailTextFieldFocusNode.hasFocus ?primaryColorOfApp : Colors.grey,
                          )
                      ),
                      onChanged: (_phoneNumber) async {
                        print(_phoneNumber.length);
                        //phoneNumberString = _phoneNumber;
                        if (_phoneNumber.length >= 10) {
                          print(_phoneNumber);
                          //isPhoneNumberValid = true;
                          //phoneNumberString = _phoneNumber;
                          //OTPFromApi = await ApiRepo().fetchOTP(_phoneNumber);
                          setState((){});
                        }
                        else{
                          //isPhoneNumberValid = false;
                        }
                      },
                    )
                ),
                SizedBox(height: 10,),
                Flexible(
                    child: TextField(
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      cursorColor: primaryColorOfApp,
                      style: GoogleFonts.openSans(textStyle: TextStyle(color: Colors.black, letterSpacing: 3,fontSize: 14,fontWeight: FontWeight.bold)),
                      focusNode: _otpTextFieldFocusNode,
                      onTap: _requestOtpTextFieldFocus,
                      decoration: InputDecoration(
                          counter: Offstage(),
                          labelText: _otpTextFieldFocusNode.hasFocus ? 'OTP' : 'Enter OTP',
                          labelStyle: GoogleFonts.openSans(textStyle:TextStyle(fontSize: 14,letterSpacing: 0.5,
                            color: _otpTextFieldFocusNode.hasFocus ?primaryColorOfApp : Colors.grey,
                          ))
                      ),
                    )
                ),
                Visibility(
                  visible: false,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {  },
                        child: Text(
                            "Resend OTP",style: GoogleFonts.openSans(
                          textStyle: TextStyle(decoration: TextDecoration.underline,fontSize: 18,fontWeight: FontWeight.bold,color: primaryColorOfApp, letterSpacing: .5),
                    ),),),
                  ),
                ),
                SizedBox(height: 10,),
                Flexible(
                    child: TextField(
                      maxLength: 10,
                      cursorColor: primaryColorOfApp,
                      style: GoogleFonts.openSans(textStyle: TextStyle(color: Colors.black, letterSpacing: .5,fontSize: 14,fontWeight: FontWeight.bold)),
                      focusNode: _panTextFieldFocusNode,
                      onTap: _requestPanTextFieldFocus,
                      decoration: InputDecoration(
                        counter: Offstage(),
                          labelText: _panTextFieldFocusNode.hasFocus ? 'Enter PAN Number' : 'Enter PAN Number',
                          labelStyle: TextStyle(
                            color: _panTextFieldFocusNode.hasFocus ?primaryColorOfApp : Colors.grey,
                          )
                      ),
                    )
                ),
                SizedBox(height: 10,),
                Flexible(
                    child: TextField(
                      controller: _bankTextEditingController,
                      keyboardType: TextInputType.number,
                      cursorColor: primaryColorOfApp,
                      style: GoogleFonts.openSans(textStyle: TextStyle(color: Colors.black, letterSpacing: .5,fontSize: 14,fontWeight: FontWeight.bold)),
                      focusNode: _bankTextFieldFocusNode,
                      onTap: _requestBankTextFieldFocus,
                      decoration: InputDecoration(
                          counter: Offstage(),
                          labelText: _bankTextFieldFocusNode.hasFocus ? 'Enter Bank A/C Number' : 'Enter Bank A/C Number',
                          labelStyle: TextStyle(
                            color: _bankTextFieldFocusNode.hasFocus ?primaryColorOfApp : Colors.grey,
                          )
                      ),
                    )
                ),
                SizedBox(height: 10,),
                Flexible(
                    child: TextField(
                      controller: _ifscCodeTextEditingController,
                      cursorColor: primaryColorOfApp,
                      style: GoogleFonts.openSans(textStyle: TextStyle(color: Colors.black, letterSpacing: .5,fontSize: 14,fontWeight: FontWeight.bold)),
                      focusNode: _ifscTextFieldFocusNode,
                      onTap: _requestIfscTextFieldFocus,
                      decoration: InputDecoration(
                          counter: Offstage(),
                          labelText: _ifscTextFieldFocusNode.hasFocus ? 'Enter IFSC Number' : 'Enter IFSC Number',
                          labelStyle: TextStyle(
                            color: _ifscTextFieldFocusNode.hasFocus ?primaryColorOfApp : Colors.grey,
                          )
                      ),
                    )
                ),
                SizedBox(height: 20,),
                Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    onPressed: () async {
                      isBankValidatedSuccessfully = await ApiRepo().fetchIsBankValid(_bankTextEditingController.text.trim(), _ifscCodeTextEditingController.text.trim());
                      if(isBankValidatedSuccessfully){
                        isBankValidatedSuccessfully = true;
                        setState(() {});
                      }
                    },
                    color: primaryColorOfApp,
                    child: Text(
                      "Proceed",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(color: Colors.white, letterSpacing: .5,fontSize: 16,fontWeight: FontWeight.bold),)
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
