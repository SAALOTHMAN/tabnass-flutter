import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:tapnassfluteer/globelVariables.dart';
import 'package:tapnassfluteer/pages/AttendancePage.dart';
import 'package:tapnassfluteer/util/http_utilities.dart';
import 'package:tapnassfluteer/widgets/SubjectWidget.dart';

class shcedule extends StatefulWidget {
  const shcedule({super.key});

  @override
  State<shcedule> createState() => _shceduleState();
}

class _shceduleState extends State<shcedule> {
  late List<Map<String, String>> subjects;

  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetAllSubjects();
  }

  void GetAllSubjects() async {
    FlutterSecureStorage storage = new FlutterSecureStorage();

    bool IsStudent = (await storage.read(key: "isStudent")) == "true";

    var Response = IsStudent
        ? await http_functions.HttpLoginRequired("/student/Home", {}, true)
        : await http_functions.HttpLoginRequired("/Educator/Home", {}, true);

    var Response_json = Response["response"];

    subjects = [];
    for (var element in Response_json) {
      IsStudent
          ? subjects.add({
              "section_id": element["Section"]["SEC_ID"],
              "course_Name": element["Section"]["Course"]["Course_Name"],
              "course_ID": element["Section"]["Course"]["Course_ID"]
            })
          : subjects.add({
              "section_id": element["SEC_ID"],
              "course_Name": element["Course"]["Course_Name"],
              "course_ID": element["Course"]["Course_ID"]
            });
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(child: CircularProgressIndicator())
        : Column(
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

              ...subjects
                  .map(
                    (e) => SubjectWidget(
                      subject: e["course_Name"] as String,
                      section: e["course_ID"] as String,
                    ),
                  )
                  .toList()
            ],
          );
  }
}
