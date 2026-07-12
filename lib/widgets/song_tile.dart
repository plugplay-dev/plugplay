import 'package:flutter/material.dart';

import '../models/song_model.dart';

class SongTile extends StatelessWidget {
  final Song song;
  final VoidCallback onTap;
  final VoidCallback? onLike;
  final bool isLiked;

  const SongTile({
    super.key,
    required this.song,
    required this.onTap,
    this.onLike,
    this.isLiked = false,
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

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            IconButton(
              onPressed: onLike,
              icon: Icon(
                isLiked
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

        onTap: onTap,
      ),
    );
  }
}