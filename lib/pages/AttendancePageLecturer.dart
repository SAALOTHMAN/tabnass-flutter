import 'dart:collection';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tapnassfluteer/globelVariables.dart';
import 'package:tapnassfluteer/pages/HomePage.dart';
import 'package:tapnassfluteer/util/http_utilities.dart';
import 'package:tapnassfluteer/widgets/AttendanceWidget.dart';
import 'package:tapnassfluteer/widgets/attendanceRecordWidget.dart';

class AttendancePageLecturer extends StatefulWidget {
  AttendancePageLecturer({super.key, required this.sectionId});
  final String sectionId;

  @override
  State<AttendancePageLecturer> createState() => _AttendancePageLecturerState();
}

class _AttendancePageLecturerState extends State<AttendancePageLecturer> {
  bool _loading = true;
  bool _records_loading = true;

  late String SelectedDate;
  late List<String> dates;
  late List<Map<String, String>> records;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetAttendaces();
    getdates();
  }

  void getdates() async {
    var response = await http_functions.HttpLoginRequired(
        "/Educator/dates/${widget.sectionId}", {}, true);

    response["response"]["dates"];
    dates =
        response["response"]["dates"].map<String>((e) => e.toString()).toList();
    dates = dates.reversed.toList();
    setState(() {
      dates;
      SelectedDate = dates.first;
      _loading = false;
    });
  }

  GetAttendaces({String query = ""}) async {
    var response = await http_functions.HttpLoginRequired(
        "/Educator/Course/${widget.sectionId}" + query, {}, true);
    var Json = response["response"];

    setState(() {
      records = [];
      for (var element in Json) {
        records.add({
          "status": element["Status"],
          "full_name":
              ' ${element["Student"]["F_Name"]}  ${element["Student"]["L_Name"]}',
          "ID": element["Student"]["ST_ID"],
          "time": element["Time"],
          "date": element["date"],
          "lec_id": element["Lecture"]["LEC_ID"]
        });
      }
      _records_loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900], // Set the app bar color to dark blue
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton<String>(
                          value: SelectedDate,
                          items: dates
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              SelectedDate = newValue as String;
                              _records_loading = true;
                              GetAttendaces(query: "?date=$SelectedDate");
                            });
                          },
                          hint: Text(
                            "اختر التاريخ",
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
                    _records_loading
                        ? Center(child: CircularProgressIndicator())
                        : Column(
                            children: [
                              ...records
                                  .map(
                                    (e) => attendanceRecordLactureWidget(
                                        date: e["date"] as String,
                                        lec_id: e["lec_id"] as String,
                                        status: e["status"] as String,
                                        time: e["time"] as String,
                                        fullName: e["full_name"] as String,
                                        ID: e["ID"] as String),
                                  )
                                  .toList()
                            ],
                          ),
                  ],
                ),
              ),
      ),
    );
  }
}
