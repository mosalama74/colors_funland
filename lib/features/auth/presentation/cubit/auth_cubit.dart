import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:color_funland/features/auth/domain/entities/user.dart' as entities;
import 'package:color_funland/features/auth/domain/usecases/signin_usecase.dart';
import 'package:color_funland/features/auth/domain/usecases/signup_usecase.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;

  AuthCubit({
    required this.signInUseCase,
    required this.signUpUseCase,
  }) : super(AuthInitial());

  Future<void> signIn({required String email, required String password}) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        emit(const AuthError(message: 'Email and password cannot be empty'));
        return;
      }

      final result = await signInUseCase(
       email: email.trim(), password: password);
      
      result.fold(
        (failure) => emit(AuthError(message: failure.message)),
        (_) async {
          final firebaseUser = FirebaseAuth.instance.currentUser;
          if (firebaseUser != null) {
            final user = entities.User(
              uid: firebaseUser.uid,
              email: firebaseUser.email ?? '',
              firstName: '',
              lastName: '',
              username: '',
              createdAt: DateTime.now(),
            );
            emit(AuthSuccess(user: user));
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
          final firebaseUser = FirebaseAuth.instance.currentUser;
          if (firebaseUser != null) {
            final user = entities.User(
              uid: firebaseUser.uid,
              email: firebaseUser.email ?? '',
              firstName: '',
              lastName: '',
              username: '',
              createdAt: DateTime.now(),
            );
            emit(AuthSuccess(user: user));
          } else {
            emit(const AuthError(message: 'Failed to retrieve user information'));
          }
        },
      );
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}