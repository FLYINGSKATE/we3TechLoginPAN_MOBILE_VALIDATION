import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Task {
  String name;
  DateTime date;

  Task({required this.name, required this.date});
}

class SignUpPage_Two extends StatefulWidget {
  @override
  _SignUpPage_TwoState createState() => _SignUpPage_TwoState();
}

class _SignUpPage_TwoState extends State<SignUpPage_Two> {
  String name = "Ashraf Khan";
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

  List<Color> myGradientColor = <Color>[
    Color(0x7f00ff),
    Color(0xe100ff)];

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
          title: Text('BANK DETAILS'),
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
                  Text("Welcome $name , Let's Get Started",textAlign: TextAlign.center,style: TextStyle(color: Colors.blue,fontSize:24.0,fontWeight: FontWeight.w400),),
                  Text("Please Enter Your Personal Details"),
                  SizedBox(height: 20,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                
                                if (value.length == 10) {
                                  print(value);
                                  fetchIsPanValid();
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'e.g HCAPKLLL',
                              ),
                            ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0,10.0,0,0),
                          child: Text("Email Id",style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        Flexible(
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'ABCD@XYZ.COM',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0,10.0,0,0),
                          child: Text("BANK A/C NUMBER",style: TextStyle(fontWeight: FontWeight.bold),),
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
                              Container(
                                margin: EdgeInsets.all(25),
                                child: FlatButton(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('PROCEED', style: TextStyle(fontSize: 20.0),),
                                  ),
                                  color: Colors.yellow,
                                  textColor: Colors.black,
                                  onPressed: () {},
                                ),
                              ),

                            ],
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

  Future<void> fetchIsPanValid() async {
    var request = http.Request('POST', Uri.parse('http://localhost:44300/api/Notify/PanAPITest'));
    request.body = json.encode({
      "pan_no": "HCAPK4259Q",
      "full_name": "KHAN ASHRAF SALIM",
      "date_of_birth": "31-03-2000"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      String result = await response.stream.bytesToString();
      Map valueMap = jsonDecode(result);
      //print(await response.stream.bytesToString());
      if(valueMap["is_pan_dob_valid"] && valueMap["name_matched"]){
        print("Something went wrong");
      }
      else{
        print("Something went wrong");
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }
}
