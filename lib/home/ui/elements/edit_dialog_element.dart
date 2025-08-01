import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPreferencesDialog extends StatefulWidget {
  const EditPreferencesDialog({super.key});

  @override
  State<EditPreferencesDialog> createState() => _EditPreferencesDialogState();
}

class _EditPreferencesDialogState extends State<EditPreferencesDialog> {
  String selectedExtension = ' mp4';
  String selectedAudioQuality = ' 320k';
  String selectedVideoQuality = ' 1080p';

  bool audioOnly = false;
  bool embedThumbnail = true;
  bool addMetadata = true;
  bool downloadAlbumArt = true;

  final List<String> extensionOptions = [' mp4', ' webm', ' mkv', ' mp3'];
  final List<String> audioQualityOptions = [' 320k', ' 256k', ' 192k', ' 128k'];
  final List<String> videoQualityOptions = [' 2160p', ' 1440p', ' 1080p', ' 720p', ' 480p'];

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      selectedExtension = prefs.getString('extension') ?? ' mp4';
      audioOnly = prefs.getBool('audioOnly') ?? false;
      selectedAudioQuality = prefs.getString('audioQuality') ?? ' 320k';
      selectedVideoQuality = prefs.getString('videoQuality') ?? ' 1080p';
      embedThumbnail = prefs.getBool('embedThumbnail') ?? true;
      downloadAlbumArt = prefs.getBool('downloadAlbumArt') ?? true;
      addMetadata = prefs.getBool('addMetadata') ?? true;
    });
  }

  Future<void> savePreferences() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('extension', selectedExtension);
    await prefs.setBool('audioOnly', audioOnly);
    await prefs.setString('audioQuality', selectedAudioQuality);
    await prefs.setString('videoQuality', selectedVideoQuality);
    await prefs.setBool('embedThumbnail', embedThumbnail);
    await prefs.setBool('downloadAlbumArt', downloadAlbumArt);
    await prefs.setBool('addMetadata', addMetadata);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Download Preferences",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 12),
            const Text("• File Extension", style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedExtension,
              onChanged: (value) => setState(() => selectedExtension = value!),
              items: extensionOptions.map((ext) => DropdownMenuItem(
                value: ext,
                child: Text(ext.toUpperCase()),
              )).toList(),
            ),

            const SizedBox(height: 12),
            CheckboxListTile(
              title: const Text("Download Audio Only"),
              value: audioOnly,
              onChanged: (value) => setState(() => audioOnly = value!),
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
            ),

            const SizedBox(height: 8),
            Text(audioOnly ? "• Audio Quality" : "• Video Resolution",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              isExpanded: true,
              value: audioOnly ? selectedAudioQuality : selectedVideoQuality,
              onChanged: (value) {
                setState(() {
                  if (audioOnly) {
                    selectedAudioQuality = value!;
                  } else {
                    selectedVideoQuality = value!;
                  }
                });
              },
              items: (audioOnly ? audioQualityOptions : videoQualityOptions)
                  .map((option) => DropdownMenuItem(
                value: option,
                child: Text(option),
              ))
                  .toList(),
            ),

            const SizedBox(height: 12),
            CheckboxListTile(
              title: const Text("Embed Thumbnail"),
              value: embedThumbnail,
              onChanged: (value) => setState(() => embedThumbnail = value!),
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
            ),

            CheckboxListTile(
              title: const Text("Download Album Art"),
              value: downloadAlbumArt,
              onChanged: (value) => setState(() => downloadAlbumArt = value!),
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
            ),

            CheckboxListTile(
              title: const Text("Add Metadata Tags"),
              value: addMetadata,
              onChanged: (value) => setState(() => addMetadata = value!),
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FilledButton(
          onPressed: () async {
            await savePreferences(); // Save before closing
            Navigator.of(context).pop(); // Close dialog
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
