import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiRepo {

  String BASE_API_URL = 'http://localhost:44300';

  var headers = {
    'Authorization': 'Basic QUlZM0gxWFM1QVBUMkVNRkU1NFVXWjU2SVE4RlBLRlA6R083NUZXMllBWjZLUU0zRjFaU0dRVlVRQ1pQWEQ2T0Y=',
    'Content-Type': 'application/json'
  };

  ///Mobile Validation API
  Future<String> fetchOTP(String phoneNumber) async {
    var request = http.Request('POST', Uri.parse(BASE_API_URL+'/api/Notify/smsAPI'));
    request.body = json.encode({
      "smsContact": phoneNumber
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String result = await response.stream.bytesToString();
      Map valueMap = jsonDecode(result);
      print(result);
      print("Your OTP IS"+valueMap["jsonotpBKC"]);
      return valueMap["jsonotpBKC"];
    }
    else {
      print(response.reasonPhrase);
      return "";
    }
  }

  //Email Validation API
  Future<void> fetchEmailOTP(String emailID) async {
    var request = http.Request('POST', Uri.parse(BASE_API_URL+'/api/Notify/EmailAPITest'));
    request.body = json.encode({
      "emailSend": emailID,
      "user_token": "koibhi"
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String result = await response.stream.bytesToString();
      Map valueMap = jsonDecode(result);
      print(result);
      print("Your OTP IS"+valueMap["jsonotpBKC"]);
    }
    else {
      print(response.reasonPhrase);
    }
  }

  ///Bank Validation API
  Future<bool> fetchIsBankValid(String bankAccountNumber,String ifscCode) async {
    var request = http.Request('POST', Uri.parse(BASE_API_URL+'/api/Notify/BankVerify'));

    request.body = json.encode({
      "beneficiary_account_no": bankAccountNumber,
      "beneficiary_ifsc": ifscCode
    });

    //request.body = json.encode({
    //"beneficiary_account_no": "39981374255",
    //"beneficiary_ifsc": "SBIN0003671"
    //});

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String result = await response.stream.bytesToString();
      Map valueMap = jsonDecode(result);
      print(result);
      if(valueMap["verified"]){
        print("YOUR BANK IS VALIDATED");
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

  ///PAN Validation API
  Future<bool> fetchIsPanValid(String fullName,String dOB,String panNumber) async {
    var request = http.Request('POST', Uri.parse(BASE_API_URL+'/api/Notify/PanAPITest'));
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
      String result = await response.stream.bytesToString();
      Map valueMap = jsonDecode(result);
      print(result);
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

  //OCR Validation API
}