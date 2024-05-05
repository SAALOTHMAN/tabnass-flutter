import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tapnassfluteer/backend.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tapnassfluteer/pages/HomePage.dart';
import 'package:tapnassfluteer/util/http_utilities.dart';

class signin_page2 extends StatefulWidget {
  const signin_page2({Key? key, required this.isStudent}) : super(key: key);
  final bool isStudent;
  @override
  State<signin_page2> createState() => _signin_page2State();
}

class _signin_page2State extends State<signin_page2> {
  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Center(
              child: isSmallScreen
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                              padding: EdgeInsets.all(12),
                              child: IconButton(
                                icon: Icon(Icons.arrow_back_rounded),
                                onPressed: () {
                                  Get.back();
                                },
                              )),
                        ),
                        _Logo(),
                        _FormContent(
                          isStudent: widget.isStudent,
                        ),
                      ],
                    )
                  : Container(
                      padding: const EdgeInsets.all(32.0),
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: Row(
                        children: [
                          Expanded(child: _Logo()),
                          Expanded(
                            child: Center(
                                child: _FormContent(
                              isStudent: widget.isStudent,
                            )),
                          ),
                        ],
                      ),
                    )),
        ));
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/img_2_2x_8_1.png',
          width: 280,
          height: 280,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "تسجيل دخول",
            textAlign: TextAlign.center,
            style: isSmallScreen
                ? Theme.of(context).textTheme.headlineSmall
                : Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.black),
          ),
        )
      ],
    );
  }
}

class _FormContent extends StatefulWidget {
  const _FormContent({Key? key, required this.isStudent}) : super(key: key);

  final bool isStudent;
  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  Map<String, String> form = {"ID": "", "Password": ""};
  String errorMessage = "";

  FlutterSecureStorage storage = new FlutterSecureStorage();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              onChanged: (value) {
                form["ID"] = value;
              },
              validator: (value) {
                // add email validation
                if (value == null || value.isEmpty) {
                  return 'الرجاء ادخال الرقم';
                }

                if (widget.isStudent && value.length != 9) {
                  return 'الرجاء ادخال رقم صحيح';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'ID',
                hintText: 'ادخل الرقم الجامعي',
                prefixIcon: Icon(Icons.perm_identity_rounded),
                border: OutlineInputBorder(),
              ),
            ),
            _gap(),
            TextFormField(
              onChanged: (value) {
                form["Password"] = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء ادخال الرقم السري';
                }

                if (value.length < 6) {
                  return 'يجب ان يحتوي على 6 احرف على الاقل';
                }
                return null;
              },
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'أدخل كلمة السر',
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  )),
            ),
            Center(
              child: Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ),
            _gap(),
            _gap(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'تسجيل دخول',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    Map<dynamic, dynamic> result = widget.isStudent
                        ? await http_functions.HttpPost("/student/log_in", form)
                        : await http_functions.HttpPost(
                            "/Educator/log_in", form);

                    Map<String, dynamic> result_json = result["response"];

                    if (result["statusCode"] == 200) {
                      storage.write(key: "token", value: result_json["token"]);
                      storage.write(
                          key: "full_name", value: "${result_json["first_Name"]} ${result_json["last_Name"]}");

                      widget.isStudent
                          ? storage.write(
                              key: "ID", value: result_json["Student_ID"])
                          : storage.write(
                              key: "ID", value: result_json["Educator_ID"]);

                      storage.write(
                          key: "isStudent", value: widget.isStudent.toString());

                      Get.offAll(HomePage());
                    } else {
                      setState(() {
                        errorMessage = result_json["Message"];
                      });
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}
