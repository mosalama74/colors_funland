import 'package:color_funland/core/error/failures.dart';
import 'package:color_funland/features/auth/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';



class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<Either<Failure, Unit>> call({
    required String email,
    required String password,
  }) async {
    return await repository.signIn(
      email: email,
      password: password,
    );
  }
}