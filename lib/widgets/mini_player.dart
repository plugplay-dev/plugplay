import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../screens/player_screen.dart';
import '../services/music_service.dart';

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
      if (mounted) setState(() {});
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

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PlayerScreen(song: song),
                ),
              );
            },
            child: Ink(
              height: 82,
              decoration: BoxDecoration(
                color: const Color(0xff181818),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white10,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 16,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 12),

                  Hero(
                    tag: song.audio,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset(
                        "assets/${song.cover}",
                        width: 58,
                        height: 58,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

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
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          song.artist,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 13,
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
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        isPlaying
                            ? Icons.pause_circle_filled_rounded
                            : Icons.play_circle_fill_rounded,
                        key: ValueKey(isPlaying),
                        color: Colors.amber,
                        size: 36,
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: () async {
                      await music.nextSong();
                    },
                    icon: const Icon(
                      Icons.skip_next_rounded,
                      color: Colors.amber,
                      size: 32,
                    ),
                  ),

                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}