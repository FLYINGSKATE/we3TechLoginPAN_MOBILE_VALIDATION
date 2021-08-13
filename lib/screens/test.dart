import 'package:angel_broking_demo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Task {
  String name;
  DateTime date;

  Task({required this.name, required this.date});
}

class PanValidation extends StatefulWidget {
  @override
  _PanValidationState createState() => _PanValidationState();
}

class _PanValidationState extends State<PanValidation> {
  String name="";
  late Task task ;
  TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  var headers = {
    'Authorization': 'Basic QUlZM0gxWFM1QVBUMkVNRkU1NFVXWjU2SVE4RlBLRlA6R083NUZXMllBWjZLUU0zRjFaU0dRVlVRQ1pQWEQ2T0Y=',
    'Content-Type': 'application/json'
  };

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2019, 8),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        _dateController.text = date;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('PAN DETAILS'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.translate),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0,10.0,0,0),
                          child: Text("Enter Full Name",style: TextStyle(fontWeight: FontWeight.bold),),
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
                          child: Text("D.O.B",style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        GestureDetector(
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0,10.0,0,0),
                          child: Text("PAN Number",style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        Flexible(
                          child: TextField(
                            onChanged: (value) {
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'e.g HCAPKLLL',
                            ),
                          ),
                        ),
                        Container(
                          child: RaisedButton(
                            onPressed: () async {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: new Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          new CircularProgressIndicator(),
                                          new Text("Loading"),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                              bool isPanValidated = await fetchIsPanValid();
                              print(isPanValidated);
                              if(isPanValidated){
                                ///PAN GOT VALIDATED
                                Navigator.pop(context);
                                ///Enter Your Bank Details Here.
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(0.0,10.0,0,0),
                                              child: Text("BANK A/C NUMBER",style: TextStyle(fontWeight: FontWeight.bold),),
                                            ),
                                          ),
                                          Flexible(
                                            child: TextField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: 'Enter BANK A/C NUMBER',
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(0.0,10.0,0,0),
                                            child: Text("IFSC CODE",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),
                                          Row(
                                            children: [
                                              Flexible(
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    hintText: 'IFSC CODE',
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.all(25),
                                                child: FlatButton(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text('SEARCH', style: TextStyle(fontSize: 20.0),),
                                                  ),
                                                  color: Colors.yellow,
                                                  textColor: Colors.black,
                                                  onPressed: () {},
                                                ),
                                              ),
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.security,color: Colors.blue,),
                                                    Text("Your Financial Information is Secure With In Us",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                                                  ],
                                                ),
                                                WidgetHelper().GradientButton(context,(){}),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                      );
                                  },
                                );
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
                              child: Text(
                                "Next",
                                textAlign: TextAlign.center,
                              ),
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
            ),
          );
  }

  Future<bool> fetchIsPanValid() async {
    var request = http.Request('POST', Uri.parse('http://localhost:44300/api/Notify/PanAPITest'));

    request.body = json.encode({
      "pan_no": "HCAPK4259Q",
      "full_name": "KHAN ASHRAF SALIM",
      "date_of_birth": "31-03-2000"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());
      String result = await response.stream.bytesToString();
      Map valueMap = jsonDecode(result);
      //print(await response.stream.bytesToString());
      if(valueMap["is_pan_dob_valid"] && valueMap["name_matched"]){
        print("YOUR PAN CARD IS VALID");
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
