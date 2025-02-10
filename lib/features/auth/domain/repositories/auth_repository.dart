import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<Either<Exception, UserCredential>> signIn(String email, String password);
  Future<Either<Exception, UserCredential>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String username,
  });
  Future<Either<Exception, void>> signOut();
  Stream<User?> get authStateChanges;
}
