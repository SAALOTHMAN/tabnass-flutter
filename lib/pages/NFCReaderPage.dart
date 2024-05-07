import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:ndef/ndef.dart';
import 'package:ndef/utilities.dart';
import 'package:tapnassfluteer/globelVariables.dart';
import 'package:tapnassfluteer/pages/HomePage.dart';
import 'package:tapnassfluteer/util/http_utilities.dart';
import 'package:tapnassfluteer/util/loading.dart';

class NFCReaderPage extends StatefulWidget {
  @override
  _NFCReaderPageState createState() => _NFCReaderPageState();
}

class _NFCReaderPageState extends State<NFCReaderPage> {
  String _nfcData = '';

  Future<void> startNFCScanStudent() async {
    FlutterSecureStorage Storage = new FlutterSecureStorage();
    bool IsStudent = (await Storage.read(key: "isStudent")) == "true";
    try {
      var tag = await FlutterNfcKit.poll(
          timeout: Duration(minutes: 12),
          iosAlertMessage:
              "Hold your iPhone near the item to learn more about it.");

      var ndefRecords = await FlutterNfcKit.readNDEFRecords();
      loadingDialog();

      NDEFRecord record = ndefRecords.first;

      String data_string =
          String.fromCharCodes(record.payload!.toList().sublist(3));

      Map<String, dynamic> data = json.decode(data_string);

      var response;
      if (IsStudent) {
        List lec_string = data["lectures"].map((e) => '"${e}"').toList();

        response = await http_functions.HttpLoginRequired(
            "/student/reader", {"NFC_info": '${lec_string}'}, false);
      } else {
        String room = data["room"];

        response = await http_functions.HttpLoginRequired(
            "/Educator/reader", {"NFC_info": room}, false);
      }

      Get.back();

      var response_json = response["response"];

      if (response["statusCode"] == 200) {
        Get.defaultDialog(
            title: "",
            content: Column(
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  color: prandColor,
                  size: 100,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    response_json["Message"],
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ],
            ));
      } else if (response["statusCode"] == 400) {
        Get.defaultDialog(
            title: "",
            content: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Icon(
                    Icons.error_rounded,
                    color: Colors.red,
                    size: 100,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Text(
                      response_json["Message"],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ],
              ),
            ));
      }

      startNFCScanStudent();
      return;
    } catch (e) {
      Get.back();
      print(e);
      Get.defaultDialog(
          title: "خطأ",
          content: Container(
            child: Text(
              "حدث خطأ ما , الرجاء المحاولة لاحقا",
              style: TextStyle(fontSize: 20),
            ),
          ));

      startNFCScanStudent();
      return;
    }
  }

  void _onTap() {
    // Add your onTap function here
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startNFCScanStudent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('مسح بطاقة NFC', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: GestureDetector(
              child: Text('رجوع',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              onTap: () {
                Get.to(HomePage());
              },
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Image.asset('assets/images/nfc1.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              _nfcData,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
