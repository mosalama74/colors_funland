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

  const User({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    this.createdAt,
    this.childName,
    this.childImageUrl,
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
      ];
}
