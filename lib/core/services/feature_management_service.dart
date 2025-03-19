import 'package:cloud_firestore/cloud_firestore.dart';

class FeatureManagementService {
  final FirebaseFirestore _firestore;
  final List<String> _features = ['my_painting', 'color_mixing', 'color_match', 'learning_colors'];

  FeatureManagementService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<bool> isFeatureEnabled(String featureName) async {
    try {
      final doc = await _firestore.collection('features').doc(featureName).get();
      return doc.data()?['isEnabled'] ?? false;
    } catch (e) {
      print('Error checking feature status: $e');
      return false;
    }
  }

  Stream<bool> getFeatureStatus(String featureName) {
    return _firestore
        .collection('features')
        .doc(featureName)
        .snapshots()
        .map((doc) => doc.data()?['isEnabled'] ?? false);
  }

  Stream<List<bool>> getAllFeatureStatuses() {
    return _firestore
        .collection('features')
        .where(FieldPath.documentId, whereIn: _features)
        .snapshots()
        .map((QuerySnapshot snapshot) {
          final Map<String, bool> statusMap = {};
          
          for (final doc in snapshot.docs) {
            final data = doc.data() as Map<String, dynamic>;
            statusMap[doc.id] = data['isEnabled'] as bool? ?? false;
          }
          
          return _features.map((f) => statusMap[f] ?? false).toList();
        });
  }
}
