import 'package:equatable/equatable.dart';

enum ProfileInfoStatus { initial, loading, success, failure }

class ProfileInfoState extends Equatable {
  final String? imageUrl;
  final String? localImagePath;
  final ProfileInfoStatus status;
  final String? errorMessage;

  const ProfileInfoState({
    this.imageUrl,
    this.localImagePath,
    this.status = ProfileInfoStatus.initial,
    this.errorMessage,
  });

  ProfileInfoState copyWith({
    String? imageUrl,
    String? localImagePath,
    ProfileInfoStatus? status,
    String? errorMessage,
  }) {
    return ProfileInfoState(
      imageUrl: imageUrl ?? this.imageUrl,
      localImagePath: localImagePath ?? this.localImagePath,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [imageUrl, localImagePath, status, errorMessage];
}
