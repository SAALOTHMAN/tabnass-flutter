import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tapnassfluteer/globelVariables.dart';
import 'package:tapnassfluteer/pages/AttendancePage.dart';

class SubjectWidget extends StatelessWidget {
  final String subject;
  final String section;

  const SubjectWidget({
    Key? key,
    required this.subject,
    required this.section,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return GestureDetector(
      onTap: () {
        Get.to(AttendancePage());
      },
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Color(0xffF4F4F4),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Text(
                          subject,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: ( 14/ 392) *
                                  MediaQuery.of(context).size.width),
                        ),
                        Text(
                          ' :المادة',
                          style: TextStyle(
                              color: prandColor,
                              fontSize: (17/392) *
                                  MediaQuery.of(context).size.width),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Icon(
                            Icons.menu_book,
                            color: prandColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text(
                          section,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: (14/392) *
                                  MediaQuery.of(context).size.width),
                        ),
                        Text(
                          ' :الشعبة',
                          style: TextStyle(
                              color: prandColor,
                              fontSize: (17/392) *
                                  MediaQuery.of(context).size.width),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Icon(
                              Icons.people_outline_rounded,
                              color: prandColor,
                              ),
                        ),
                      ],
                    ),
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
