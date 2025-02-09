import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:color_funland/features/auth/domain/entities/user.dart' as entities;
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

  Future<void> signIn({required String email, required String password}) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        emit(const AuthError(message: 'Email and password cannot be empty'));
        return;
      }

      final result = await signInUseCase(
      email: email.trim(), password: password
      );

      result.fold(
        (failure) => emit(AuthError(message: failure.message)),
        (_) async {
          final firebaseUser = _auth.currentUser;
          if (firebaseUser != null) {
            if (!firebaseUser.emailVerified) {
              emit(EmailVerificationRequired(email: firebaseUser.email!));
              await sendEmailVerification();
            } else {
              final user = entities.User(
                uid: firebaseUser.uid,
                email: firebaseUser.email ?? '',
                firstName: '',
                lastName: '',
                username: '',
                createdAt: DateTime.now(),
              );
              emit(AuthSuccess(user: user, isEmailVerified: true));
            }
          } else {
            emit(const AuthError(message: 'Failed to retrieve user information'));
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
            
            final user = entities.User(
              uid: firebaseUser.uid,
              email: firebaseUser.email ?? '',
              firstName: '',
              lastName: '',
              username: '',
              createdAt: DateTime.now(),
            );
            emit(AuthSuccess(user: user, isEmailVerified: false));
          } else {
            emit(const AuthError(message: 'Failed to retrieve user information'));
          }
        },
      );
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(message: 'Failed to sign out'));
    }
  }
}