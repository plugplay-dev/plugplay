import 'song_model.dart';

class Playlist {
  final String name;
  final List<Song> songs;

  Playlist({
    required this.name,
    List<Song>? songs,
  }) : songs = songs ?? [];
}