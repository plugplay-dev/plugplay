import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioPlayer player = AudioPlayer();

  static Future<void> play(String path) async {
    await player.stop();
    await player.play(AssetSource(path));
  }

  static Future<void> pause() async {
    await player.pause();
  }

  static Future<void> resume() async {
    await player.resume();
  }

  static Future<void> stop() async {
    await player.stop();
  }
}