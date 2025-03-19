import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/feature_config.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  final FirebaseFirestore _firestore;

  AdminCubit({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        super(AdminInitial()) {
    _initializeFeatures();
  }

  void _initializeFeatures() {
    final features = [
      FeatureConfig.initial('Painting'),
      FeatureConfig.initial('Color Mixing'),
      FeatureConfig.initial('Match Colors'),
      FeatureConfig.initial('Learning Colors'),
    ];
    emit(AdminLoaded(features: features));
  }

  Future<void> toggleFeature(String featureId) async {
    if (state is AdminLoaded) {
      final currentState = state as AdminLoaded;
      final updatedFeatures = currentState.features.map((feature) {
        if (feature.id == featureId) {
          return feature.copyWith(isEnabled: !feature.isEnabled);
        }
        return feature;
      }).toList();

      emit(AdminLoaded(features: updatedFeatures));

      try {
        await _firestore
            .collection('features')
            .doc(featureId)
            .set({'enabled': !currentState.features
                .firstWhere((f) => f.id == featureId)
                .isEnabled});
      } catch (e) {
        // Handle error
        emit(AdminError(message: 'Failed to update feature: $e'));
      }
    }
  }

  Future<void> updateFeatureSettings(
      String featureId, Map<String, dynamic> settings) async {
    if (state is AdminLoaded) {
      final currentState = state as AdminLoaded;
      final updatedFeatures = currentState.features.map((feature) {
        if (feature.id == featureId) {
          return feature.copyWith(settings: settings);
        }
        return feature;
      }).toList();

      emit(AdminLoaded(features: updatedFeatures));

      try {
        await _firestore
            .collection('features')
            .doc(featureId)
            .update({'settings': settings});
      } catch (e) {
        emit(AdminError(message: 'Failed to update settings: $e'));
      }
    }
  }
}
