import "package:flutter/services.dart";

Future<String?> getClipboardData() async {
  ClipboardData? data = await Clipboard.getData("text/plain");
  return data?.text;
}
