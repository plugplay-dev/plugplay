import 'package:flutter/material.dart';

import '../services/liked_songs_service.dart';
import '../widgets/song_tile.dart';
import 'player_screen.dart';

class LikedSongsScreen extends StatefulWidget {
  const LikedSongsScreen({super.key});

  @override
  State<LikedSongsScreen> createState() => _LikedSongsScreenState();
}

class _LikedSongsScreenState extends State<LikedSongsScreen> {
  @override
  Widget build(BuildContext context) {
    final likedSongs = LikedSongsService.instance.likedSongs;

    return Scaffold(
      backgroundColor: const Color(0xff090909),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Liked Songs",
          style: TextStyle(
            color: Colors.amber,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: likedSongs.isEmpty
          ? const Center(
              child: Text(
                "No liked songs yet ❤️",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: likedSongs.length,
              itemBuilder: (context, index) {
                final song = likedSongs[index];

                return SongTile(
                  song: song,
                  isLiked: true,
                  onLike: () {
                    setState(() {
                      LikedSongsService.instance.toggleLike(song);
                    });
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PlayerScreen(song: song),
                      ),
                    ).then((_) {
                      setState(() {});
                    });
                  },
                );
              },
            ),
    );
  }
}