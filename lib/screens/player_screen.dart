import 'dart:async';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

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

  String format(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');

    return "${two(d.inMinutes.remainder(60))}:${two(d.inSeconds.remainder(60))}";
  }

  @override
  void dispose() {
    _positionSubscription.cancel();
    _durationSubscription.cancel();
    _stateSubscription.cancel();

    super.dispose();
  }  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Now Playing"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const SizedBox(height: 20),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/${song.cover}",
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 30),

            Text(
              song.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              song.artist,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 40),

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
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  format(duration),
                  style: const TextStyle(color: Colors.white),
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
                    Icons.shuffle,
                    color: music.shuffleEnabled
                        ? Colors.amber
                        : Colors.white,
                    size: 32,
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
                    Icons.skip_previous,
                    color: Colors.white,
                    size: 42,
                  ),
                ),

                // Play / Pause
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.amber,
                  child: IconButton(
                    iconSize: 40,
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
                      color: Colors.black,
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
                    Icons.skip_next,
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
                    Icons.repeat,
                    color: music.repeatEnabled
                        ? Colors.amber
                        : Colors.white,
                    size: 32,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}