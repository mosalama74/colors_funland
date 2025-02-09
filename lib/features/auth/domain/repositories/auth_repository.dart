import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<Either<Exception, UserCredential>> signIn(String email, String password);
  Future<Either<Exception, UserCredential>> signUp(String email, String password);
  Future<Either<Exception, void>> signOut();
  Stream<User?> get authStateChanges;
}
