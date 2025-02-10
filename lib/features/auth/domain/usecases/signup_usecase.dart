import 'package:color_funland/core/error/failures.dart';
import 'package:color_funland/features/auth/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';
import '../entities/user.dart' as entities;

class SignUpParams {
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String password;

  SignUpParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.password,
  });
}

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<Either<Failure, entities.User>> call({
    required String firstName,
    required String lastName,
    required String email,
    required String username,
    required String password,
  }) async {
    final result = await repository.signUp(
      firstName: firstName,
      lastName: lastName,
      email: email,
      username: username,
      password: password,
    );
    
    return result.fold(
      (exception) => Left(FirebaseAuthFailure(
        code: 'signup-failed',
        message: exception.toString(),
      )),
      (userCredential) => Right(entities.User(
        uid: userCredential.uid,
        email: email,
        firstName: firstName,
        lastName: lastName,
        username: username,
        createdAt: DateTime.now(),
      )),
    );
  }
}