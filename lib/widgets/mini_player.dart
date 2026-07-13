import 'dart:async';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../services/music_service.dart';
import '../screens/player_screen.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  final MusicService music = MusicService.instance;

  late StreamSubscription _songSubscription;
  late StreamSubscription<PlayerState> _playerSubscription;

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    _songSubscription = music.songChangedStream.listen((_) {
      if (mounted) {
        setState(() {});
      }
    });

    _playerSubscription = music.stateStream.listen((state) {
      if (mounted) {
        setState(() {
          isPlaying = state == PlayerState.playing;
        });
      }
    });
  }

  @override
  void dispose() {
    _songSubscription.cancel();
    _playerSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!music.hasSong) {
      return const SizedBox.shrink();
    }

    final song = music.currentSong!;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PlayerScreen(song: song),
          ),
        );
      },
      child: Container(
        height: 72,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(12),
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

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    song.artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: () async {
                if (isPlaying) {
                  await music.pause();
                } else {
                  await music.resume();
                }
              },
              icon: Icon(
                isPlaying
                    ? Icons.pause
                    : Icons.play_arrow,
                color: Colors.amber,
              ),
            ),

            IconButton(
              onPressed: () async {
                await music.nextSong();
              },
              icon: const Icon(
                Icons.skip_next,
                color: Colors.amber,
              ),
            ),
          ],
        ),
      ),
    );
  }
}