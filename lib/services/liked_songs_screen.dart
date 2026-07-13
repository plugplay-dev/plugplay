import 'package:flutter/material.dart';

import '../services/music_service.dart';
import '../widgets/song_tile.dart';

class LikedSongsScreen extends StatelessWidget {
  LikedSongsScreen({super.key});

  final MusicService music = MusicService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff090909),

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("❤️ Liked Songs"),
      ),

      body: music.likedSongs.isEmpty
          ? const Center(
              child: Text(
                "No liked songs yet",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: music.likedSongs.length,
              itemBuilder: (context, index) {
                return SongTile(
                  song: music.likedSongs[index],
                  playlist: music.likedSongs,
                  index: index,
                );
              },
            ),
    );
  }
}