import 'dart:async';
import 'package:angel_broking_demo/utils/authentication.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high,timeLimit: Duration(seconds: 6)).catchError((err) async {
      print(err);
      await Geolocator.getLastKnownPosition();
    });
  }


  _getCurrentLocation() async {
    Position _currentPosition = await _determinePosition();
    print("CURRENT POSITION :"+_currentPosition.latitude.toString());
    // this will get the coordinates from the lat-long using Geocoder Coordinates
    final coordinates = Coordinates(_currentPosition.latitude, _currentPosition.longitude);
    showToastNotification(_currentPosition.latitude.toString());
    // this fetches multiple address, but you need to get the first address by doing the following two codes
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print(first.countryName);
    showToastNotification("Current Location : "+first.countryName+"-"+first.locality+"|"+first.subLocality+","+first.postalCode);
    //Enable this if location is working
    _getBioMetricsAuthentication();
  }

  @override
  void initState(){
    super.initState();
    _askForPermissions();
    //Disable this if location is not working
    //_getBioMetricsAuthentication();
    _getCurrentLocation();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 127, 0, 255),
              Color.fromARGB(255, 225, 0, 255)
            ],
          )
        ),
        child:Center(child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FlutterLogo(size:70.0),
        ))
    );
  }

  showToastNotification(String currentLocation) {
    Fluttertoast.showToast(
        msg: currentLocation,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  void _getBioMetricsAuthentication() async {
    bool isAuthenticated = await Authentication.authenticateWithBiometrics();
    if (isAuthenticated) {
      Navigator.pushReplacementNamed(context, "/mobilevalidation");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        Authentication.customSnackBar(
          content: 'Error authenticating using Biometrics.',
        ),
      );
    }
  }

  Future<void> _askForPermissions() async {
    print("asking for permissions");
    if (await Permission.storage.request().isGranted) {
      print("Permitted to use Local Storage");
    }
    else{
      print("Don't Deny let us use local storage");
    }
    if (await Permission.location.request().isGranted) {
      print("Permitted to use Locations Storage");
    }
    else{
      print("Don't Deny Locations");
    }
    
    /*if (await Permission.location.isDenied) {
      showToastNotification("Please Give Location Access to the App");
      Geolocator.openLocationSettings();
    }*/

  }
}