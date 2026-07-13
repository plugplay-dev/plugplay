import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../models/song_model.dart';
import '../services/music_service.dart';

class PlayerScreen extends StatefulWidget {
  final Song song;

  const PlayerScreen({
    super.key,
    required this.song,
  });

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final MusicService music = MusicService.instance;

  late StreamSubscription<Duration> _positionSubscription;
  late StreamSubscription<Duration> _durationSubscription;
  late StreamSubscription<PlayerState> _stateSubscription;

  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  bool isPlaying = false;

  Song get song => music.currentSong ?? widget.song;

  @override
  void initState() {
    super.initState();

    music.playCurrentSong();

    _positionSubscription = music.positionStream.listen((p) {
      if (!mounted) return;

      setState(() {
        position = p;
      });
    });

    _durationSubscription = music.durationStream.listen((d) {
      if (!mounted) return;

      setState(() {
        duration = d;
      });
    });

    _stateSubscription = music.stateStream.listen((state) {
      if (!mounted) return;

      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
  }

  @override
  void dispose() {
    _positionSubscription.cancel();
    _durationSubscription.cancel();
    _stateSubscription.cancel();
    super.dispose();
  }

  String format(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');

    return "${two(d.inMinutes.remainder(60))}:${two(d.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff090909),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "NOW PLAYING",
          style: TextStyle(
            letterSpacing: 2,
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 10,
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),

              Hero(
                tag: song.audio,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 25,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.asset(
                      "assets/${song.cover}",
                      width: 320,
                      height: 320,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 36),

              Text(
                song.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                song.artist,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 36),

              Slider(
                activeColor: Colors.amber,
                inactiveColor: Colors.white24,
                min: 0,
                max: duration.inSeconds == 0
                    ? 1
                    : duration.inSeconds.toDouble(),
                value: position.inSeconds
                    .clamp(0, duration.inSeconds)
                    .toDouble(),
                onChanged: (value) async {
                  await music.seek(
                    Duration(seconds: value.toInt()),
                  );
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    format(position),
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    format(duration),
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),

              const Spacer(),
                            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Shuffle
                  IconButton(
                    onPressed: () {
                      setState(() {
                        music.toggleShuffle();
                      });
                    },
                    icon: Icon(
                      Icons.shuffle_rounded,
                      color: music.shuffleEnabled
                          ? Colors.amber
                          : Colors.white70,
                      size: 30,
                    ),
                  ),

                  // Previous
                  IconButton(
                    onPressed: () async {
                      await music.previousSong();

                      if (mounted) {
                        setState(() {});
                      }
                    },
                    icon: const Icon(
                      Icons.skip_previous_rounded,
                      color: Colors.white,
                      size: 42,
                    ),
                  ),

                  // Play / Pause
                  Container(
                    width: 78,
                    height: 78,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 16,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: IconButton(
                      iconSize: 42,
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
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          key: ValueKey(isPlaying),
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  // Next
                  IconButton(
                    onPressed: () async {
                      await music.nextSong();

                      if (mounted) {
                        setState(() {});
                      }
                    },
                    icon: const Icon(
                      Icons.skip_next_rounded,
                      color: Colors.white,
                      size: 42,
                    ),
                  ),

                  // Repeat
                  IconButton(
                    onPressed: () {
                      setState(() {
                        music.toggleRepeat();
                      });
                    },
                    icon: Icon(
                      Icons.repeat_rounded,
                      color: music.repeatEnabled
                          ? Colors.amber
                          : Colors.white70,
                      size: 30,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}