import 'package:angel_broking_demo/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenThree extends StatefulWidget {
  const ScreenThree({Key? key}) : super(key: key);

  @override
  _ScreenThreeState createState() => _ScreenThreeState();
}

class _ScreenThreeState extends State<ScreenThree> {

  Color primaryColorOfApp = Color(0xff6A4EEE);

  late FocusNode _fatherNameTextFieldFocusNode,_annualIncomeDropDownFocusNode,_motherNameTextFieldFocusNode,_occupationDropDownFocusNode,_maritialStatusIncomeDropDownFocusNode,_genderDropDownFocusNode,_tradingExperienceDropDownFocusNode,_politicallyExposedDropDownFocusNode;

  String annualIncome = '1-5 Lac';
  String gender = 'Male';
  String maritialStatus = 'Single';
  String tradingExperience = '0 Years';
  String politicallyExposed = 'Yes';
  String occupation = 'PRIVATE SECTOR';

  @override
  void initState() {
    super.initState();
    _fatherNameTextFieldFocusNode = FocusNode();
    _tradingExperienceDropDownFocusNode = FocusNode();
    _motherNameTextFieldFocusNode = FocusNode();
    _occupationDropDownFocusNode = FocusNode();
    _maritialStatusIncomeDropDownFocusNode = FocusNode();
    _annualIncomeDropDownFocusNode = FocusNode();
    _genderDropDownFocusNode = FocusNode();
    _politicallyExposedDropDownFocusNode = FocusNode();
  }

  void _requestFatherNameTextFieldFocusNode(){
    setState(() {
      FocusScope.of(context).requestFocus(_fatherNameTextFieldFocusNode);
    });
  }

  void _requestMotherNameTextFieldFocusNode(){
    setState(() {
      FocusScope.of(context).requestFocus(_motherNameTextFieldFocusNode);
    });
  }

  void _requestTradingExperienceDropDownFocusNode(){
    setState(() {
      FocusScope.of(context).requestFocus(_tradingExperienceDropDownFocusNode);
    });
  }

  void _requestPoliticallyExposedDropDownFocusNode(){
    setState(() {
      FocusScope.of(context).requestFocus(_politicallyExposedDropDownFocusNode);
    });
  }

  void _requestOccupationDropDownFocusNode(){
    setState(() {
      FocusScope.of(context).requestFocus(_occupationDropDownFocusNode);
    });
  }

  void _requestGenderDropDownFocusNode(){
    setState(() {
      FocusScope.of(context).requestFocus(_genderDropDownFocusNode);
    });
  }

