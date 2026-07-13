import 'package:flutter/material.dart';

import '../models/song_model.dart';
import '../services/music_service.dart';
import '../screens/player_screen.dart';

class SongTile extends StatefulWidget {
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
  State<SongTile> createState() => _SongTileState();
}

class _SongTileState extends State<SongTile> {
  final MusicService music = MusicService.instance;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white10,
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            "assets/${widget.song.cover}",
            width: 55,
            height: 55,
            fit: BoxFit.cover,
          ),
        ),

        title: Text(
          widget.song.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(
          widget.song.artist,
          style: const TextStyle(
            color: Colors.white70,
          ),
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            IconButton(
              onPressed: () {
                setState(() {
                  music.toggleLike(widget.song);
                });
              },
              icon: Icon(
                music.isLiked(widget.song)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.red,
              ),
            ),

            const Icon(
              Icons.play_circle_fill,
              color: Colors.amber,
              size: 35,
            ),
          ],
        ),

        onTap: () {
          music.setPlaylist(
            widget.playlist,
            widget.index,
          );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PlayerScreen(song: widget.song),
            ),
          );
        },
      ),
    );
  }
}