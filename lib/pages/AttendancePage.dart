import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tapnassfluteer/pages/HomePage.dart';
import 'package:tapnassfluteer/widgets/AttendanceWidget.dart';

class AttendancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900], // Set the app bar color to dark blue
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(HomePage());
              },
              child: Padding(
                padding: EdgeInsets.only(right: 16),
                child: Text(
                  'رجوع',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Attendance History',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 16),
            AttendanceWidget(
              dateTime: DateTime.now().subtract(Duration(days: 1)),
              attendanceStatus: 'Present',
            ),
            SizedBox(height: 16),
            AttendanceWidget(
              dateTime: DateTime.now().subtract(Duration(days: 2)),
              attendanceStatus: 'Absent',
            ),
          ],
        ),
      ),
    );
  }
}
