import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tapnassfluteer/backend.dart';

class http_functions {
  static Future<Map<dynamic, dynamic>> HttpGet(String endpoint) async {
    var response = await http.get(Uri.parse(backend_url + endpoint));

    var response_json = json.decode(response.body);

    return {"response": response_json, "statusCode": response.statusCode};
  }

  static Future<Map<String, dynamic>> HttpPost(
      String endpoint, Map<String, String> body) async {
    var response =
        await http.post(Uri.parse(backend_url + endpoint), body: body);
    var response_json = json.decode(response.body);

    return {"response": response_json, "statusCode": response.statusCode};
  }

  static Future<Map<String, dynamic>> HttpLoginRequired(
      String endpoint, Map<String, String> body, bool IsGet) async {
    FlutterSecureStorage Storage = new FlutterSecureStorage();

    Map<String, String> headers = {
      "token": await Storage.read(key: "token") ?? ""
    };

    var response = (IsGet)
        ? await http.get(Uri.parse(backend_url + endpoint), headers: headers)
        : await http.post(Uri.parse(backend_url + endpoint),
            body: body, headers: headers);

    var response_json = json.decode(response.body);
    return {"response": response_json, "statusCode": response.statusCode};
  }
}
