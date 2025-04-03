import 'package:bloc/bloc.dart';
import 'package:color_funland/core/components/background_sound.dart';
import 'package:color_funland/core/components/success_sound.dart';
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
          try {
            final firebaseUser = _auth.currentUser;
            if (firebaseUser != null) {
              await firebaseUser.reload();

              if (!firebaseUser.emailVerified) {
                await sendEmailVerification();
                emit(EmailVerificationRequired(email: firebaseUser.email!));
                return;
              }

              final userDoc = await FirebaseFirestore.instance
                  .collection('users')
                  .doc(firebaseUser.uid)
                  .get();

              if (userDoc.exists) {
                final userData = userDoc.data()!;


                final verifiedUser = entities.User(
                  uid: firebaseUser.uid,
                  email: firebaseUser.email ?? '',
                  firstName: userData['firstName'] ?? '',
                  lastName: userData['lastName'] ?? '',
                  username: userData['username'] ?? '',
                  createdAt: (userData['createdAt'] as Timestamp?)?.toDate() ??
                      DateTime.now(),
                );

                emit(AuthSuccess(user: verifiedUser, isEmailVerified: true));

                await SuccessSound.playAfterLogin();
                BackgroundAudio.listenForSoundUpdates();
              await  getCurrentChildData();
              } else {
                emit(const AuthError(message: 'User data not found'));
              }
            } else {
              emit(const AuthError(
                  message: 'Failed to retrieve user information'));
            }
          } catch (e) {
            emit(AuthError(message: 'Error during login: ${e.toString()}'));
          }
        },
      );
    } catch (e) {
      emit(AuthError(message: 'Login failed: ${e.toString()}'));
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



  Future<void> resetPassword(String email) async {
  emit(AuthLoading());
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    emit(ForgetPasswordSuccess(message: "Password reset email sent."));
  } catch (e) {
    emit(ForgetPasswordError(message: e.toString()));
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

      // ✅ Stop background music on logout
      await BackgroundAudio.stopAllSounds();
    } catch (e) {
      emit(AuthError(message: 'Failed to sign out: ${e.toString()}'));
      messageService.showMessage('Failed to sign out', MessageType.error);
    }
  }

  Future<void> getCurrentChildData() async {
    try {
      emit(AuthLoading());

      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        emit(GetChildDataErrorState(
          errorMessage: 'User not authenticated',
        ));
        return;
      }

      // Get user document to find current child ID
      final userDoc =
          await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get();

      if (!userDoc.exists) {
        emit(GetChildDataErrorState(
          errorMessage: 'User document not found',
        ));
        return;
      }

      final userData = userDoc.data();
      final String? currentChildId = userData?['currentChildId'];

      if (currentChildId == null) {
        emit(GetChildDataErrorState(
          errorMessage: 'No current child set',
        ));
        return;
      }

      // Get child document using the ID
      final childDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('children')
          .doc(currentChildId)
          .get();

      if (!childDoc.exists) {
        emit(GetChildDataErrorState(
          errorMessage: 'Child not found',
        ));
        return;
      }

      final childData = childDoc.data() as Map<String, dynamic>;
      emit(GetChildDataSuccessState(
        child: {
          'id': childDoc.id,
          'name': childData['name'],
          'age': childData['age'],
          'profileImage': childData['profileImage'],
          'paintingGameCounter': childData['paintingGameCounter'],
          'paintingLevelCounter': childData['paintingLevelCounter'],
          'colorMixingGameCounter': childData['colorMixingGameCounter'],
          'colorMixingLevelCounter': childData['colorMixingLevelCounter'],
          'colorMatchGameCounter': childData['colorMatchGameCounter'],
          'colorMatchLevelCounter': childData['colorMatchLevelCounter'],
          'learningColorsGameCounter': childData['learningColorsGameCounter'],
          'learningColorsLevelCounter': childData['learningColorsLevelCounter'],
        },
      ));
   //   BackgroundAudio.listenForSoundUpdates();
    } catch (e) {
      emit(GetChildDataErrorState(
        errorMessage: e.toString(),
      ));
    }
  }
}
