import 'package:angel_broking_demo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalDetailsScreen extends StatefulWidget {
  @override
  _PersonalDetailsScreenState createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {

  String annualIncome = '1-5 Lac';
  String occupation = 'PRIVATE SECTOR';

  List<Color> myGradientColor = <Color>[
    Color.fromARGB(255, 127, 0, 255),
    Color.fromARGB(255, 225, 0, 255)
  ];

  TextEditingController _fullNameTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    autoPopulateTextFields();
    _fullNameTextEditingController.text = "";
    return Scaffold(
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
                children: [
                  Text("Please Enter Your Personal Details",textAlign: TextAlign.center,style: TextStyle(color: Colors.blue,fontSize:24.0,fontWeight: FontWeight.w400),),
                  SizedBox(height: 20,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0,10.0,0,0),
                          child: Text("Annual Income",style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        InputDecorator(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                          //isEmpty: _currentSelectedValue == '',
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: annualIncome,
                              style: const TextStyle(color: Colors.black),
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0,10.0,0,0),
                          child: Text("Occupation",style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        InputDecorator(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                          //isEmpty: _currentSelectedValue == '',
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: occupation,
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.black),
                              underline: Container(
                                height: 2,
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

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0,10.0,0,0),
                          child: Text("Father's First Name",style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        Flexible(
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0,10.0,0,0),
                          child: Text("Father's Last Name",style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        Flexible(
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0,10.0,0,0),
                          child: Text("Your Full Name Is",style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        Flexible(
                          child: TextField(
                            controller: _fullNameTextEditingController,
                            enabled: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.all(25),
                            child: WidgetHelper().GradientButton(context, (){}),
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

  Future<void> autoPopulateTextFields() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //int counter = (prefs.getInt('counter') ?? 0) + 1;
    //print('Pressed $counter times.');
    _fullNameTextEditingController.text = prefs.getString('full_name');
    print("Full Name Has Been Set To :"+prefs.getString('full_name'));
  }
}