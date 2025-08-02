import "dart:io";

import "package:easy_folder_picker/FolderPicker.dart";
import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

class DirectoryPickerDialog extends StatefulWidget {
  const DirectoryPickerDialog({super.key});

  @override
  State<DirectoryPickerDialog> createState() => _DirectoryPickerDialogState();
}

class _DirectoryPickerDialogState extends State<DirectoryPickerDialog> {
  Directory? selectedDirectory;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedDirectory();
  }

  Future<void> _loadSavedDirectory() async {
    final prefs = await SharedPreferences.getInstance();
    var savedPath = prefs.getString("download_directory");

    if (savedPath != null && Directory(savedPath).existsSync()) {
      selectedDirectory = Directory(savedPath);
    } else {
      // No saved path set, fallback depending on platform
      if (Platform.isAndroid) {
        // Typical Android downloads folder
        savedPath = "/storage/emulated/0/Download";
      } else if (Platform.isWindows) {
        // Windows downloads folder (assuming user folder)
        final userProfile = Platform.environment['USERPROFILE'] ?? '';
        savedPath = "$userProfile\\Downloads";
      } else if (Platform.isLinux || Platform.isMacOS) {
        // Linux or macOS downloads folder
        final home = Platform.environment['HOME'] ?? '';
        savedPath = "$home/Downloads";
      } else {
        // Fallback to current directory
        savedPath = Directory.current.path;
      }

      selectedDirectory = Directory(savedPath);
    }

    setState(() {
      isLoading = false;
    });
  }


  Future<void> _pickDirectory(BuildContext context) async {
    Directory root = selectedDirectory ?? Directory(FolderPicker.rootPath);

    final newDirectory = await FolderPicker.pick(
      context: context,
      rootDirectory: root,
      allowFolderCreation: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );

    if (newDirectory != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("download_directory", newDirectory.path);
      setState(() {
        selectedDirectory = newDirectory;
      });
      Navigator.of(context).pop(newDirectory.path); // Close dialog and return path
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Select Download Directory"),
      content: isLoading
          ? const SizedBox(
        height: 80,
        child: Center(child: CircularProgressIndicator()),
      )
          : Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            selectedDirectory?.path ?? "No folder selected",
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            icon: const Icon(Icons.folder_open),
            label: const Text("Choose Folder"),
            onPressed: () => _pickDirectory(context),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
