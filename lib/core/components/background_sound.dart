import 'package:audioplayers/audioplayers.dart';

class BackgroundAudio {
  static final AudioPlayer _player = AudioPlayer();
  static bool _isPlaying = false;

  static Future<void> playBackgroundMusic() async {
    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.play(AssetSource("sounds/background.mp3"));
    _isPlaying = true;
  }

  static Future<void> stopBackgroundMusic() async {
    await _player.stop();
    _isPlaying = false;
  }

  static Future<void> pauseBackgroundMusic() async {
    if (_isPlaying) {
      await _player.pause();
      _isPlaying = false;
    }
  }

  static Future<void> resumeBackgroundMusic() async {
    if (!_isPlaying) {
      await _player.resume();
      _isPlaying = true;
    }
  }

  static bool isPlaying() => _isPlaying;
}
