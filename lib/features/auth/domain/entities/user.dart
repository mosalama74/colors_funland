import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final DateTime? createdAt;
  final String? childName;
  final String? childImageUrl;
  final bool isAdmin;
  final int? paintingGameCounter;
  final int? paintingLevelCounter;
  final int? colorMixingGameCounter;
  final int? colorMixingLevelCounter;
  final int? colorMatchGameCounter;
  final int? colorMatchLevelCounter;
  final int? learningColorsGameCounter;
  final int? learningColorsLevelCounter;

  const User({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    this.createdAt,
    this.childName,
    this.childImageUrl,
    this.isAdmin = false,
    this.paintingGameCounter,
    this.paintingLevelCounter,
    this.colorMixingGameCounter,
    this.colorMixingLevelCounter,
    this.colorMatchGameCounter,
    this.colorMatchLevelCounter,
    this.learningColorsGameCounter,
    this.learningColorsLevelCounter,
  });

  @override
  List<Object?> get props => [
        uid,
        firstName,
        lastName,
        email,
        username,
        createdAt,
        childName,
        childImageUrl,
        isAdmin,
      ];
}
