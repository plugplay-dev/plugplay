import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:uuid/uuid.dart';

import '../models/playlist_model.dart';
import '../models/song_model.dart';
import 'firestore_service.dart';

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

  final StreamController<void> _songChangedController =
      StreamController<void>.broadcast();

  Stream<void> get songChangedStream => _songChangedController.stream;

  void _notifySongChanged() {
    _songChangedController.add(null);
  }

  final Uuid _uuid = const Uuid();

  List<Song> playlist = [];
  int currentIndex = 0;

  final List<Song> likedSongs = [];
  final List<Playlist> playlists = [];

  bool shuffleEnabled = false;
  bool repeatEnabled = false;

  Song? get currentSong {
    if (playlist.isEmpty) return null;
    return playlist[currentIndex];
  }

  bool get hasSong => currentSong != null;

  void setPlaylist(List<Song> songs, int startIndex) {
    playlist = songs;
    currentIndex = startIndex;
    _notifySongChanged();
  }

  void toggleShuffle() {
    shuffleEnabled = !shuffleEnabled;
  }

  void toggleRepeat() {
    repeatEnabled = !repeatEnabled;
  }

  bool isLiked(Song song) {
    return likedSongs.any((s) => s.audio == song.audio);
  }

  Future<void> loadLikedSongs() async {
    likedSongs
      ..clear()
      ..addAll(await FirestoreService.instance.loadLikedSongs());

    _notifySongChanged();
  }

  Future<void> loadPlaylists() async {
    playlists
      ..clear()
      ..addAll(await FirestoreService.instance.loadPlaylists());

    _notifySongChanged();
  }

  Future<void> toggleLike(Song song) async {
    if (isLiked(song)) {
      likedSongs.removeWhere((s) => s.audio == song.audio);
    } else {
      likedSongs.add(song);
    }

    await FirestoreService.instance.saveLikedSongs(likedSongs);

    _notifySongChanged();
  }

  Future<void> createPlaylist(String name) async {
    playlists.add(
      Playlist(
        id: _uuid.v4(),
        name: name,
      ),
    );

    await FirestoreService.instance.savePlaylists(playlists);

    _notifySongChanged();
  }

  Future<void> addSongToPlaylist(Playlist playlist, Song song) async {
    if (!playlist.songs.contains(song)) {
      playlist.songs.add(song);

      await FirestoreService.instance.savePlaylists(playlists);

      _notifySongChanged();
    }
  }

  Future<void> removeSongFromPlaylist(
    Playlist playlist,
    Song song,
  ) async {
    playlist.songs.remove(song);

    await FirestoreService.instance.savePlaylists(playlists);

    _notifySongChanged();
  }

  Future<void> play(String path) async {
    await player.stop();
    await player.play(AssetSource(path));
    _notifySongChanged();
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