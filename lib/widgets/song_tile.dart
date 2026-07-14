import 'package:flutter/material.dart';

import '../models/song_model.dart';
import '../screens/player_screen.dart';
import '../services/music_service.dart';

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
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xff171717),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white10,
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
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
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  "assets/${widget.song.cover}",
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.song.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      widget.song.artist,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              IconButton(
                onPressed: () {
                  setState(() {
                    music.toggleLike(widget.song);
                  });
                },
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    music.isLiked(widget.song)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    key: ValueKey(
                      music.isLiked(widget.song),
                    ),
                    color: Colors.redAccent,
                  ),
                ),
              ),

              const Icon(
                Icons.play_circle_fill_rounded,
                color: Colors.amber,
                size: 38,
              ),
            ],
          ),
        ),
      ),
    );
  }
}