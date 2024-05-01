import 'package:flutter/material.dart';
import 'package:tapnassfluteer/pages/AttendancePage.dart';
import 'package:tapnassfluteer/widgets/SubjectWidget.dart';
import 'package:tapnassfluteer/widgets/bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void navigateToSignInPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AttendancePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: kToolbarHeight + 0,
          ), // Adjust the space beneath the app bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Schedule',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              navigateToSignInPage(context);
            },
            child: SubjectWidget(
              subject: 'hello',
              section: 'hello',
              time: '11:00',
              day: 'monday',
            ),
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue[900], // Set the app bar color to dark blue
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'الاسم',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                SizedBox(height: 5),
                Text(
                  'ID',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 92,
        child: bottom_bar(),
      ),
    );
  }
}
