import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tapnassfluteer/pages/AttendancePage.dart';

class SubjectWidget extends StatelessWidget {
  final String subject;
  final String section;
  final String time;
  final String day;

  const SubjectWidget({
    Key? key,
    required this.subject,
    required this.section,
    required this.time,
    required this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(AttendancePage());
      },
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xffF4F4F4),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$subject : المادة'),
                      Text('$section : الشعبه'),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('$time : الوقت'),
                      Text('$day : اليوم'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
