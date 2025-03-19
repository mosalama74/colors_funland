import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_audio/just_audio.dart';
import '../models/sound_config.dart';

class SoundManagementService {
  final FirebaseFirestore _firestore;
  final Map<String, AudioPlayer> _players = {};

  SoundManagementService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<SoundConfig>> getSoundConfigs() {
    return _firestore.collection('sounds').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => SoundConfig.fromMap({...doc.data(), 'id': doc.id}))
          .toList();
    });
  }

  Future<void> initializeSound(SoundConfig config) async {
    if (_players.containsKey(config.id)) {
      await _players[config.id]?.dispose();
      _players.remove(config.id);
    }

    if (!config.isEnabled) {
      return;
    }

    final player = AudioPlayer();
    try {
      await player.setUrl(config.url);
      await player.setVolume(config.volume);
      await player.setLoopMode(config.isLooping ? LoopMode.all : LoopMode.off);
      _players[config.id] = player;
      if (config.isEnabled) {
        await player.play();
      }
    } catch (e) {
      print('Error initializing sound ${config.name}: $e');
      await player.dispose();
    }
  }

  Future<void> updateSound(SoundConfig config) async {
    if (!_players.containsKey(config.id)) {
      if (config.isEnabled) {
        await initializeSound(config);
      }
      return;
    }

    final player = _players[config.id]!;
    try {
      await player.setVolume(config.volume);
      await player.setLoopMode(config.isLooping ? LoopMode.all : LoopMode.off);
      
      if (config.isEnabled) {
        if (!player.playing) {
          await player.play();
        }
      } else {
        await player.stop();
        await player.dispose();
        _players.remove(config.id);
      }
    } catch (e) {
      print('Error updating sound ${config.name}: $e');
    }
  }

  Future<void> dispose() async {
    for (final player in _players.values) {
      await player.dispose();
    }
    _players.clear();
  }
}


