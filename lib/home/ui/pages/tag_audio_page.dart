import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_dlp_gui_grabber/home/logic/elements/settings_bloc.dart';

import 'auto_tag_page.dart';

enum SortOrder { nameAsc, nameDesc, dateAsc, dateDesc }

class TagAudioPage extends StatefulWidget {
  const TagAudioPage({super.key});

  @override
  State<TagAudioPage> createState() => _TagAudioPageState();
}

class _TagAudioPageState extends State<TagAudioPage> {
  Set<String> selectedExtensions = {'.mp3', '.m4a', '.opus'};
  bool showOnlyUntagged = false;
  SortOrder currentSortOrder = SortOrder.nameAsc;

  bool isFileTagged(FileSystemEntity file) {
    final fileName = file.path.toLowerCase();
    return fileName.contains(' - ') && !fileName.contains('unknown');
  }

  void _handleMenuSelection(String value, List<FileSystemEntity> filteredFiles) {
    setState(() {
      switch (value) {
        case 'start_auto':
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AutoTagPage(
              ),
            ),
          );
          break;
        case 'show_untagged':
          showOnlyUntagged = !showOnlyUntagged;
          break;
        case 'sort_name_asc':
          currentSortOrder = SortOrder.nameAsc;
          break;
        case 'sort_name_desc':
          currentSortOrder = SortOrder.nameDesc;
          break;
        case 'sort_date_asc':
          currentSortOrder = SortOrder.dateAsc;
          break;
        case 'sort_date_desc':
          currentSortOrder = SortOrder.dateDesc;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Scrollbar(
          thumbVisibility: true,
          child: BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              final folderName = state.downloadDirectory?.path.split(Platform.pathSeparator).last ?? "No folder selected";
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text("Tag Audio - $folderName"),
              );
            },
          ),
        ),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          final directory = state.downloadDirectory;

          if (directory == null) {
            return const Center(child: Text("No download directory selected"));
          }

          return FutureBuilder<List<FileSystemEntity>>(
            future: directory.list().toList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final allFiles = snapshot.data ?? [];

              // Filter by extension and optionally exclude tagged files
              final filteredFiles = allFiles.where((file) {
                final ext = '.' + file.path.split('.').last.toLowerCase();
                if (!selectedExtensions.contains(ext)) return false;
                if (showOnlyUntagged && isFileTagged(file)) return false;
                return true;
              }).toList();

              // Sort files
              filteredFiles.sort((a, b) {
                switch (currentSortOrder) {
                  case SortOrder.nameAsc:
                    return a.path.toLowerCase().compareTo(b.path.toLowerCase());
                  case SortOrder.nameDesc:
                    return b.path.toLowerCase().compareTo(a.path.toLowerCase());
                  case SortOrder.dateAsc:
                    return a.statSync().modified.compareTo(b.statSync().modified);
                  case SortOrder.dateDesc:
                    return b.statSync().modified.compareTo(a.statSync().modified);
                }
              });

              return Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: PopupMenuButton<String>(
                      onSelected: (value) => _handleMenuSelection(value, filteredFiles),
                      itemBuilder: (context) => [
                        const PopupMenuItem(value: 'start_auto', child: Text('Start Auto Mode')),
                        const PopupMenuDivider(),
                        PopupMenuItem(
                          value: 'show_untagged',
                          child: Row(
                            children: [
                              Checkbox(
                                value: showOnlyUntagged,
                                onChanged: (_) {},
                              ),
                              const Text('Only show untagged'),
                            ],
                          ),
                        ),
                        const PopupMenuDivider(),
                        const PopupMenuItem(value: 'sort_name_asc', child: Text('Sort: Name (A-Z)')),
                        const PopupMenuItem(value: 'sort_name_desc', child: Text('Sort: Name (Z-A)')),
                        const PopupMenuItem(value: 'sort_date_asc', child: Text('Sort: Oldest first')),
                        const PopupMenuItem(value: 'sort_date_desc', child: Text('Sort: Newest first')),
                      ],
                    ),
                  ),
                  Expanded(
                    child: filteredFiles.isEmpty
                        ? const Center(child: Text("No audio files found"))
                        : ListView.separated(
                      itemCount: filteredFiles.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final file = filteredFiles[index];
                        final fileName = file.path.split(Platform.pathSeparator).last;
                        final tagged = isFileTagged(file);

                        return ListTile(
                          leading: Icon(
                            tagged
                                ? Icons.check_circle_outline
                                : Icons.audiotrack_outlined,
                            color: tagged ? Colors.green : null,
                          ),
                          title: Text(fileName),
                          onTap: () {
                            // Optional: Navigate to manual tagging page
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
