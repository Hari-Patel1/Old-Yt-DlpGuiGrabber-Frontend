import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:yt_dlp_gui_grabber/home/logic/elements/settings_bloc.dart';

import 'auto_tag_page.dart';

enum SortOrder { nameAsc, nameDesc, dateAsc, dateDesc }

class TagAudioPage extends StatefulWidget {
  const TagAudioPage({super.key});

  @override
  State<TagAudioPage> createState() => _TagAudioPageState();
}

class _TagAudioPageState extends State<TagAudioPage> {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  Set<String> selectedExtensions = {'.mp3', '.m4a', '.opus'};
  bool showOnlyUntagged = false;
  SortOrder currentSortOrder = SortOrder.nameAsc;

  /// You can define your own logic for what counts as tagged.
  /// For demo, we'll check if title or artist contains 'unknown'
  bool isSongTagged(SongModel song) {
    final title = song.title.toLowerCase();
    final artist = (song.artist ?? '').toLowerCase();
    if (title.contains('unknown') || artist.contains('unknown')) {
      return false; // Treat as untagged
    }
    return true; // Consider tagged
  }

  void _handleMenuSelection(
      String value,
      List<SongModel> filteredSongs,
      ) {
    setState(() {
      switch (value) {
        case 'start_auto':
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AutoTagPage(
                songs: filteredSongs,
              ),
            ),
          );
          return; // Skip further setState

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
              final folderName = state.downloadDirectory?.path
                  .split('/') // Using '/' because OnAudioQuery accesses external storage URIs
                  .last ??
                  "No folder selected";
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text("Tag Audio - $folderName"),
              );
            },
          ),
        ),
      ),
      body: FutureBuilder<List<SongModel>>(
        future: _audioQuery.querySongs(
          sortType: SongSortType.DISPLAY_NAME,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading songs: ${snapshot.error}'));
          }

          final allSongs = snapshot.data ?? [];

          // Filter by extension and optionally exclude tagged songs
          final filteredSongs = allSongs.where((song) {
            final ext = '.' + (song.fileExtension?.toLowerCase() ?? '');
            if (!selectedExtensions.contains(ext)) return false;
            if (showOnlyUntagged && isSongTagged(song)) return false;
            return true;
          }).toList();

          // Sort songs
          filteredSongs.sort((a, b) {
            switch (currentSortOrder) {
              case SortOrder.nameAsc:
                return a.title.toLowerCase().compareTo(b.title.toLowerCase());
              case SortOrder.nameDesc:
                return b.title.toLowerCase().compareTo(a.title.toLowerCase());
              case SortOrder.dateAsc:
                return a.dateAdded!.compareTo(b.dateAdded!);
              case SortOrder.dateDesc:
                return b.dateAdded!.compareTo(a.dateAdded!);
            }
          });

          return Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: PopupMenuButton<String>(
                  onSelected: (value) => _handleMenuSelection(value, filteredSongs),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'start_auto',
                      child: Text('Start Auto Mode'),
                    ),
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
                    const PopupMenuItem(
                      value: 'sort_name_asc',
                      child: Text('Sort: Name (A-Z)'),
                    ),
                    const PopupMenuItem(
                      value: 'sort_name_desc',
                      child: Text('Sort: Name (Z-A)'),
                    ),
                    const PopupMenuItem(
                      value: 'sort_date_asc',
                      child: Text('Sort: Oldest first'),
                    ),
                    const PopupMenuItem(
                      value: 'sort_date_desc',
                      child: Text('Sort: Newest first'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: filteredSongs.isEmpty
                    ? const Center(child: Text("No audio files found"))
                    : ListView.separated(
                  itemCount: filteredSongs.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final song = filteredSongs[index];
                    final tagged = isSongTagged(song);

                    return ListTile(
                      leading: Icon(
                        tagged ? Icons.check_circle_outline : Icons.audiotrack_outlined,
                        color: tagged ? Colors.green : null,
                      ),
                      title: Text(song.title),
                      subtitle: Text(song.artist ?? "Unknown Artist"),
                      onTap: () {
                        // Optional: navigate to manual tagging page for this song
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
