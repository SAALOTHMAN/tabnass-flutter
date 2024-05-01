import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tapnassfluteer/pages/HomePage.dart';
import 'package:tapnassfluteer/pages/signin_page1.dart';
//import 'package:nfc_attendance/pages/NFCReaderPage.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: signin_page1(),
  ));
}
