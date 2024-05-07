import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tapnassfluteer/globelVariables.dart';
import 'package:tapnassfluteer/util/http_utilities.dart';

class attendanceRecordWidget extends StatelessWidget {
  const attendanceRecordWidget(
      {super.key,
      required this.status,
      required this.time,
      required this.date,
      required this.day});

  final String status;
  final String time;
  final String date;
  final String day;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Color(0xffF4F4F4),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: attendanceElement(
                      title: ' :الحالة',
                      icon: Icons.people_outline_rounded,
                      content: status),
                ),
                Container(
                  child: attendanceElement(
                      title: ' :الوقت',
                      icon: Icons.access_time_sharp,
                      content: time),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: attendanceElement(
                      title: ' :التاريح',
                      icon: Icons.date_range,
                      content: date),
                ),
                Container(
                  child: attendanceElement(
                      title: ' :اليوم',
                      icon: Icons.domain_verification_sharp,
                      content: day),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class attendanceRecordLactureWidget extends StatelessWidget {
  const attendanceRecordLactureWidget(
      {super.key,
      required this.status,
      required this.time,
      required this.fullName,
      required this.ID,
      required this.date,
      required this.lec_id});

  final String status;
  final String fullName;
  final String ID;
  final String time;

  final String date;
  final String lec_id;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Color(0xffF4F4F4),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: DropdownButton<String>(
                    value: status,
                    items: <String>[
                      'حاضر',
                      'غائب',
                      'متأخر',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      print(lec_id);
                      print(date);
                      print(ID);

                      http_functions.HttpLoginRequired(
                          "/Educator/Change_Student_Status/$lec_id/$ID",
                          {"Status": newValue as String, "date": date},
                          false);
                    },
                  ),
                ),
                Container(
                  child: attendanceElement(
                      title: ' :الوقت',
                      icon: Icons.access_time_sharp,
                      content: time),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: attendanceElement(
                      title: ' :الأسم', icon: Icons.person, content: fullName),
                ),
                Container(
                  child: attendanceElement(
                      title: ' :ID',
                      icon: Icons.domain_verification_sharp,
                      content: ID),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class attendanceElement extends StatefulWidget {
  const attendanceElement(
      {super.key,
      required this.title,
      required this.icon,
      required this.content});
  final String title;
  final IconData icon;
  final String content;

  @override
  State<attendanceElement> createState() => _attendanceElementState();
}

class _attendanceElementState extends State<attendanceElement> {
  Color contentColor = Colors.grey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.title != ' :الحالة') return;

    switch (widget.content) {
      case "حاضر":
        contentColor = Colors.green;
        break;

      case "غائب":
        contentColor = Colors.red;
        break;

      case "متأخر":
        contentColor = Colors.orange;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.content,
          style: TextStyle(
              color: contentColor,
              fontSize: (14 / 392) * MediaQuery.of(context).size.width),
        ),
        Text(
          widget.title,
          style: TextStyle(
              color: prandColor,
              fontSize: (15 / 392) * MediaQuery.of(context).size.width),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Icon(
            widget.icon,
            color: prandColor,
            size: (16 / 392) * MediaQuery.of(context).size.width,
          ),
        ),
      ],
    );
  }
}
