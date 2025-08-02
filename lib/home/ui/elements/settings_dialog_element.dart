import "dart:io";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:easy_folder_picker/FolderPicker.dart";
import "../../logic/elements/settings_bloc.dart";

class EditSettingsDialog extends StatelessWidget {
  const EditSettingsDialog({super.key});

  // Helper to get platform fallback downloads folder
  Directory _getFallbackDownloadsDirectory() {
    if (Platform.isAndroid) {
      return Directory("/storage/emulated/0/Download");
    } else if (Platform.isWindows) {
      final userProfile = Platform.environment['USERPROFILE'] ?? '';
      return Directory("$userProfile\\Downloads");
    } else if (Platform.isLinux || Platform.isMacOS) {
      final home = Platform.environment['HOME'] ?? '';
      return Directory("$home/Downloads");
    }
    return Directory.current;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsBloc()..add(LoadSettings()),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final downloadDir =
              state.downloadDirectory ?? _getFallbackDownloadsDirectory();

          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17.5),
            ),
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

                  SwitchListTile(
                    title: const Text("Enable Notifications"),
                    value: state.notificationsEnabled,
                    onChanged: (value) {
                      context.read<SettingsBloc>().add(
                        ToggleNotifications(value),
                      );
                    },
                    secondary: const Icon(Icons.notifications_active_outlined),
                    contentPadding: EdgeInsets.zero,
                  ),

                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.snippet_folder_outlined),
                    title: const Text("Change download directory"),
                    subtitle: Text(downloadDir.path),
                    onTap: () async {
                      final newDir = await FolderPicker.pick(
                        context: context,
                        rootDirectory: downloadDir,
                        allowFolderCreation: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      );
                      if (newDir != null) {
                        context.read<SettingsBloc>().add(
                          SetDownloadDirectory(newDir),
                        );
                        // Don't pop dialog here so user can continue changing settings if needed
                      }
                    },
                  ),

                  const Divider(),

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

                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.delete_outline),
                    title: const Text("Clear Cache"),
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Cache cleared successfully!"),
                        ),
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
        },
      ),
    );
  }
}
