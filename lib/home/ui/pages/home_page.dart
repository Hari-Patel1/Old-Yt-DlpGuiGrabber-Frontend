import "dart:io";

import "package:easy_folder_picker/FolderPicker.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:smooth_page_indicator/smooth_page_indicator.dart";
import "package:yt_dlp_gui_grabber/home/logic/pages/home_bloc.dart";
import "package:yt_dlp_gui_grabber/home/ui/elements/settings_dialog_element.dart";
import "../../logic/elements/settings_bloc.dart";
import "../elements/edit_dialog_element.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  final int _numPages = 2;
  final TextEditingController _textEditingController = TextEditingController();
  String? currentDirectory;

  @override
  void dispose() {
    _pageController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 25.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "Welcome",
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton.outlined(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => const EditSettingsDialog(),
                      );
                    },
                    icon: const Icon(Icons.settings_outlined),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              const Divider(),
              const SizedBox(height: 15.0),

              // PAGEVIEW + Indicator + Logs
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 475,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: _numPages,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return _buildDownloadCard(context);
                          } else {
                            return _buildTagCard();
                          }
                        },
                      ),
                    ),

                    const SizedBox(height: 5),

                    SmoothPageIndicator(
                      controller: _pageController,
                      count: _numPages,
                      effect: const ExpandingDotsEffect(
                        dotWidth: 15,
                        dotHeight: 15,
                        spacing: 7,
                        dotColor: Colors.grey,
                        activeDotColor: Colors.green,
                        expansionFactor: 2,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // LOG OUTPUT BOX
                    Expanded(
                      child: Scrollbar(
                        thumbVisibility: true,
                        thickness: 5.0,
                        radius: const Radius.circular(15.0),
                        interactive: true,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.grey.shade800),
                          ),
                          child: BlocBuilder<HomeBloc, HomeState>(
                            builder: (context, state) {
                              return SingleChildScrollView(
                                reverse: true,
                                child: Text(
                                  state.logOutput,
                                  style: const TextStyle(
                                    color: Colors.greenAccent,
                                    fontFamily: 'Courier',
                                    fontSize: 13,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDownloadCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ).copyWith(bottom: 8.0),
      child: Card(
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (previous, current) => previous.url != current.url,
              builder: (context, state) {
                // update text editing controller if url changes
                if (_textEditingController.text != (state.url)) {
                  _textEditingController.text = state.url;
                  _textEditingController.selection = TextSelection.collapsed(
                    offset: _textEditingController.text.length,
                  );
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Download from a link",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Edit your downloads' preferences with the pencil icon",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),

                    TextFormField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Enter link",
                        hintText: "Enter a valid link",
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => const EditPreferencesDialog(),
                            );
                          },
                        ),
                      ),
                      onChanged: (value) {
                        context.read<HomeBloc>().add(SetUrl(value));
                      },
                    ),

                    const SizedBox(height: 10),

                    TextButton(
                      onPressed: () {
                        context.read<HomeBloc>().add(FetchUrlFromClipboard());
                      },
                      child: const Text("Get link from clipboard"),
                    ),

                    const SizedBox(height: 5),

                    FilledButton.icon(
                      style: FilledButton.styleFrom(
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                      onPressed: () {
                        context.read<HomeBloc>().add(
                          DownloadSubmitted(state.url),
                        );
                      },
                      label: const Text("Download"),
                      icon: const Icon(Icons.download_outlined),
                    ),

                    const SizedBox(height: 10),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTagCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ).copyWith(bottom: 8.0),
      child: Card(
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Tag an existing download",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    "Add a tag to an existing download (Audio only)",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 15),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.0),
                  child: Text(
                    "To begin a tag, select a target directory",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12.5),
                  ),
                ),

                SizedBox(height: 15),

                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                  ),
                  onPressed: () async {
                    final rootDir =
                        context.read<SettingsBloc>().state.downloadDirectory ??
                        Directory("/storage/emulated/0/Download");

                    final newDir = await FolderPicker.pick(
                      context: context,
                      rootDirectory: rootDir,
                      allowFolderCreation: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    );

                    if (newDir != null) {
                      context.read<SettingsBloc>().add(
                        SetDownloadDirectory(newDir),
                      );
                      context.read<HomeBloc>().add(
                        LogAppended("[!] Selecting new directory.\n"),
                      );
                      context.read<HomeBloc>().add(
                        LogAppended("[*] Selected directory: ${newDir.path}\n"),
                      );
                    }
                  },

                  label: const Text("Select Directory"),
                  icon: const Icon(Icons.snippet_folder_outlined),
                ),
                SizedBox(height: 15),
                BlocBuilder<SettingsBloc, SettingsState>(
                  builder: (context, state) {
                    final dirPath =
                        state.downloadDirectory?.path ?? "Not selected";
                    return Text(
                      "Current directory: $dirPath",
                      style: TextStyle(fontSize: 14),
                    );
                  },
                ),
                SizedBox(height: 15),

                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                  ),
                  onPressed: () {},
                  label: const Text("Start Tagging"),
                  icon: const Icon(Icons.queue_music_outlined),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
