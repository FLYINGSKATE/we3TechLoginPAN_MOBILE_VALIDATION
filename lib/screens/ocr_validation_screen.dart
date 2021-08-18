// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';

class OcrValidationScreen extends StatefulWidget {
  OcrValidationScreen({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _OcrValidationScreenState createState() => _OcrValidationScreenState();
}

class _OcrValidationScreenState extends State<OcrValidationScreen> {
  List<XFile>? _imageFileList;

  var headers = {
    'Authorization': 'Basic QUlZM0gxWFM1QVBUMkVNRkU1NFVXWjU2SVE4RlBLRlA6R083NUZXMllBWjZLUU0zRjFaU0dRVlVRQ1pQWEQ2T0Y='
  };

  late Image img;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  dynamic _pickImageError;
  bool isVideo = false;


  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  void _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    await _displayPickImageDialog(context!,
            (double? maxWidth, double? maxHeight, int? quality) async {
          try {
            final pickedFile = await _picker.pickImage(
              source: source,
              maxWidth: maxWidth,
              maxHeight: maxHeight,
              imageQuality: quality,
            );
            setState(() {
              _imageFile = pickedFile;
            });
          } catch (e) {
            setState(() {
              _pickImageError = e;
            });
          }
        });
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    maxWidthController.dispose();
    maxHeightController.dispose();
    qualityController.dispose();
    super.dispose();
  }


  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList != null) {
      ///
      print(_imageFileList![0]);

      if (kIsWeb) {
        img = Image.network(_imageFileList![0].path);

      } else {
        img = Image.file(File(_imageFileList![0].path));
      }
      File realIamge = File(_imageFileList![0].path);
      Upload(realIamge);
      //Upload(File(_imageFileList![0].path));

      //postPanCardOCRImage(_imageFileList![0].path.toString());
      print(_imageFileList![0].path.toString());
      //Image.file(File(selectedImage!.path))
      return Semantics(
          child: ListView.builder(
            key: UniqueKey(),
            itemBuilder: (context, index) {
              // Why network for web?
              // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform
              return Semantics(
                label: 'image_picker_example_picked_image',
                child: kIsWeb
                    ? Image.network(_imageFileList![index].path)
                    : Image.file(File(_imageFileList![index].path)),
              );
            },
            itemCount: _imageFileList!.length,
          ),
          label: 'image_picker_example_picked_images');
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      _retrieveDataError = response.exception!.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
            ? FutureBuilder<void>(
          future: retrieveLostData(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Text(
                  'You have not yet picked an image.',
                  textAlign: TextAlign.center,
                );
              case ConnectionState.done:
                return _handlePreview();
              default:
                if (snapshot.hasError) {
                  return Text(
                    'Pick image/video error: ${snapshot.error}}',
                    textAlign: TextAlign.center,
                  );
                } else {
                  return const Text(
                    'You have not yet picked an image.',
                    textAlign: TextAlign.center,
                  );
                }
            }
          },
        )
            : _handlePreview(),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Semantics(
            label: 'image_picker_example_from_gallery',
            child: FloatingActionButton(
              onPressed: () {
                isVideo = false;
                _onImageButtonPressed(ImageSource.gallery, context: context);
              },
              heroTag: 'image0',
              tooltip: 'Pick Image from gallery',
              child: const Icon(Icons.photo),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              onPressed: () {
                isVideo = false;
                _onImageButtonPressed(ImageSource.camera, context: context);
              },
              heroTag: 'image2',
              tooltip: 'Take a Photo',
              child: const Icon(Icons.camera_alt),
            ),
          ),
        ],
      ),
    );
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Future<void> _displayPickImageDialog(BuildContext context,
      OnPickImageCallback onPick) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add optional parameters'),
            content: Column(
              children: <Widget>[
                TextField(
                  controller: maxWidthController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration:
                  InputDecoration(hintText: "Enter maxWidth if desired"),
                ),
                TextField(
                  controller: maxHeightController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration:
                  InputDecoration(hintText: "Enter maxHeight if desired"),
                ),
                TextField(
                  controller: qualityController,
                  keyboardType: TextInputType.number,
                  decoration:
                  InputDecoration(hintText: "Enter quality if desired"),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: const Text('PICK'),
                  onPressed: () {
                    double? width = maxWidthController.text.isNotEmpty
                        ? double.parse(maxWidthController.text)
                        : null;
                    double? height = maxHeightController.text.isNotEmpty
                        ? double.parse(maxHeightController.text)
                        : null;
                    int? quality = qualityController.text.isNotEmpty
                        ? int.parse(qualityController.text)
                        : null;
                    onPick(width, height, quality);
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  Widget _handlePreview() {
    return _previewImages();
  }


  /*Future<void> uploadImage(String imageFilePath) async {

    Uint8List imageBytes = File(imageFilePath).readAsBytesSync();
    PickedFile imageFile = PickedFile(imageFilePath);

    var stream = new http.ByteStream(
        DelegatingStream.typed(imageFile.openRead()));
    int length = imageBytes.length;
    var request = new http.MultipartRequest(
        "POST", Uri.parse('http://localhost:44300/api/user/login/OCR'));
    var multipartFile = new http.MultipartFile('front_part', stream, length,
        filename: basename(imageFile.path),
        contentType: MediaType('image', 'jpeg'));

    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }*/


  Future<void> fetchIsOCRVALIDATED(Image imageFile) async {
    var request = http.Request('POST', Uri.parse('http://localhost:44300/api/user/login/OCR'));

    request.body = json.encode({
      "front_part": imageFile,
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
      print("Your PAN CARD IS VALIDATED "+valueMap["name"]);
    }
    else {
      print(response.reasonPhrase);
    }
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

  Future<void> uploadImage(String filepath,String fileName) async {
    MultipartFile mFile = await MultipartFile.fromFile(
      filepath, filename: fileName,
      contentType: MediaType("front_part", fileName.split(".").last),);

    var request = http.MultipartRequest('POST', Uri.parse('http://localhost:44300/api/user/login/OCR'));
    request.files.add(http.MultipartFile('front_part',
        File(filepath).readAsBytes().asStream(), File(filepath).lengthSync(),
        filename: filepath.split("/").last));
    var res = await request.send();
    print(res);
  }


  Future<void> postPanCardOCRImage(String panImageFilePath) async {
    //curl -X POST "http://localhost:44333/v1/api/user/login/OCR"
    // -H "accept: */*" -H "Content-Type: multipart/form-data" -F
    // "front_part=@WhatsApp Image 2021-08-15 at 11.50.49 PM.jpeg;type=image/jpeg"
    if (kIsWeb) {
      img = Image.network(_imageFileList![0].path);
    } else {
      img = Image.file(File(_imageFileList![0].path));
    }
    var request = http.MultipartRequest('POST', Uri.parse('http://localhost:44300/api/user/login/OCR'));
    request.files.add(await http.MultipartFile.fromPath('front_part',img.toString() ));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }
}

typedef void OnPickImageCallback(
    double? maxWidth, double? maxHeight, int? quality);


