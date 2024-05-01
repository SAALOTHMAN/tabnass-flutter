import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:get/get.dart';
import 'package:tapnassfluteer/pages/HomePage.dart';

class NFCReaderPage extends StatefulWidget {
  @override
  _NFCReaderPageState createState() => _NFCReaderPageState();
}

class _NFCReaderPageState extends State<NFCReaderPage> {
  String _nfcData = '';

  Future<void> startNFCScan() async {
    try {
      var tag = await FlutterNfcKit.poll(
          timeout: Duration(seconds: 10),
          iosAlertMessage:
              "Hold your iPhone near the item to learn more about it.");
      var ndefRecords = await FlutterNfcKit.readNDEFRecords();
      setState(() {
        _nfcData = ndefRecords.map((record) => record.payload).join(', ');
      });
      // Here you can send _nfcData to your backend
    } catch (e) {
      setState(() {
        _nfcData = "Failed to read NFC tag: $e";
      });
    }
  }

  void _onTap() {
    // Add your onTap function here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
        title: Text('مسح بطاقة NFC', style: TextStyle(color: Colors.white)),
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
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                // Background color
                ),
            onPressed: startNFCScan,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 35.0, vertical: 20.0),
              child: Text('دوس للتأكيد', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}
