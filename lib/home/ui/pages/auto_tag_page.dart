import 'package:flutter/material.dart';

class AutoTagPage extends StatelessWidget {
  const AutoTagPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Auto Tag page")),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Divider(),
                ),
                //first top part of the page is the album art currently
                //should fill the space of the screen
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: double.infinity,
                    child: Card(
                      child: Text("Album Art currently of target file"),
                    ),
                  ),
                ),

                SizedBox(height: 10),
                //next is the most fitting tag (album art and song tag for that file)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: SizedBox(
                    height: 75,
                    width: double.infinity,
                    child: Card(
                      child: Text("Most Fitting Tag currently as it stands"),
                    ),
                  ),
                ),

                SizedBox(height: 10),

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
                              //on tap this should populate the album art of the users song with the album art on the card
                              child: Center(
                                child: Text(
                                  "suggested Album Art ${index + 1}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        //on tap this should show the user the fields they can manually edit. these fields can also be used to search for the most fitting tag if thee user clicks refresh
                      },
                      child: const Text("Tap to manually edit"),
                    ),
                    TextButton(
                      onPressed: () {
                        //on tap this should refresh the most fitting tag by searching again with the manually edited information
                      },
                      child: const Text("Refresh"),
                    ),
                  ],
                ),

                //list of tags for the song name and artist and etc infomration
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:
                      10, // Change this to match the number of tag suggestions
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("Suggested Tag ${index + 1}"),
                      subtitle: const Text(
                        "Album Art",
                      ), // Or tag source / summary
                      onTap: () {
                        // TODO: Update only the text fields (title, artist, album, etc.)
                        // DO NOT modify album art
                        // Example (if using controllers or BLoC):
                        // context.read<TagBloc>().add(ApplyTagEvent(index));
                      },
                    );
                  },
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Divider(),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      child: const Text("Cancel"),
                      onPressed: () {
                        // on tap this should cancel the current song and go back to the previous page
                      },
                    ),

                    TextButton(
                      child: const Text("Skip"),
                      onPressed: () {
                        // on tap this should skip the current song and go to the next song to be tagged
                      },
                    ),

                    TextButton(
                      child: const Text("Save"),
                      onPressed: () {
                        // on tap this should save the current information and go to the next song to be tagged
                      },
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
