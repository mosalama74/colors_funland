import 'package:equatable/equatable.dart';

class FeatureConfig extends Equatable {
  final String id;
  final String name;
  final bool isEnabled;
  final Map<String, dynamic> settings;

  const FeatureConfig({
    required this.id,
    required this.name,
    required this.isEnabled,
    required this.settings,
  });

  FeatureConfig copyWith({
    String? id,
    String? name,
    bool? isEnabled,
    Map<String, dynamic>? settings,
  }) {
    return FeatureConfig(
      id: id ?? this.id,
      name: name ?? this.name,
      isEnabled: isEnabled ?? this.isEnabled,
      settings: settings ?? this.settings,
    );
  }

  factory FeatureConfig.initial(String name) {
    return FeatureConfig(
      id: name.toLowerCase().replaceAll(' ', '_'),
      name: name,
      isEnabled: true,
      settings: {},
    );
  }

  @override
  List<Object?> get props => [id, name, isEnabled, settings];
}
