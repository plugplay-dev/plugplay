import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  Widget libraryTile(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Card(
      color: Colors.white10,
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.amber,
          child: Icon(
            icon,
            color: Colors.black,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: Colors.white70,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white54,
          size: 18,
        ),
        onTap: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff090909),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Your Library",
          style: TextStyle(
            color: Colors.amber,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [

            const Text(
              "Music Collection",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Manage everything you love.",
              style: TextStyle(
                color: Colors.white54,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),

            libraryTile(
              Icons.favorite,
              "Liked Songs",
              "Your favourite tracks",
            ),

            libraryTile(
              Icons.history,
              "Recently Played",
              "Songs you've listened to",
            ),

            libraryTile(
              Icons.album,
              "Albums",
              "Browse your albums",
            ),

            libraryTile(
              Icons.person,
              "Artists",
              "Your favourite artists",
            ),

            libraryTile(
              Icons.queue_music,
              "Playlists",
              "Create and manage playlists",
            ),

            libraryTile(
              Icons.download,
              "Downloads",
              "Offline music",
            ),

            libraryTile(
              Icons.settings,
              "Settings",
              "Audio quality and preferences",
            ),
          ],
        ),
      ),
    );
  }
}