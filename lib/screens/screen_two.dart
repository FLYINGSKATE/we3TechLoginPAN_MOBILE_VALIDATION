import 'package:angel_broking_demo/icons/my_custom_icons.dart';
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

  Color primaryColorOfApp = Color(0xff6A4EEE);

  late FocusNode _phoneNumberFocusNode,_otpFocusNode,_referralCodeNode;

  @override
  void initState() {
    super.initState();
    _phoneNumberFocusNode = FocusNode();
    _otpFocusNode = FocusNode();
    _referralCodeNode = FocusNode();
  }

  void _requestPhoneFocus(){
    setState(() {
      FocusScope.of(context).requestFocus(_phoneNumberFocusNode);
    });
  }

  void _requestOtpFocus(){
    setState(() {
      FocusScope.of(context).requestFocus(_otpFocusNode);
    });
  }

  void _requestReferralCodeFocus(){
    setState(() {
      FocusScope.of(context).requestFocus(_referralCodeNode);
    });
  }

  @override
  void dispose() {
    _phoneNumberFocusNode.dispose();
    _otpFocusNode.dispose();
    _referralCodeNode.dispose();
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
                WidgetHelper().DetailsTitle('Registration'),
                Row(
                  children: [
                    Text("Already have an account ? ",style: GoogleFonts.openSans(
                      textStyle: TextStyle(color: Colors.black, letterSpacing: .5,fontSize: 16,fontWeight: FontWeight.bold),
                    ),),
                    Text("Sign In",style: GoogleFonts.openSans(
                      textStyle: TextStyle(decoration: TextDecoration.underline,fontSize: 16,fontWeight: FontWeight.bold,color: primaryColorOfApp, letterSpacing: .5),
                    ),)
                  ],
                ),
                SizedBox(height: 20,),
                Flexible(
                    child: TextField(
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      cursorColor: primaryColorOfApp,
                      style :GoogleFonts.openSans(textStyle: TextStyle(color: Colors.black, letterSpacing: .5,fontSize: 14,fontWeight: FontWeight.bold)),
                      focusNode: _phoneNumberFocusNode,
                      onTap: _requestPhoneFocus,
                      decoration: InputDecoration(
                        counter: Offstage(),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0,0.0,20.0,0.0),
                          child: Icon(MyCustomIcons.customMobile,size: 26.0,color: _phoneNumberFocusNode.hasFocus ?primaryColorOfApp : Colors.grey,),
                        ),
                        labelText: _phoneNumberFocusNode.hasFocus ? 'Mobile Number' : 'Enter Mobile Number',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold,
                              color: _phoneNumberFocusNode.hasFocus ?primaryColorOfApp : Colors.grey,
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
                Flexible(
                    child: TextField(
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      obscuringCharacter: "*",
                      obscureText: true,
                      cursorColor: primaryColorOfApp,
                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                      focusNode: _otpFocusNode,
                      onTap: _requestOtpFocus,
                      decoration: InputDecoration(
                          counter: Offstage(),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(0.0,0.0,40.0,0.0),
                            child: Icon(MyCustomIcons.customPassword,size: 12.0,color: _otpFocusNode.hasFocus ?primaryColorOfApp : Colors.grey,),
                          ),
                          labelText: _otpFocusNode.hasFocus ? 'OTP' : 'Enter OTP',
                          labelStyle: TextStyle(
                            color: _otpFocusNode.hasFocus ?primaryColorOfApp : Colors.grey,
                          )
                      ),
                    )
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {  },
                      child: Text(
                          "Resend OTP",style: GoogleFonts.openSans(
                        textStyle: TextStyle(decoration: TextDecoration.underline,fontSize: 18,fontWeight: FontWeight.bold,color: primaryColorOfApp, letterSpacing: .5),
                  ),),),
                ),
                SizedBox(height: 10,),
                Flexible(
                    child: TextField(
                      maxLength: 10,
                      cursorColor: primaryColorOfApp,
                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                      focusNode: _referralCodeNode,
                      onTap: _requestReferralCodeFocus,
                      decoration: InputDecoration(
                        counter: Offstage(),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(0.0,0.0,20.0,0.0),
                            child: Icon(MyCustomIcons.customReferralCode,size: 26.0,color: _referralCodeNode.hasFocus ?primaryColorOfApp : Colors.grey,),
                          ),
                          labelText: _referralCodeNode.hasFocus ? 'Referral Code' : 'Referral Code (Optional)',
                          labelStyle: TextStyle(
                            color: _referralCodeNode.hasFocus ?primaryColorOfApp : Colors.grey,
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
                    onPressed: () {Navigator.pushNamed(context, '/screenthree');},
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
