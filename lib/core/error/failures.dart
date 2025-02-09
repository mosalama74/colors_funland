import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class FirebaseAuthFailure extends Failure {
  final String code;
  
  const FirebaseAuthFailure({
    required this.code,
    required String message,
  }) : super(message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class AuthFailure extends Failure {
  const AuthFailure(super.message);
}