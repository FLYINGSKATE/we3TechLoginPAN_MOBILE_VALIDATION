import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
class ApiRepo {

  var headers = {
    'Content-Type': 'application/json'
  };

  final String BASE_API_URL = 'https://10.0.2.2:5001';

  ///Mobile Validation API
  Future<String> fetchOTP(String phoneNumber) async {
    var request = http.Request('POST', Uri.parse(BASE_API_URL+'/api/MobileAuthentication/Send_OTP'));
    request.body = json.encode({
      "contact_No": phoneNumber,
      "otp":"",
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String result = await response.stream.bytesToString();
      //Map valueMap = jsonDecode(result);
      print(result);
      //print("Your OTP IS"+valueMap["jsonotpBKC"]);
      return result;
    }
    else {
      print(response.reasonPhrase);
      return "";
    }
  }

  //Email Validation API
  Future<void> fetchEmailOTP(String emailID) async {

    var request = http.Request('POST', Uri.parse('$BASE_API_URL/api/EmailAuthentication/EmailAuthentication'));
    request.body = json.encode({
      "send_Email": emailID,
      "user_Token": "sssss"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  ///Bank Validation API
  Future<bool> fetchIsBankValid(String bankAccountNumber,String ifscCode) async {

    var request = http.Request('POST', Uri.parse(
        '$BASE_API_URL/VerifyBankAccount?beneficiary_account_no=$bankAccountNumber&beneficiary_ifsc=$ifscCode'));

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
    fullName = fullName.replaceAll(' ', '%20');
    var request = http.Request('POST', Uri.parse(
        '$BASE_API_URL/PanAuthentication?'
            'pan_no=$panNumber&full_name=$fullName&date_of_birth=$dOB'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String result = await response.stream.bytesToString();
      Map valueMap = jsonDecode(result);
      print(result);
      if (valueMap["is_pan_dob_valid"] && valueMap["name_matched"]) {
        print("YOUR PAN CARD IS VALID");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        fullName = fullName.replaceAll('%20',' ');
        await prefs.setString('full_name', fullName);
        print("Full Name Has Been Set To :" + prefs.getString('full_name'));
        return true;
      }
      else {
        print("Something went wrong");
        return false;
      }
    }
    else {
      print(response.reasonPhrase);
      return false;
    }
  }

    //request.body = json.encode({
    //  "pan_no": "HCAPK4259Q",
    //  "full_name": "KHAN ASHRAF SALIM",
    //  "date_of_birth": "31-03-2000"
    //});
    ///BANK AND PAN : 39981374255
///IFSC :SBIN0003671
}