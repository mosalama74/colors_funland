import 'package:just_audio/just_audio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/sound_config.dart';

class BackgroundAudio {
  static final Map<String, AudioPlayer> _players = {}; // ✅ Manage multiple sounds
  static bool _isPaused = false; // ✅ Track paused state
  static bool _isListening = false; // ✅ Prevent multiple Firestore reads
  static Function? updateUIState;

  static Stream<List<SoundConfig>> _getSoundConfigs() {
    return FirebaseFirestore.instance
        .collection('sounds')
        .where('isEnabled', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return SoundConfig.fromMap({...doc.data(), 'id': doc.id});
      }).toList();
    });
  }

  // ✅ Listen for Firestore updates only once per session
  static void listenForSoundUpdates() {
    if (_isListening) return; // ✅ Prevent duplicate listeners
    _isListening = true;
    
    _getSoundConfigs().listen((sounds) async {
      if (_isPaused) return; // ✅ Respect paused state

      for (final sound in sounds) {
        await _updateOrInitializeSound(sound);
      }

      _players.keys
          .where((id) => !sounds.any((sound) => sound.id == id))
          .toList()
          .forEach((id) async {
        await _players[id]?.stop();
        await _players[id]?.dispose();
        _players.remove(id);
      });
      
      updateUIState?.call(); // ✅ Update UI elements dynamically
    });
  }

  static Future<void> _updateOrInitializeSound(SoundConfig sound) async {
    try {
      if (_players.containsKey(sound.id)) {
        await _updateSoundPlayback(sound);
      } else {
        await _initializeSound(sound);
      }
    } catch (e) {
      print("Error handling sound: ${sound.name}, Error: $e");
    }
  }

  static Future<void> _initializeSound(SoundConfig sound) async {
    final player = AudioPlayer();
    try {
      await player.setUrl(sound.url);
      await player.setVolume(sound.volume);
      await player.setLoopMode(sound.isLooping ? LoopMode.all : LoopMode.off);
      _players[sound.id] = player;

      if (sound.isEnabled && !_isPaused) {
        await player.play();
      }
    } catch (e) {
      print("Error initializing sound: ${sound.name}, Error: $e");
      await player.dispose();
    }
  }

  static Future<void> _updateSoundPlayback(SoundConfig sound) async {
    final player = _players[sound.id]!;
    try {
      await player.setVolume(sound.volume);
      await player.setLoopMode(sound.isLooping ? LoopMode.all : LoopMode.off);
      if (sound.isEnabled && !_isPaused) {
        if (!player.playing) {
          await player.play();
        }
      } else {
        await player.stop();
        await player.dispose();
        _players.remove(sound.id);
      }
    } catch (e) {
      print("Error updating sound: ${sound.name}, Error: $e");
    }
  }

  static Future<void> stopAllSounds() async {
    for (final player in _players.values) {
      await player.stop();
    }
    _players.clear();
  }
  
  static Future<void> pauseAllSounds() async {
    _isPaused = true;
    for (final player in _players.values) {
      await player.pause();
    }
    updateUIState?.call();
  }

  static Future<void> resumeAllSounds() async {
    _isPaused = false;
    for (final player in _players.values) {
      await player.play();
    }
    updateUIState?.call();
  }

  static bool isPlaying() {
    return _players.isNotEmpty && !_isPaused;
  }
  
  // Add a playOneTimeSound method that uses just_audio
  static Future<void> playOneTimeSound(String url, {double volume = 1.0}) async {
    final player = AudioPlayer();
    try {
      await player.setUrl(url);
      await player.setVolume(volume);
      await player.setLoopMode(LoopMode.off);
      await player.play();
      
      // Clean up player after it finishes playing
      player.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          player.dispose();
        }
      });
    } catch (e) {
      print("Error playing one-time sound: $e");
      await player.dispose();
    }
  }
}