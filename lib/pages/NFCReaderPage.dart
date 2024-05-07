import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:ndef/ndef.dart';
import 'package:ndef/utilities.dart';
import 'package:tapnassfluteer/globelVariables.dart';
import 'package:tapnassfluteer/pages/HomePage.dart';
import 'package:tapnassfluteer/util/loading.dart';

class NFCReaderPage extends StatefulWidget {
  @override
  _NFCReaderPageState createState() => _NFCReaderPageState();
}

class _NFCReaderPageState extends State<NFCReaderPage> {
  String _nfcData = '';

  Future<void> startNFCScan() async {
    try {
      var tag = await FlutterNfcKit.poll(
          timeout: Duration(minutes: 12),
          iosAlertMessage:
              "Hold your iPhone near the item to learn more about it.");

      var ndefRecords = await FlutterNfcKit.readNDEFRecords();

      loadingDialog();

      NDEFRecord record = ndefRecords.first;

      Map<String, dynamic> data = json
          .decode(String.fromCharCodes(record.payload!.toList().sublist(3)));
      print(data);

      // Here you can send _nfcData to your backend
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

      startNFCScan();
    }
  }

  void _onTap() {
    // Add your onTap function here
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startNFCScan();
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
