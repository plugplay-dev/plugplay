import 'package:flutter/material.dart';

import '../models/song_model.dart';
import '../services/music_service.dart';
import '../screens/player_screen.dart';

class SongTile extends StatelessWidget {
  final Song song;
  final List<Song> playlist;
  final int index;

  const SongTile({
    super.key,
    required this.song,
    required this.playlist,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white10,
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            "assets/${song.cover}",
            width: 55,
            height: 55,
            fit: BoxFit.cover,
          ),
        ),

        title: Text(
          song.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(
          song.artist,
          style: const TextStyle(
            color: Colors.white70,
          ),
        ),

        trailing: const Icon(
          Icons.play_circle_fill,
          color: Colors.amber,
          size: 35,
        ),

        onTap: () {
          MusicService.instance.setPlaylist(
            playlist,
            index,
          );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PlayerScreen(song: song),
            ),
          );
        },
      ),
    );
  }
}