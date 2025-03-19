import 'package:firebase_storage/firebase_storage.dart';
import 'package:color_funland/core/components/background_sound.dart';

class SuccessSound {
  static final Map<String, String> _cachedUrls = {}; // Cache for multiple sounds
  static bool _isLoading = false;

  // Fetch and play the success sound
  static Future<void> playAfterLogin({String fileName = 'success.mp3'}) async {
    if (_isLoading) return;
    
    try {
      _isLoading = true;
      
      // Use cached URL if available
      if (_cachedUrls.containsKey(fileName)) {
        await BackgroundAudio.playOneTimeSound(_cachedUrls[fileName]!);
        _isLoading = false;
        return;
      }
      
      // Get the URL from Firebase Storage
      final storageRef = FirebaseStorage.instance.ref('sounds/$fileName');
      try {
        // Get the URL from Firebase Storage
        final url = await storageRef.getDownloadURL();
        
        // Cache the URL for future use
        _cachedUrls[fileName] = url;
        
        // Play the sound
        await BackgroundAudio.playOneTimeSound(url);
      } catch (e) {
        print("Firebase Storage error: $e");
        print("File 'sounds/$fileName' not found in Firebase Storage");
        // Silent fail if file not found
      }
    } catch (e) {
      print("Error playing sound: $e");
    } finally {
      _isLoading = false;
    }
  }
}