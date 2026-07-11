import '../models/song_model.dart';

class PlaylistService {
  static final PlaylistService instance = PlaylistService._internal();

  factory PlaylistService() => instance;

  PlaylistService._internal();

  final List<Song> _playlist = demoSongs;

  int _currentIndex = 0;

  Song get currentSong => _playlist[_currentIndex];

  List<Song> get playlist => _playlist;

  int get currentIndex => _currentIndex;

  void setSong(Song song) {
    _currentIndex = _playlist.indexOf(song);

    if (_currentIndex < 0) {
      _currentIndex = 0;
    }
  }

  Song nextSong() {
    if (_currentIndex < _playlist.length - 1) {
      _currentIndex++;
    }

    return currentSong;
  }

  Song previousSong() {
    if (_currentIndex > 0) {
      _currentIndex--;
    }

    return currentSong;
  }
}