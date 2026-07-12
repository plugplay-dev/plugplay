import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../services/music_service.dart';
class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  final MusicService music = MusicService.instance;

  @override
  Widget build(BuildContext context) {
    if (!music.hasSong) {
      return const SizedBox.shrink();
    }

    final song = music.currentSong!;

    return Container(
      height: 75,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              "assets/${song.cover}",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  song.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  song.artist,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),          IconButton(
            onPressed: () async {
              if (music.player.state == PlayerState.playing) {
                await music.pause();
              } else {
                await music.resume();
              }

              if (mounted) {
                setState(() {});
              }
            },
            icon: Icon(
              music.player.state == PlayerState.playing
                  ? Icons.pause
                  : Icons.play_arrow,
              color: Colors.amber,
            ),
          ),

          IconButton(
            onPressed: () async {
              await music.nextSong();

              if (mounted) {
                setState(() {});
              }
            },
            icon: const Icon(
              Icons.skip_next,
              color: Colors.amber,
            ),
          ),
        ],
      ),
    );
  }
}