import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';

class SignUpPage_Five extends StatefulWidget {
  @override
  _SignUpPage_FiveState createState() => _SignUpPage_FiveState();
}

class _SignUpPage_FiveState extends State<SignUpPage_Five> {

  FilePickerResult? PanCard;
  FilePickerResult? ClientSignature;
  FilePickerResult? BankStatement;

  String PanCardFileName = "Name of the Uploaded Document here";
  String ESignatureFileName = "Name of the Uploaded Document here";
  String BankStatementFileName = "Name of the Uploaded Document here";

  late File panFile;

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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                  children: [
                    Text("Upload Required Documents to Complete Your Process",textAlign: TextAlign.center,style: TextStyle(fontSize:20.0,color: Colors.blue,fontWeight: FontWeight.bold),),
                    Text("Kindly Upload the Mandatory Documents"),
                    SizedBox(height:40),
                    UploadContainer("$PanCardFileName","PAN CARD *",Icon(Icons.supervised_user_circle_sharp)),
                    SizedBox(height:10),
                    UploadContainer("$ESignatureFileName","Client Signature *",Icon(Icons.sticky_note_2)),
                    SizedBox(height:10),
                    UploadContainer("$BankStatementFileName","Bank Statement",Icon(Icons.book)),
                    Container(
                      margin: EdgeInsets.all(25),
                      child: FlatButton(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('PROCEED', style: TextStyle(fontSize: 20.0),),
                        ),
                        color: Colors.yellow,
                        textColor: Colors.black,
                        onPressed: () {
                          print("Uploading Pan File");
                          Upload(panFile);
                        },
                      ),
                    ),
                  ]
              ),
            ),
          ),
        )
    );
  }

  Widget UploadContainer(String Filename,String Heading,Icon ico,) {
    return Container(
      padding:EdgeInsets.all(10.0) ,
      decoration: BoxDecoration(
        border: Border.all(
            width: 1.0,color: Colors.grey
        ),
        borderRadius: BorderRadius.all(
            Radius.circular(10.0) //                 <--- border radius here
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ico,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(Heading),
              Icon(Icons.info,color: Colors.blue,),
            ],
          ),
          SizedBox(height:10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child:Text("For Photo Id Proof")),
              Flexible(child: Text("($Filename)",style: TextStyle(color: Colors.blue))),
            ],
          ),
          SizedBox(height:10),
          FlatButton(
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: () async {
              switch(Heading){
                case "PAN CARD *":
                  print("Upload PanCard");
                  PanCard = await FilePicker.platform.pickFiles(type: FileType.custom,
                    allowedExtensions: ['jpeg']);
                  if(PanCard!.files.single.path != null) {
                    String? filePath = PanCard!.files.single.path;
                    print("Pan File has been set");
                    panFile = File(filePath!);
                    setState(() {
                      PanCardFileName = PanCard!.files.single.name;
                    });
                  } else {
                    // User canceled the picker
                    PanCardFileName = "Please Upload Pan Card";
                  }
                  break;
                case "Client Signature *":
                  print("Upload Client Signature ");
                  ClientSignature = await FilePicker.platform.pickFiles(type: FileType.custom,
                    allowedExtensions: ['jpg', 'pdf', 'doc'],);
                  if(ClientSignature!.files.single.path != null) {
                    String? filePath = ClientSignature!.files.single.path;
                    setState(() {
                      ESignatureFileName = ClientSignature!.files.single.name;
                      File file = File(filePath!);
                    });
                  } else {
                    // User canceled the picker
                    ESignatureFileName = "Please Upload Client Signature Card";
                  }
                  break;
                case "Bank Statement":
                  print("Upload Bank Statement");
                  BankStatement = await FilePicker.platform.pickFiles(type: FileType.custom,
                    allowedExtensions: ['jpg', 'pdf', 'doc'],);
                  if(BankStatement!.files.single.path != null) {
                    String? filePath = BankStatement!.files.single.path;
                    setState(() {
                      BankStatementFileName = BankStatement!.files.single.name;
                      File file = File(filePath!);
                    });
                  } else {
                    // User canceled the picker
                    BankStatementFileName = "Please Upload BankFile Statement Card";
                  }
                  break;
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.drive_folder_upload,color: Colors.white,),
                ),
                Text('Upload', )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Upload(File imageFile) async {

    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse('http://localhost:44300/api/user/login/OCR');

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('front_part', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }
}