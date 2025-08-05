import 'package:on_audio_query/on_audio_query.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/pages/auto_tag_bloc.dart';


class AutoTagPage extends StatelessWidget {
  final List<SongModel> songs;

  const AutoTagPage({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AutoTagBloc()..add(LoadFiles(songs)),
      child: Scaffold(
        appBar: AppBar(title: const Text("Auto Tag page")),
        body: SafeArea(
          child: BlocBuilder<AutoTagBloc, AutoTagState>(
            builder: (context, state) {
              final bloc = context.read<AutoTagBloc>();

              if (state.filesToTag.isEmpty) {
                return const Center(child: Text("No files to tag."));
              }

              // Show loading indicator while fetching tags
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              // Display error if any
              if (state.hasError) {
                return Center(child: Text("Error: ${state.errorMessage}"));
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    const Divider(),
                    // Album Art section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: double.infinity,
                        child: Card(
                          child: state.albumArt != null && state.albumArt!.isNotEmpty
                              ? Image.memory(
                            state.albumArt!,
                            fit: BoxFit.cover,
                          )
                              : const Center(child: Text("No Album Art")),

                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Song title & artist
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 27.5),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              state.title.isNotEmpty ? state.title : "Unknown Title",
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              state.artist.isNotEmpty ? state.artist : "Unknown Artist",
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Most fitting tag placeholder (could be expanded)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: SizedBox(
                        height: 75,
                        width: double.infinity,
                        child: Card(
                          child: Center(
                            child: Text(
                              "Most Fitting Tag: ${state.suggestedTitle} - ${state.suggestedArtist}",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Suggested Album Art horizontally scrollable cards
                    Scrollbar(
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: List.generate(10, (index) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: Card(
                                  child: Center(
                                    child: Text(
                                      "Suggested Album Art ${index + 1}",
                                      textAlign: TextAlign.center,
                                      style:
                                      const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),

                    // Buttons for manual edit and refresh
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            // TODO: Open manual edit dialog or page
                          },
                          child: const Text("Tap to manually edit"),
                        ),
                        TextButton(
                          onPressed: () {
                            // Refresh suggestions by fetching tags again
                            bloc.add(FetchTagsForCurrentFile());
                          },
                          child: const Text("Refresh"),
                        ),
                      ],
                    ),

                    // Suggested tags list (mock for now)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 10, // You may want to link this to your state
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text("Suggested Tag ${index + 1}"),
                          subtitle: const Text("Album Art"),
                          onTap: () {
                            // TODO: Dispatch an event to update tag fields based on selected suggestion
                            // Example:
                            // bloc.add(UpdateTagField(title: "Title from suggestion"));
                          },
                        );
                      },
                    ),

                    const Divider(),

                    // Bottom action buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          child: const Text("Cancel"),
                          onPressed: () {
                            bloc.add(CancelTagging());
                            Navigator.pop(context);
                          },
                        ),

                        TextButton(
                          child: const Text("Skip"),
                          onPressed: () {
                            bloc.add(SkipCurrentFile());
                          },
                        ),

                        TextButton(
                          child: const Text("Save"),
                          onPressed: () {
                            bloc.add(SaveCurrentTag());
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
