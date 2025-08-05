import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_dlp_gui_grabber/home/ui/pages/auto_tag_page.dart';

import '../../logic/elements/settings_bloc.dart';

enum SortOrder { nameAsc, nameDesc, dateAsc, dateDesc }

class TagAudioPage extends StatefulWidget {
  const TagAudioPage({super.key});

  @override
  State<TagAudioPage> createState() => _TagAudioPageState();
}

class _TagAudioPageState extends State<TagAudioPage> {
  List<String> selectedExtensions = ['mp3', 'm4a', 'wav', 'aac', 'flac', 'ogg'];
  SortOrder currentSortOrder = SortOrder.nameAsc;
  bool showOnlyUntagged = false;

  /// Checks if the audio file is tagged.
  /// Example logic: If a sidecar file with `.tagged` extension exists, consider it tagged.
  bool isFileTagged(FileSystemEntity file) {
    final taggedSidecar = File('${file.path}.tagged');
    return taggedSidecar.existsSync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_horiz_outlined),
            onSelected: (value) {
              switch (value) {
                case 'start_auto':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AutoTagPage(),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Auto tagging started')),
                  );
                  break;
                case 'sort_name_asc':
                  setState(() => currentSortOrder = SortOrder.nameAsc);
                  break;
                case 'sort_name_desc':
                  setState(() => currentSortOrder = SortOrder.nameDesc);
                  break;
                case 'sort_date_asc':
                  setState(() => currentSortOrder = SortOrder.dateAsc);
                  break;
                case 'sort_date_desc':
                  setState(() => currentSortOrder = SortOrder.dateDesc);
                  break;
                case 'filter_untagged':
                  setState(() => showOnlyUntagged = !showOnlyUntagged);
                  break;
              }
            },
            itemBuilder:
                (context) => [
                  const PopupMenuItem(
                    value: 'start_auto',
                    child: Text('Start Auto Mode'),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    value: 'sort_name_asc',
                    child: Text(
                      'Sort by Name ↑',
                      style: TextStyle(
                        fontWeight:
                            currentSortOrder == SortOrder.nameAsc
                                ? FontWeight.bold
                                : FontWeight.normal,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'sort_name_desc',
                    child: Text(
                      'Sort by Name ↓',
                      style: TextStyle(
                        fontWeight:
                            currentSortOrder == SortOrder.nameDesc
                                ? FontWeight.bold
                                : FontWeight.normal,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'sort_date_asc',
                    child: Text(
                      'Sort by Date ↑',
                      style: TextStyle(
                        fontWeight:
                            currentSortOrder == SortOrder.dateAsc
                                ? FontWeight.bold
                                : FontWeight.normal,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'sort_date_desc',
                    child: Text(
                      'Sort by Date ↓',
                      style: TextStyle(
                        fontWeight:
                            currentSortOrder == SortOrder.dateDesc
                                ? FontWeight.bold
                                : FontWeight.normal,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'filter_untagged',
                    child: Text(
                      showOnlyUntagged
                          ? 'Show All Files'
                          : 'Show Only Untagged',
                      style: TextStyle(
                        fontWeight:
                            showOnlyUntagged
                                ? FontWeight.bold
                                : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
          ),
        ],
        title: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return Text(
              "Tag Audio - ${state.downloadDirectory?.path.split(Platform.pathSeparator).last ?? "No folder selected"}",
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            const Divider(thickness: 1.2),
            Expanded(
              child: BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, state) {
                  final directory = state.downloadDirectory;
                  if (directory == null) {
                    return const Center(child: Text("No directory selected"));
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

                      final filteredFiles =
                          allFiles.where((file) {
                            final ext = file.path.split('.').last.toLowerCase();
                            if (!selectedExtensions.contains(ext)) return false;

                            if (showOnlyUntagged && isFileTagged(file))
                              return false;

                            return true;
                          }).toList();

                      filteredFiles.sort((a, b) {
                        switch (currentSortOrder) {
                          case SortOrder.nameAsc:
                            return a.path.toLowerCase().compareTo(
                              b.path.toLowerCase(),
                            );
                          case SortOrder.nameDesc:
                            return b.path.toLowerCase().compareTo(
                              a.path.toLowerCase(),
                            );
                          case SortOrder.dateAsc:
                            return a.statSync().modified.compareTo(
                              b.statSync().modified,
                            );
                          case SortOrder.dateDesc:
                            return b.statSync().modified.compareTo(
                              a.statSync().modified,
                            );
                        }
                      });

                      if (filteredFiles.isEmpty) {
                        return const Center(
                          child: Text("No audio files found"),
                        );
                      }

                      return ListView.separated(
                        itemCount: filteredFiles.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, index) {
                          final file = filteredFiles[index];
                          final fileName =
                              file.path.split(Platform.pathSeparator).last;
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
                              // TODO: Handle tap, e.g., play or tag the audio file
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
