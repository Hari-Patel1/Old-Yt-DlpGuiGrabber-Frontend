import 'package:flutter/material.dart';

class EditDialog extends StatefulWidget {
  const EditDialog({super.key});

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
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

            if (audioOnly) ...[
              const SizedBox(height: 8),
              const Text("• Audio Quality", style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                isExpanded: true,
                value: selectedAudioQuality,
                onChanged: (value) => setState(() => selectedAudioQuality = value!),
                items: audioQualityOptions.map((quality) => DropdownMenuItem(
                  value: quality,
                  child: Text(quality),
                )).toList(),
              ),
            ] else ...[
              const SizedBox(height: 8),
              const Text("• Video Resolution", style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                isExpanded: true,
                value: selectedVideoQuality,
                onChanged: (value) => setState(() => selectedVideoQuality = value!),
                items: videoQualityOptions.map((res) => DropdownMenuItem(
                  value: res,
                  child: Text(res),
                )).toList(),
              ),
            ],

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
          onPressed: () {
            Navigator.of(context).pop({
              "extension": selectedExtension,
              "audioOnly": audioOnly,
              "audioQuality": selectedAudioQuality,
              "videoQuality": selectedVideoQuality,
              "embedThumbnail": embedThumbnail,
              "downloadAlbumArt": downloadAlbumArt,
              "addMetadata": addMetadata,
            });
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
