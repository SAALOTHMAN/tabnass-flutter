import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tapnassfluteer/globelVariables.dart';
import 'package:tapnassfluteer/pages/HomePage.dart';
import 'package:tapnassfluteer/util/http_utilities.dart';
import 'package:tapnassfluteer/widgets/AttendanceWidget.dart';
import 'package:tapnassfluteer/widgets/attendanceRecordWidget.dart';

class AttendancePage extends StatefulWidget {
  AttendancePage({super.key, required this.sectionId});
  final String sectionId;

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  late List<Map<String, dynamic>> AttendanceRecords;
  late List<attendanceRecordWidget> FilteredAttendanceRecords;

  late Map<String, dynamic> Educator = {};
  String selected = "أختر الحالة";
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    GetAttendanceRecord();
  }

  void GetAttendanceRecord() async {
    var response = await http_functions.HttpLoginRequired(
        "/student/Course/${widget.sectionId}", {}, true);

    List response_json = response["response"]["data"];

    Educator["full-name"] =
        "${response["response"]["Educator"]["Educator"]["F_Name"]} ${response["response"]["Educator"]["Educator"]["L_Name"]}";
    Educator["location"] =
        response["response"]["Educator"]["Educator"]["Room_Number"];
    this.AttendanceRecords = response_json
        .map(
          (e) => {
            "status": e["Status"],
            "time": e["Time"],
            "date": e["date"],
            "day": e["Lecture"]["day"],
          },
        )
        .toList();

    FilteredAttendanceRecords =
        AttendanceRecords.map((e) => attendanceRecordWidget(
              status: e["status"],
              time: e["time"],
              date: e["date"],
              day: e["day"],
            )).toList();

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: prandColor, // Set the app bar color to dark blue
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: _loading
            ? Center(
                child: SpinKitCubeGrid(
                  color: prandColor,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        contentPadding: EdgeInsets.all(13),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        tileColor: prandColor,
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage("assets/images/avatar.jpg"),
                        ),
                        title: Text(
                          "د." + Educator["full-name"],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          "الموقع: ${Educator["location"]}",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton<String>(
                          value: selected,
                          items: <String>[
                            'أختر الحالة',
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
                            setState(() {
                              selected = newValue as String;
                              if (selected == "أختر الحالة") {
                                FilteredAttendanceRecords =
                                    AttendanceRecords.map(
                                        (e) => attendanceRecordWidget(
                                              status: e["status"],
                                              time: e["time"],
                                              date: e["date"],
                                              day: e["day"],
                                            )).toList();

                                return;
                              }

                              FilteredAttendanceRecords =
                                  AttendanceRecords.where((element) {
                                return element["status"] == selected;
                              })
                                      .toList()
                                      .map((e) => attendanceRecordWidget(
                                            status: e["status"],
                                            time: e["time"],
                                            date: e["date"],
                                            day: e["day"],
                                          ))
                                      .toList();
                              ;
                            });
                          },
                          hint: Text(
                            "اختر الحالة",
                            style: TextStyle(
                                color: prandColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text(
                          'سجل الحضور',
                          style: TextStyle(fontSize: 20, color: prandColor),
                        ),
                      ],
                    ),
                    SizedBox(height: 22),
                    ...this.FilteredAttendanceRecords
                  ],
                ),
              ),
      ),
    );
  }
}
