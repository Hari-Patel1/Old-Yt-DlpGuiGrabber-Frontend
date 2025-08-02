import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../logic/elements/edit_dialog_bloc.dart";

class EditPreferencesDialog extends StatelessWidget {
  const EditPreferencesDialog({super.key});

  static const List<String> extensionOptions = ["mp4", "webm", "mkv", "mp3"];
  static const List<String> audioQualityOptions = ["320k", "256k", "192k", "128k"];
  static const List<String> videoQualityOptions = ["2160p", "1440p", "1080p", "720p", "480p"];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditDialogBloc()..add(LoadPreferences()),
      child: BlocBuilder<EditDialogBloc, EditDialogState>(
        builder: (context, state) {
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
                    value: extensionOptions.contains(state.selectedExtension)
                        ? state.selectedExtension
                        : extensionOptions.first,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<EditDialogBloc>().add(UpdateExtension(value));
                      }
                    },
                    items: extensionOptions
                        .map((ext) => DropdownMenuItem(
                      value: ext,
                      child: Text(ext.toUpperCase()),
                    ))
                        .toList(),
                  ),

                  const SizedBox(height: 12),
                  CheckboxListTile(
                    title: const Text("Download Audio Only"),
                    value: state.audioOnly,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<EditDialogBloc>().add(UpdateAudioOnly(value));
                      }
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    dense: true,
                  ),

                  const SizedBox(height: 8),
                  Text(
                    state.audioOnly ? "• Audio Quality" : "• Video Resolution",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    isExpanded: true,
                    value: state.audioOnly
                        ? (audioQualityOptions.contains(state.selectedAudioQuality)
                        ? state.selectedAudioQuality
                        : audioQualityOptions.first)
                        : (videoQualityOptions.contains(state.selectedVideoQuality)
                        ? state.selectedVideoQuality
                        : videoQualityOptions.first),
                    onChanged: (value) {
                      if (value == null) return;
                      final bloc = context.read<EditDialogBloc>();

                      if (state.audioOnly) {
                        bloc.add(UpdateAudioQuality(value));
                      } else {
                        bloc.add(UpdateVideoQuality(value));
                      }
                    },
                    items: (state.audioOnly ? audioQualityOptions : videoQualityOptions)
                        .map((option) => DropdownMenuItem(
                      value: option,
                      child: Text(option),
                    ))
                        .toList(),
                  ),

                  const SizedBox(height: 12),
                  CheckboxListTile(
                    title: const Text("Embed Thumbnail"),
                    value: state.embedThumbnail,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<EditDialogBloc>().add(UpdateEmbedThumbnail(value));
                      }
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    dense: true,
                  ),

                  CheckboxListTile(
                    title: const Text("Download Album Art"),
                    value: state.downloadAlbumArt,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<EditDialogBloc>().add(UpdateDownloadAlbumArt(value));
                      }
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    dense: true,
                  ),

                  CheckboxListTile(
                    title: const Text("Add Metadata Tags"),
                    value: state.addMetadata,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<EditDialogBloc>().add(UpdateAddMetadata(value));
                      }
                    },
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
                  context.read<EditDialogBloc>().add(SavePreferences());
                  Navigator.of(context).pop();
                },
                child: const Text("Save"),
              ),
            ],
          );
        },
      ),
    );
  }
}
