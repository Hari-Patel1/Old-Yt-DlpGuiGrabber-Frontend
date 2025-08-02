import "dart:convert";

import "package:http/http.dart" as http;

Future<Map<String, dynamic>> prefsPost(Map<String, dynamic> prefs) async {
  final response = await http.post(
    Uri.parse("http://192.168.0.44:8000/download"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(prefs), // 👈 this encodes the whole map
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body) as Map<String, dynamic>;
  } else {
    throw Exception("Failed to connect: ${response.statusCode}");
  }
}

// Future<String> urlPost(String url) async {
//   final response = await http.post(
//     Uri.parse("http://192.168.0.44:8000/download"),
//     headers: {"Content-Type": "application/json"},
//     body: jsonEncode({"url": url}),
//   );
//
//   if (response.statusCode == 200) {
//     return response.body;
//   } else {
//     throw Exception("Failed to connect: ${response.statusCode}");
//   }
// }
//
// Future<Map<String, dynamic>> prefsPost(Map<String, dynamic> prefs) async {
//   final response = await http.post(
//     Uri.parse("http://192.168.0.44:8000/download"),
//     headers: {"Content-Type": "application/json"},
//     body: jsonEncode(prefs),
//   );
//
//   if (response.statusCode == 200) {
//     return jsonDecode(response.body) as Map<String, dynamic>;
//   } else {
//     throw Exception("Failed to connect: ${response.statusCode}");
//   }
// }
//



