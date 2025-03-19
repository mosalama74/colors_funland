class SoundConfig {
  final String id;
  final String name;
  final String url;
  final double volume;
  final bool isLooping;
  final bool isEnabled;

  SoundConfig({
    required this.id,
    required this.name,
    required this.url,
    required this.volume,
    required this.isLooping,
    required this.isEnabled,
  });

  factory SoundConfig.fromMap(Map<String, dynamic> map) {
    return SoundConfig(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      url: map['url'] ?? '',
      volume: map['volume']?.toDouble() ?? 1.0,
      isLooping: map['isLooping'] ?? false,
      isEnabled: map['isEnabled'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'volume': volume,
      'isLooping': isLooping,
      'isEnabled': isEnabled,
    };
  }
}