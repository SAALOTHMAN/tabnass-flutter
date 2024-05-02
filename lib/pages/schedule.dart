import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tapnassfluteer/globelVariables.dart';
import 'package:tapnassfluteer/pages/AttendancePage.dart';
import 'package:tapnassfluteer/widgets/SubjectWidget.dart';

class shcedule extends StatefulWidget {
  const shcedule({super.key});

  @override
  State<shcedule> createState() => _shceduleState();
}

class _shceduleState extends State<shcedule> {
  void navigateToSignInPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AttendancePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: kToolbarHeight + 0,
        ), // Adjust the space beneath the app bar
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              ': الجدول الدراسي',
              style: TextStyle(
                color: prandColor,
                fontSize: 24,
              ),
            ),
          ),
        ),
        SizedBox(height: 40),
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
    );
  }
}
