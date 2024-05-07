import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tapnassfluteer/globelVariables.dart';
import 'package:tapnassfluteer/pages/AttendancePage.dart';
import 'package:tapnassfluteer/pages/NFCReaderPage.dart';
import 'package:tapnassfluteer/pages/schedule.dart';
import 'package:tapnassfluteer/pages/signin_page1.dart';
import 'package:tapnassfluteer/util/http_utilities.dart';
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
  late bool isStudent;
  late String SelectedStatus;
  bool _loading = true;

  FlutterSecureStorage storage = new FlutterSecureStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetStudentData();
  }

  void GetStudentData() async {
    isStudent = (await storage.read(key: "isStudent")) == "true";

    first_name = await storage.read(key: "full_name") as String;
    ID = await storage.read(key: "ID") as String;

    if (!isStudent) {
      SelectedStatus = await storage.read(key: "status") as String;
      setState(() {
        SelectedStatus;
      });
    }
    setState(() {
      first_name;
      ID;
    });

    _loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _loading
          ? Center(
              child: SpinKitCubeGrid(
              color: prandColor,
            ))
          : pages[_selectedIndex],
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
        backgroundColor: prandColor, // Set the app bar color to dark blue
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _loading
                ? Center(
                    child: SpinKitCubeGrid(
                    color: prandColor,
                  ))
                : (!isStudent)
                    ? DropdownButton<String>(
                        dropdownColor: prandColor,
                        value: SelectedStatus,
                        items: ["متاح", "مشغول"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            SelectedStatus = newValue as String;
                          });

                          http_functions.HttpLoginRequired(
                              "/Educator/Change_Status",
                              {"Status": SelectedStatus},
                              false);
                        },
                        hint: Text(
                          "اختر التاريخ",
                          style: TextStyle(
                              color: prandColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    : Container(),
            SizedBox(
              width: 13,
            ),
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
