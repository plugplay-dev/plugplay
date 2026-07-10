import 'package:audioplayers/audioplayers.dart';

class MusicService {
  static final MusicService instance = MusicService._internal();

  factory MusicService() => instance;

  MusicService._internal();

  final AudioPlayer player = AudioPlayer();

  Future<void> play(String path) async {
    await player.stop();
    await player.play(AssetSource(path));
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