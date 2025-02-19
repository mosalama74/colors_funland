import 'package:equatable/equatable.dart';

enum ProfileInfoStatus { initial, loading, success, failure }

class ProfileInfoState extends Equatable {
  final String? imageUrl;
  final String? localImagePath;
  final ProfileInfoStatus status;
  final String? errorMessage;
  final List<Map<String, dynamic>>? children;

  const ProfileInfoState({
    this.imageUrl,
    this.localImagePath,
    this.status = ProfileInfoStatus.initial,
    this.errorMessage,
    this.children = const [],
  });

  ProfileInfoState copyWith({
    String? imageUrl,
    String? localImagePath,
    ProfileInfoStatus? status,
    String? errorMessage,
    List<Map<String, dynamic>>? children,
  }) {
    return ProfileInfoState(
      imageUrl: imageUrl ?? this.imageUrl,
      localImagePath: localImagePath ?? this.localImagePath,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      children: children ?? this.children,
    );
  }

  @override
  List<Object?> get props => [imageUrl, localImagePath, status, errorMessage,children];
}
