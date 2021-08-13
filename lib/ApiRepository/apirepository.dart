import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
class ApiRepo {

  var headers = {
    'Authorization': 'Basic QUlZM0gxWFM1QVBUMkVNRkU1NFVXWjU2SVE4RlBLRlA6R083NUZXMllBWjZLUU0zRjFaU0dRVlVRQ1pQWEQ2T0Y=',
    'Content-Type': 'application/json'
  };

  Future<String> fetchOTP(String phoneNumber) async {
    var request = http.Request('POST', Uri.parse('http://localhost:44300/api/Notify/smsAPI'));
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
}