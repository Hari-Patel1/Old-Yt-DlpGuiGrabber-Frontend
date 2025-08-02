import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> callEcho(String message) async {
  final response = await http.post(
    Uri.parse("http://192.168.0.44:8000/download"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"message": message}),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body)["url"]["message"];
  } else {
    throw Exception("Failed to connect: ${response.statusCode}");
  }
}
