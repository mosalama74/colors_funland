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

class DeleteAccountSuccess extends AuthState {
  final String message;

  const DeleteAccountSuccess({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

class DeleteAccountError extends AuthState {
  final String message;

  const DeleteAccountError({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

class ChangePasswordError extends AuthState {
  final String message;

  const ChangePasswordError({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

class ChangePasswordSuccess extends AuthState {
  final String message;

  const ChangePasswordSuccess({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

class AuthSignedOut extends AuthState {
  final String message;

  const AuthSignedOut({required this.message});

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

class EmailVerificationSuccess extends AuthState {
  final User user;

  const EmailVerificationSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthCheckingStatus extends AuthState {
  const AuthCheckingStatus();
}

class GetChildInfoSuccessState extends AuthState {
  final Map<String, dynamic> child;

  const GetChildInfoSuccessState({
    required this.child,
  });

  @override
  List<Object?> get props => [child];
}

class GetChildInfoErrorState extends AuthState {
  final String? errorMessage;

  const GetChildInfoErrorState({required this.errorMessage});
}
