import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_audio/just_audio.dart';

class ActiveSoundPlayer {
  final FirebaseFirestore _firestore;
  final AudioPlayer _audioPlayer;

  ActiveSoundPlayer({
    FirebaseFirestore? firestore,
    AudioPlayer? audioPlayer,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _audioPlayer = audioPlayer ?? AudioPlayer();

   Future<void> playActiveSound() async {
    try {
      // Fetch the active sound document from Firestore
      final snapshot = await _firestore
          .collection('sounds')
          .where('isActive', isEqualTo: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final soundData = snapshot.docs.first.data();
        final url = soundData['url'] ?? '';

        if (url.isNotEmpty) {
          await _audioPlayer.setUrl(url);
          _audioPlayer.play();
        } else {
          print('No valid URL found for the active sound.');
        }
      } else {
        print('No active sound found in Firestore.');
      }
    } catch (e) {
      print('Error playing active sound: $e');
    }
  }

  Future<void> stopSound() async {
    try {
      await _audioPlayer.stop();
    } catch (e) {
      print('Error stopping sound: $e');
    }
  }

  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}
