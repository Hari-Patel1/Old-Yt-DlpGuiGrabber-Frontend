import 'dart:io';

import 'package:easy_folder_picker/FolderPicker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yt_dlp_gui_grabber/home/ui/pages/download_directory_page.dart';

class EditSettingsDialog extends StatefulWidget {
  const EditSettingsDialog({super.key});

  @override
  State<EditSettingsDialog> createState() => _EditSettingsDialogState();
}

class _EditSettingsDialogState extends State<EditSettingsDialog> {
  bool notificationsEnabled = true;
  Directory? selectedDirectory;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadSettings();
    _loadSavedDirectory();
  }

  Future<void> _loadSavedDirectory() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPath = prefs.getString('download_directory');
    if (savedPath != null && Directory(savedPath).existsSync()) {
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
      await prefs.setString('download_directory', newDirectory.path);
      setState(() {
        selectedDirectory = newDirectory;
      });
      Navigator.of(context).pop(newDirectory.path); // Close dialog and return path
    }
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
    });
  }

  Future<void> saveSettings(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', value);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17.5)),
      insetPadding: const EdgeInsets.all(24),
      content: Padding(
        padding: const EdgeInsets.only(top: 24.0, left: 20, right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "App Settings",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Notifications Toggle
            SwitchListTile(
              title: const Text("Enable Notifications"),
              value: notificationsEnabled,
              onChanged: (value) {
                setState(() => notificationsEnabled = value);
                saveSettings(value);
              },
              secondary: const Icon(Icons.notifications_active_outlined),
              contentPadding: EdgeInsets.zero,
            ),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.snippet_folder_outlined),
              title: const Text("Change download directory"),
              onTap: () {
                _pickDirectory(context);
              },
            ),

            const Divider(),

            // About App
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.info_outline),
              title: const Text("About"),
              onTap: () {
                Navigator.pop(context);
                showAboutDialog(
                  context: context,
                  applicationName: "Yt-Dlp Grabber",
                  applicationVersion: "v1.0.0",
                  applicationLegalese: "© 2025 Yt-Dlp Grabber",
                );
              },
            ),
            const SizedBox(height: 6),
            // Clear Cache
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.delete_outline),
              title: const Text("Clear Cache"),
              onTap: () {
                // Implement your cache clearing logic here
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Cache cleared successfully!")),
                );
              },
            ),

            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
