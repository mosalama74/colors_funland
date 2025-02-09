import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  final User user;
  final bool isEmailVerified;

  const AuthSuccess({
    required this.user,
    this.isEmailVerified = false,
  });

  @override
  List<Object?> get props => [user, isEmailVerified];
}

class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}

class EmailVerificationSent extends AuthState {
  final String email;
  
  const EmailVerificationSent({required this.email});

  @override
  List<Object?> get props => [email];
}

class EmailVerificationRequired extends AuthState {
  final String email;
  
  const EmailVerificationRequired({required this.email});

  @override
  List<Object?> get props => [email];
}

class AuthCheckingStatus extends AuthState {
  const AuthCheckingStatus();
}