  @override
  void dispose() {
    _fatherNameTextFieldFocusNode.dispose();
    _motherNameTextFieldFocusNode.dispose();
    _occupationDropDownFocusNode.dispose();
    _maritialStatusIncomeDropDownFocusNode.dispose();
    _annualIncomeDropDownFocusNode.dispose();
    _genderDropDownFocusNode.dispose();
    _tradingExperienceDropDownFocusNode.dispose();
    _politicallyExposedDropDownFocusNode.dispose();
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
                WidgetHelper().DetailsTitle('Personal Details'),
                //SizedBox(height: 20,),
                Flexible(
                    child: Container(
                      height: 80,
                      child: TextField(
                        cursorColor: primaryColorOfApp,
                        style: GoogleFonts.openSans(textStyle: TextStyle(color: Colors.black, letterSpacing: .5,fontSize: 14,fontWeight: FontWeight.bold)),
                        focusNode: _fatherNameTextFieldFocusNode,
                        onTap: _requestFatherNameTextFieldFocusNode,
                        decoration: InputDecoration(
                            counter: Offstage(),
                            labelText: _fatherNameTextFieldFocusNode.hasFocus ? 'Father\'s Full Name' : 'Father\'s Full Name',
                            labelStyle: TextStyle(
                              color: _fatherNameTextFieldFocusNode.hasFocus ?primaryColorOfApp : Colors.grey,
                            )
                        ),
                      ),
                    )
                ),
                SizedBox(height: 10,),
                Flexible(
                    child: Container(
                      height: 80,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        cursorColor: primaryColorOfApp,
                        style: GoogleFonts.openSans(textStyle: TextStyle(color: Colors.black, letterSpacing: 0.5,fontSize: 14,fontWeight: FontWeight.bold)),
                        focusNode: _motherNameTextFieldFocusNode,
                        onTap: _requestMotherNameTextFieldFocusNode,
                        decoration: InputDecoration(
                            counter: Offstage(),
                            labelText: _motherNameTextFieldFocusNode.hasFocus ? 'Mother\'s Full Name' : 'Mother\'s Full Name',
                            labelStyle: GoogleFonts.openSans(textStyle:TextStyle(fontSize: 14,letterSpacing: 0.5,
                              color: _motherNameTextFieldFocusNode.hasFocus ?primaryColorOfApp : Colors.grey,
                            ))
                        ),
                      ),
                    )
                ),
                SizedBox(height: 10,),
                Container(
                  height: 75.0,
                  child: InputDecorator(
                    decoration: InputDecoration(
                        labelText: _maritialStatusIncomeDropDownFocusNode.hasFocus ? 'Maritial Status' : 'Maritial Status',
                        labelStyle: GoogleFonts.openSans(textStyle:TextStyle(fontSize: 14,letterSpacing: 0.5,
                          color: _maritialStatusIncomeDropDownFocusNode.hasFocus ?primaryColorOfApp : Colors.grey,
                        )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    //isEmpty: _currentSelectedValue == '',
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        icon: Icon(Icons.keyboard_arrow_down_outlined),
                        value: maritialStatus,
                        
                        style: GoogleFonts.openSans(textStyle: TextStyle(color: Colors.grey, letterSpacing: .5,fontSize: 14,fontWeight: FontWeight.bold)),
                        underline: Container(
                          color: Colors.black,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            maritialStatus = newValue!;
                          });
                        },

                        items: <String>['Single','Married','Unmarried','Divorced']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 75.0,
                  child: InputDecorator(
                    decoration: InputDecoration(
                        labelText: _genderDropDownFocusNode.hasFocus ? 'Gender' : 'Gender',
                        labelStyle: GoogleFonts.openSans(textStyle:TextStyle(fontSize: 14,letterSpacing: 0.5,
                          color: _genderDropDownFocusNode.hasFocus ?primaryColorOfApp : Colors.grey,
                        )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    //isEmpty: _currentSelectedValue == '',
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        icon: Icon(Icons.keyboard_arrow_down_outlined),
                        value: gender,
                        style: GoogleFonts.openSans(textStyle: TextStyle(color: Colors.grey, letterSpacing: .5,fontSize: 14,fontWeight: FontWeight.bold)),
                        underline: Container(
                          color: Colors.black,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            gender = newValue!;
                          });
                        },
                        items: <String>['Male','Female','Gay','Bisexual','Assexual']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                WidgetHelper().DetailsTitle('Background'),
                Container(
                  height: 75.0,
                  child: InputDecorator(
                    decoration: InputDecoration(
                        labelText: _annualIncomeDropDownFocusNode.hasFocus ? 'Annual Income' : 'Annual Income',
                        labelStyle: GoogleFonts.openSans(textStyle:TextStyle(fontSize: 14,letterSpacing: 0.5,
                          color: _annualIncomeDropDownFocusNode.hasFocus ?primaryColorOfApp : Colors.grey,
                        )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    //isEmpty: _currentSelectedValue == '',
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        icon: Icon(Icons.keyboard_arrow_down_outlined),
                        value: annualIncome,
                        style: GoogleFonts.openSans(textStyle: TextStyle(color: Colors.grey, letterSpacing: .5,fontSize: 14,fontWeight: FontWeight.bold)),
                        underline: Container(
                          color: Colors.black,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            annualIncome = newValue!;
                          });
                        },

                        items: <String>['1-5 Lac','5-10 Lac','10-25 Lac','>25 Lac' ,'25 Lac-1 Cr','> 1 Cr']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 75.0,
                  child: InputDecorator(
                    decoration: InputDecoration(
                        labelText: _occupationDropDownFocusNode.hasFocus ? 'Occupation' : 'Occupation',
                        labelStyle: GoogleFonts.openSans(textStyle:TextStyle(fontSize: 14,letterSpacing: 0.5,
                          color: _occupationDropDownFocusNode.hasFocus ?primaryColorOfApp : Colors.grey,
                        )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    //isEmpty: _currentSelectedValue == '',
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        icon: Icon(Icons.keyboard_arrow_down_outlined),
                        value: occupation,
                        style: GoogleFonts.openSans(textStyle: TextStyle(color: Colors.grey, letterSpacing: .5,fontSize: 14,fontWeight: FontWeight.bold)),
                        underline: Container(
                          color: Colors.black,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            occupation = newValue!;
                          });
                        },

                        items: <String>['PRIVATE SECTOR','PUBLIC SECTOR','etc']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 75.0,
                  child: InputDecorator(
                    decoration: InputDecoration(
                        labelText: _tradingExperienceDropDownFocusNode.hasFocus ? 'Trading Experience' : 'Trading Experience',
                        labelStyle: GoogleFonts.openSans(textStyle:TextStyle(fontSize: 14,letterSpacing: 0.5,
                          color: _tradingExperienceDropDownFocusNode.hasFocus ?primaryColorOfApp : Colors.grey,
                        )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    //isEmpty: _currentSelectedValue == '',
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        icon: Icon(Icons.keyboard_arrow_down_outlined),
                        value: occupation,
                        style: GoogleFonts.openSans(textStyle: TextStyle(color: Colors.grey, letterSpacing: .5,fontSize: 14,fontWeight: FontWeight.bold)),
                        underline: Container(
                          color: Colors.black,
                        ),
                        onTap: _requestTradingExperienceDropDownFocusNode,
                        onChanged: (String? newValue) {
                          setState(() {
                            occupation = newValue!;
                          });
                        },

                        items: <String>['PRIVATE SECTOR','PUBLIC SECTOR','etc']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 75.0,
                  child: InputDecorator(
                    decoration: InputDecoration(

                        labelText: _politicallyExposedDropDownFocusNode.hasFocus ? 'Politically Exposed' : 'Politically Exposed',
                        labelStyle: GoogleFonts.openSans(textStyle:TextStyle(fontSize: 14,letterSpacing: 0.5,
                          color: _politicallyExposedDropDownFocusNode.hasFocus ?primaryColorOfApp : Colors.grey,
                        )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    //isEmpty: _currentSelectedValue == '',
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        icon: Icon(Icons.keyboard_arrow_down_outlined),
                        value: politicallyExposed,
                        style: GoogleFonts.openSans(textStyle: TextStyle(color: Colors.grey, letterSpacing: .5,fontSize: 14,fontWeight: FontWeight.bold)),
                        underline: Container(
                          color: Colors.black,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            occupation = newValue!;
                          });
                        },
                        items: <String>['Yes','No','Maybe']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width,
                  height: 75,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    onPressed: () {},
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