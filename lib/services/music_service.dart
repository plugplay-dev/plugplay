import 'dart:math';

import 'package:audioplayers/audioplayers.dart';

import '../models/song_model.dart';

class MusicService {
  static final MusicService instance = MusicService._internal();

  factory MusicService() => instance;

  MusicService._internal() {
    player.onPlayerComplete.listen((_) {
      if (repeatEnabled) {
        playCurrentSong();
      } else {
        nextSong();
      }
    });
  }

  final AudioPlayer player = AudioPlayer();

  List<Song> playlist = [];
  int currentIndex = 0;

  bool shuffleEnabled = false;
  bool repeatEnabled = false;

  Song? get currentSong {
    if (playlist.isEmpty) return null;
    return playlist[currentIndex];
  }

  // NEW
  bool get hasSong => currentSong != null;

  void setPlaylist(List<Song> songs, int startIndex) {
    playlist = songs;
    currentIndex = startIndex;
  }

  void toggleShuffle() {
    shuffleEnabled = !shuffleEnabled;
  }

  void toggleRepeat() {
    repeatEnabled = !repeatEnabled;
  }

  Future<void> play(String path) async {
    await player.stop();
    await player.play(AssetSource(path));
  }

  Future<void> playCurrentSong() async {
    if (currentSong == null) return;

    await play(currentSong!.audio);
  }

  Future<void> nextSong() async {
    if (playlist.isEmpty) return;

    if (shuffleEnabled) {
      final random = Random();
      currentIndex = random.nextInt(playlist.length);
    } else {
      if (currentIndex < playlist.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }
    }

    await playCurrentSong();
  }

  Future<void> previousSong() async {
    if (playlist.isEmpty) return;

    if (shuffleEnabled) {
      final random = Random();
      currentIndex = random.nextInt(playlist.length);
    } else {
      if (currentIndex > 0) {
        currentIndex--;
      } else {
        currentIndex = playlist.length - 1;
      }
    }

    await playCurrentSong();
  }

  Future<void> pause() async {
    await player.pause();
  }

  Future<void> resume() async {
    await player.resume();
  }

  Future<void> stop() async {
    await player.stop();
  }

  Future<void> seek(Duration position) async {
    await player.seek(position);
  }

  Stream<Duration> get positionStream => player.onPositionChanged;

  Stream<Duration> get durationStream => player.onDurationChanged;

  Stream<PlayerState> get stateStream => player.onPlayerStateChanged;
}