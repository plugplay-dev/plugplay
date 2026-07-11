import '../models/song_model.dart';

class LikedSongsService {
  LikedSongsService._();

  static final LikedSongsService instance = LikedSongsService._();

  final List<Song> _likedSongs = [];

  List<Song> get likedSongs => List.unmodifiable(_likedSongs);

  bool isLiked(Song song) {
    return _likedSongs.contains(song);
  }

  void toggleLike(Song song) {
    if (isLiked(song)) {
      _likedSongs.remove(song);
    } else {
      _likedSongs.add(song);
    }
  }

  void clearLikes() {
    _likedSongs.clear();
  }
}