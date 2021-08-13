import 'package:angel_broking_demo/widgets/widgets.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:convert';
import 'package:http/http.dart' as http;


bool isPanValidatedSuccessfully = false;

class Task {
  String name;
  DateTime date;
  Task({required this.name, required this.date});
}


class PanAndBankValidation extends StatefulWidget {
  @override
  State createState() {
    return PanAndBankValidationState();
  }
}

class PanAndBankValidationState extends State<PanAndBankValidation> {

  ///User - Friendly Strings - only used for UI
  String panFormDescriptionText= "TAP to Enter Your PAN DETAILS";
  List<Color> myGradientColor = <Color>[
    Color.fromARGB(255, 127, 0, 255),
    Color.fromARGB(255, 225, 0, 255)
  ];
  double panSubmittedHeight = 100.0;
  double bankSubmittedHeight = 100.0;

  //Fetching User Data inside this Variables
  late Task task ;
  TextEditingController _fullNameTextEditingController = TextEditingController() ;
  TextEditingController _panNumberTextEditingController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(1920, 1),
        firstDate: DateTime(1920, 1),
        lastDate: DateTime(2002));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var date =
            "${picked.toLocal().day}-${picked.toLocal().month}-${picked.toLocal().year}";
        _dateController.text = date;
      });
  }


  //API Header
  var headers = {
    'Authorization': 'Basic QUlZM0gxWFM1QVBUMkVNRkU1NFVXWjU2SVE4RlBLRlA6R083NUZXMllBWjZLUU0zRjFaU0dRVlVRQ1pQWEQ2T0Y=',
    'Content-Type': 'application/json'
  };

  @override
  Widget build(BuildContext context) {
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
      body: ExpandableTheme(
        data: const ExpandableThemeData(
          iconColor: Colors.blue,
          useInkWell: true,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            ExpandableNotifier(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: panSubmittedHeight,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: myGradientColor)
                            ),
                          ),
                        ),
                        ScrollOnExpand(
                          scrollOnExpand: true,
                          scrollOnCollapse: false,
                          child: ExpandablePanel(
                            theme: const ExpandableThemeData(
                              headerAlignment: ExpandablePanelHeaderAlignment.center,
                              tapBodyToCollapse: true,
                            ),
                            header: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "PAN VALIDATION",
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),
                                )),
                            collapsed: Text(
                              panFormDescriptionText,
                              softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            expanded:PanForm(),
                            builder: (_, collapsed, expanded) {
                              return Padding(
                                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                child: Expandable(
                                  collapsed: collapsed,
                                  expanded: expanded,
                                  theme: const ExpandableThemeData(crossFadePoint: 0),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            Visibility(
                visible: isPanValidatedSuccessfully,
                child: ExpandableNotifier(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: bankSubmittedHeight,
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: myGradientColor
                                    )
                                ),
                              ),
                            ),
                            ScrollOnExpand(
                              scrollOnExpand: true,
                              scrollOnCollapse: false,
                              child: ExpandablePanel(
                                theme: const ExpandableThemeData(
                                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                                  tapBodyToCollapse: true,
                                ),
                                header: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "PAN VALIDATION",
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),
                                    )),
                                collapsed: Text(
                                  panFormDescriptionText,
                                  softWrap: true,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                expanded:BankForm(),
                                builder: (_, collapsed, expanded) {
                                  return Padding(
                                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                    child: Expandable(
                                      collapsed: collapsed,
                                      expanded: expanded,
                                      theme: const ExpandableThemeData(crossFadePoint: 0),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
            ),
          ],
        ),
      ),
    );
  }



  Widget PanForm(){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _fullNameTextEditingController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Your Full Name',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'DD/MM/YYYY',
                ),
                controller: _dateController,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _panNumberTextEditingController,
            onChanged: (panNumber) {
              if(panNumber.length==10 && _fullNameTextEditingController.text!="" && _dateController.text!=""){
                print("Full Name :"+_fullNameTextEditingController.text+"Date Time :"+_dateController.text+"Pan Number :"+_panNumberTextEditingController.text);
                fetchIsPanValid(_fullNameTextEditingController.text,_dateController.text,_panNumberTextEditingController.text);
              }
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'e.g HCAPKLLL',
            ),
          ),
        ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: RaisedButton(
        onPressed: (){setState(() {
          isPanValidatedSuccessfully = true;
          panFormDescriptionText = "PAN Verified Successfully!";
          panSubmittedHeight = 10.0;
        });},
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
          child: Text("TRIAL PURPOSE", textAlign: TextAlign.center,),
          ),
        ),
      ),
    ),
      ],
    );
  }


  Widget BankForm(){
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter BANK A/C NUMBER',
          ),
        ),
      ],
    );
  }

  Future<bool> fetchIsPanValid(String fullName,String dOB,String panNumber) async {

    var request = http.Request('POST', Uri.parse('http://localhost:44300/api/Notify/PanAPITest'));

    request.body = json.encode({
      "pan_no": panNumber,
      "full_name": fullName,
      "date_of_birth": dOB,
    });

    //request.body = json.encode({
    //  "pan_no": "HCAPK4259Q",
    //  "full_name": "KHAN ASHRAF SALIM",
    //  "date_of_birth": "31-03-2000"
    //});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());
      String result = await response.stream.bytesToString();
      Map valueMap = jsonDecode(result);
      //print(await response.stream.bytesToString());
      if(valueMap["is_pan_dob_valid"] && valueMap["name_matched"]){
        print("YOUR PAN CARD IS VALID");
        isPanValidatedSuccessfully = true;
        setState(() {

        });
        return true;
      }
      else{
        print("Something went wrong");
        return false;
      }

    }
    else {
      print(response.reasonPhrase);
      return false;
    }
  }
}

class Card1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                    ),
                    header: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "BANK VALIDATION",
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),
                        )),
                    collapsed: Text(
                      "TAP to Enter Bank Details",
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(
                                "Pan Form will go here",
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              )),
                        FlatButton(onPressed: (){
                          print("Validation");
                          isPanValidatedSuccessfully = true;
                        }, child: Text("ENABLE 2nd Accordian")),
                      ],
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          theme: const ExpandableThemeData(crossFadePoint: 0),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}