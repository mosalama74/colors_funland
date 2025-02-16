
// import 'package:dartz/dartz.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../../domain/repositories/auth_repository.dart';
// import '../datasources/firebase_auth_service.dart';
// import '../datasources/firebase_firestore_service.dart';

// class AuthRepositoryImpl implements AuthRepository {
//   final FirebaseAuthService _authService;
//   final FirebaseFirestoreService _firestoreService;

//   AuthRepositoryImpl(this._authService, this._firestoreService);

  

//   @override
//   Future<Either<Exception, UserCredential>> signIn(String email, String password) async {
//     try {
//       final result = await _authService.signIn(
//         email: email,
//         password: password,
//       );
//       return Right(result);
//     } catch (e) {
//       return Left(e as Exception);
//     }
//   }

//   @override
//   Future<Either<Exception, UserCredential>> signUp({
//     required String email,
//     required String password,
//     required String firstName,
//     required String lastName,
//     required String username,
//   }) async {
//     try {
//       final userCredential = await _authService.signUp(
//         email: email,
//         password: password,
//       );

//       // Save additional user data in Firestore
//       await _firestoreService.createUserData(
//         uid: userCredential.user!.uid,
//         email: email,
//         firstName: firstName,
//         lastName: lastName,
//         username: username,
//         createdAt: DateTime.now(),
//       );

//       return Right(userCredential);
//     } catch (e) {
//       return Left(e as Exception);
//     }
//   }

//   @override
//   Future<Either<Exception, void>> signOut() async {
//     try {
//       await _authService.signOut();
//       return const Right(null);
//     } catch (e) {
//       return Left(e as Exception);
//     }
//   }


// }
