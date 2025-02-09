import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/firebase_auth_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthService _authService;

  AuthRepositoryImpl(this._authService);

  @override
  Future<Either<Exception, UserCredential>> signIn(String email, String password) async {
    try {
      final result = await _authService.signIn(
        email: email,
        password: password,
      );
      return Right(result);
    } catch (e) {
      return Left(e as Exception);
    }
  }

  @override
  Future<Either<Exception, UserCredential>> signUp(String email, String password) async {
    try {
      final result = await _authService.signUp(
        email: email,
        password: password,
      );
      return Right(result);
    } catch (e) {
      return Left(e as Exception);
    }
  }

  @override
  Future<Either<Exception, void>> signOut() async {
    try {
      await _authService.signOut();
      return const Right(null);
    } catch (e) {
      return Left(e as Exception);
    }
  }

  Stream<User?> get authStateChanges => _authService.authStateChanges();
}
