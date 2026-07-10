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

  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    music.play(widget.song.audio);

    music.positionStream.listen((p) {
      setState(() => position = p);
    });

    music.durationStream.listen((d) {
      setState(() => duration = d);
    });

    music.stateStream.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
  }

  String format(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');

    final minutes = two(d.inMinutes.remainder(60));
    final seconds = two(d.inSeconds.remainder(60));

    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    music.stop();
    super.dispose();
  }

  @override
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
                "assets/${widget.song.cover}",
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 30),

            Text(
              widget.song.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              widget.song.artist,
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
              max: duration.inSeconds.toDouble() == 0
                  ? 1
                  : duration.inSeconds.toDouble(),
              value: position.inSeconds
                  .clamp(0, duration.inSeconds)
                  .toDouble(),
              onChanged: (value) {
                music.seek(Duration(seconds: value.toInt()));
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

                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.skip_previous,
                    color: Colors.white,
                    size: 45,
                  ),
                ),

                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.amber,

                  child: IconButton(
                    iconSize: 40,

                    onPressed: () {

                      if (isPlaying) {
                        music.pause();
                      } else {
                        music.resume();
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

                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.skip_next,
                    color: Colors.white,
                    size: 45,
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