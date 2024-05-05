import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:tapnassfluteer/pages/AttendancePage.dart';
import 'package:tapnassfluteer/pages/NFCReaderPage.dart';
import 'package:tapnassfluteer/pages/schedule.dart';
import 'package:tapnassfluteer/pages/signin_page1.dart';
import 'package:tapnassfluteer/widgets/SubjectWidget.dart';
import 'package:tapnassfluteer/widgets/bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String first_name = "";
  String ID = "";
  int _selectedIndex = 1;
  List<Widget> pages = [NFCReaderPage(), shcedule()];

  FlutterSecureStorage storage = new FlutterSecureStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetStudentData();
  }

  void GetStudentData() async {
    first_name = await storage.read(key: "full_name") as String;
    ID = await storage.read(key: "ID") as String;
    setState(() {
      first_name;
      ID;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.logout,
            color: Colors.white,
          ),
          onPressed: () {
            Get.defaultDialog(
                title: "تسجيل الخروج",
                middleText: "هل انت متأكد من تسجيل الخروج",
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      FlutterSecureStorage storage = new FlutterSecureStorage();
                      storage.deleteAll();
                      Get.offAll(signin_page1());
                    },
                    child: Text(
                      'نعم',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'لا',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ]);
          },
        ),
        backgroundColor: Colors.blue[900], // Set the app bar color to dark blue
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$first_name',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                SizedBox(height: 5),
                Text(
                  '$ID',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
          height: 92,
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.document_scanner_outlined),
                label: 'Scan',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined),
                label: 'Schedule',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          )),
    );
  }
}
