import 'package:flutter/material.dart';

import '../models/song_model.dart';
import '../widgets/song_tile.dart';
import '../widgets/mini_player.dart';
import 'liked_songs_screen.dart';
import 'playlists_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchText = "";

  List<Song> get filteredSongs {
    if (searchText.isEmpty) {
      return demoSongs;
    }

    return demoSongs.where((song) {
      final query = searchText.toLowerCase();

      return song.title.toLowerCase().contains(query) ||
          song.artist.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff090909),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "PlugPlay",
          style: TextStyle(
            color: Colors.amber,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.library_music,
              color: Colors.amber,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PlaylistsScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LikedSongsScreen(),
                ),
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20),
            child: CircleAvatar(
              backgroundColor: Colors.amber,
              child: Icon(
                Icons.person,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Good Evening 👋",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Discover your next favorite song",
              style: TextStyle(
                color: Colors.white54,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 25),

            TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white10,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.amber,
                ),
                hintText: "Search music...",
                hintStyle: const TextStyle(
                  color: Colors.white54,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "🔥 My Songs",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredSongs.length,
              itemBuilder: (context, index) {
                return SongTile(
                  song: filteredSongs[index],
                  playlist: filteredSongs,
                  index: index,
                );
              },
            ),
                        const SizedBox(height: 30),

            const Text(
              "🎤 Top Artists",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.amber,
                  child: Text(
                    "A",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.amber,
                  child: Text(
                    "B",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.amber,
                  child: Text(
                    "C",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.amber,
                  child: Text(
                    "D",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),

      bottomNavigationBar: const MiniPlayer(),
    );
  }
}