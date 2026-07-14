import 'package:flutter/material.dart';

import '../models/song_model.dart';
import '../services/auth_service.dart';
import '../widgets/song_tile.dart';
import '../widgets/mini_player.dart';
import 'liked_songs_screen.dart';
import 'login_screen.dart';
import 'playlists_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchText = "";

  List<Song> get filteredSongs {
    if (searchText.isEmpty) return demoSongs;

    final query = searchText.toLowerCase();

    return demoSongs.where((song) {
      return song.title.toLowerCase().contains(query) ||
          song.artist.toLowerCase().contains(query);
    }).toList();
  }

  Future<void> logout() async {
    await AuthService.instance.signOut();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
      (route) => false,
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
          "PlugPlay",
          style: TextStyle(
            color: Colors.amber,
            fontWeight: FontWeight.bold,
            fontSize: 30,
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
              color: Colors.redAccent,
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
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: logout,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.amber,
              child: Icon(
                Icons.person,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome Back 👋",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Find Your Perfect Sound",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xff1B1B1B),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.amber,
                  ),
                  hintText: "Search songs or artists...",
                  hintStyle: const TextStyle(
                    color: Colors.white54,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                "My Songs",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 18),
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
              const SizedBox(height: 32),
              const Text(
                "Top Artists",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  _ArtistAvatar(label: "A"),
                  _ArtistAvatar(label: "B"),
                  _ArtistAvatar(label: "C"),
                  _ArtistAvatar(label: "D"),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MiniPlayer(),
    );
  }
}

class _ArtistAvatar extends StatelessWidget {
  final String label;

  const _ArtistAvatar({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.amber,
            boxShadow: [
              BoxShadow(
                color: Colors.amberAccent.withOpacity(0.25),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Artist $label",
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}