import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tapnassfluteer/pages/AttendancePage.dart';
import 'package:tapnassfluteer/pages/NFCReaderPage.dart';
import 'package:tapnassfluteer/pages/schedule.dart';
import 'package:tapnassfluteer/widgets/SubjectWidget.dart';
import 'package:tapnassfluteer/widgets/bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String first_name = "";
  String student_id = "";
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
    first_name = await storage.read(key: "first_Name") as String;
    student_id = await storage.read(key: "Student_ID") as String;
    setState(() {
      first_name;
      student_id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      appBar: AppBar(
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
                  '$student_id',
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
