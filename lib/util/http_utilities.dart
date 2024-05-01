import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tapnassfluteer/backend.dart';

class http_functions {
  Future<Map<dynamic, dynamic>> HttpGet(String endpoint) async {
    var response = await http.get(Uri.parse(backend_url + endpoint));

    var response_json = json.decode(response.body);

    return {"response": response_json, "statusCode": response.statusCode};
  }
}
