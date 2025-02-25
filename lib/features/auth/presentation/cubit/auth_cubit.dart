import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:color_funland/features/auth/domain/entities/user.dart'
    as entities;
import 'package:color_funland/features/auth/domain/usecases/signin_usecase.dart';
import 'package:color_funland/features/auth/domain/usecases/signup_usecase.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_state.dart';
import 'package:color_funland/core/services/message_service.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final _auth = FirebaseAuth.instance;
  final MessageService messageService;

  AuthCubit({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.messageService,
  }) : super(AuthInitial());

  Future<void> sendEmailVerification() async {
    try {
      final user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        emit(EmailVerificationSent(email: user.email!));
      }
    } catch (e) {
      emit(AuthError(message: 'Failed to send verification email'));
    }
  }

  Future<void> checkEmailVerification() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        // Reload user to get latest verification status
        await user.reload();

        if (user.emailVerified) {
          // Get user data from Firestore
          final userData = await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

          if (userData.exists) {
            final verifiedUser = entities.User(
              uid: user.uid,
              email: user.email ?? '',
              firstName: userData['firstName'] ?? '',
              lastName: userData['lastName'] ?? '',
              username: userData['username'] ?? '',
              createdAt: (userData['createdAt'] as Timestamp?)?.toDate() ??
                  DateTime.now(),
            );
            emit(EmailVerificationSuccess(user: verifiedUser));
          }
        } else {
          emit(EmailVerificationRequired(email: user.email!));
        }
      }
    } catch (e) {
      emit(AuthError(message: 'Failed to check email verification status'));
    }
  }


  Future<void> signIn({required String email, required String password}) async {
    try {
      emit(const AuthLoading());

      if (email.isEmpty || password.isEmpty) {
        emit(const AuthError(message: 'Email and password cannot be empty'));
        return;
      }

      final result =
          await signInUseCase(email: email.trim(), password: password);

      result.fold(
        (failure) => emit(AuthError(message: failure.message)),
        (_) async {
          final firebaseUser = _auth.currentUser;
          if (firebaseUser != null) {
            // Reload user to get latest verification status
            await firebaseUser.reload();

            if (!firebaseUser.emailVerified) {
              // Send a new verification email and require verification
              await sendEmailVerification();
              emit(EmailVerificationRequired(email: firebaseUser.email!));
              return;
            }

            // Get user data from Firestore
            final userData = await FirebaseFirestore.instance
                .collection('users')
                .doc(firebaseUser.uid)
                .get();

            if (userData.exists) {
              final user = entities.User(
                uid: firebaseUser.uid,
                email: firebaseUser.email ?? '',
                firstName: userData['firstName'] ?? '',
                lastName: userData['lastName'] ?? '',
                username: userData['username'] ?? '',
                createdAt: (userData['createdAt'] as Timestamp?)?.toDate() ??
                    DateTime.now(),
              );
              emit(AuthSuccess(user: user, isEmailVerified: true));
            } else {
              emit(const AuthError(message: 'User data not found'));
            }
          } else {
            emit(const AuthError(
                message: 'Failed to retrieve user information'));
          }
        },
      );
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      emit(const AuthLoading());

      final result = await signUpUseCase(
        firstName: firstName,
        lastName: lastName,
        email: email.trim(),
        username: username,
        password: password,
      );

      result.fold(
        (failure) => emit(AuthError(message: failure.message)),
        (_) async {
          final firebaseUser = _auth.currentUser;
          if (firebaseUser != null) {
            // Send verification email immediately after signup
            await sendEmailVerification();

            // Get user data from Firestore to ensure it was saved
            final userData = await FirebaseFirestore.instance
                .collection('users')
                .doc(firebaseUser.uid)
                .get();

            if (userData.exists) {
              final user = entities.User(
                uid: firebaseUser.uid,
                email: firebaseUser.email ?? '',
                firstName: userData['firstName'] ?? '',
                lastName: userData['lastName'] ?? '',
                username: userData['username'] ?? '',
                createdAt: (userData['createdAt'] as Timestamp?)?.toDate() ??
                    DateTime.now(),
              );
              emit(AuthSuccess(user: user, isEmailVerified: false));
            } else {
              emit(const AuthError(message: 'Failed to save user data'));
            }
          } else {
            emit(const AuthError(
                message: 'Failed to retrieve user information'));
          }
        },
      );
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      emit(const AuthLoading());

      final user = _auth.currentUser;
      if (user == null || user.email == null) {
        emit(const AuthError(message: 'No user is currently signed in'));
        return;
      }

      // Re-authenticate user before changing password
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      try {
        await user.reauthenticateWithCredential(credential);
      } catch (e) {
        emit(const AuthError(message: 'Current password is incorrect'));
        return;
      }

      // Change password
      await user.updatePassword(newPassword);

      emit(const ChangePasswordSuccess(
          message: 'Password updated successfully'));
      messageService.showMessage(
          'Password has been changed successfully', MessageType.success);
    } catch (e) {
      emit(ChangePasswordError(
          message: 'Failed to change password: ${e.toString()}'));
      messageService.showMessage(
          'Failed to change password', MessageType.error);
    }
  }

  Future<void> deleteAccount(/*{required String currentPassword}*/) async {
    try {
      emit(const AuthLoading());

      final user = _auth.currentUser;
      if (user == null) {
        emit(const AuthError(message: 'No user is currently signed in'));
        return;
      }

      //  // Re-authenticate user before deleting account
      //   final credential = EmailAuthProvider.credential(
      //     email: user.email!,
      //     password: currentPassword,
      //   );

      //   try {
      //     await user.reauthenticateWithCredential(credential);
      //   } catch (e) {
      //     emit(const AuthError(message: 'Current password is incorrect'));
      //     return;
      //   }

      // Delete user data from Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .delete();

      // Delete the user account
      await user.delete();

      emit(const DeleteAccountSuccess(message: 'Account deleted successfully'));
      messageService.showMessage(
          'Your account has been deleted', MessageType.info);
    } catch (e) {
      emit(DeleteAccountError(
          message: 'Failed to delete account: ${e.toString()}'));
      messageService.showMessage('Failed to delete account', MessageType.error);
    }
  }

  Future<void> signOut() async {
    try {
      emit(const AuthLoading());
      await _auth.signOut();
      emit(const AuthSignedOut(message: "Signed Out Successfully"));
    } catch (e) {
      emit(AuthError(message: 'Failed to sign out: ${e.toString()}'));
      messageService.showMessage('Failed to sign out', MessageType.error);
    }
  }
}
