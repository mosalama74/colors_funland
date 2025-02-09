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
  final MessageService messageService;

  AuthCubit({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.messageService,
  }) : super(AuthInitial());

  Future<void> signIn({required String email, required String password}) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        const message = 'Email and password cannot be empty';
        messageService.showMessage(message, MessageType.error);
        emit(const AuthError(message: message));
        return;
      }

      final result = await signInUseCase(
       email: email.trim(), password: password);
      
      result.fold(
        (failure) {
          messageService.showMessage(failure.message, MessageType.error);
          emit(AuthError(message: failure.message));
        },
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
            messageService.showMessage('Successfully logged in', MessageType.success);
            emit(AuthSuccess(user: user));
          } else {
            const message = 'Failed to retrieve user information';
            messageService.showMessage(message, MessageType.error);
            emit(const AuthError(message: message));
          }
        },
      );
    } catch (e) {
      messageService.showMessage(e.toString(), MessageType.error);
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
        (failure) {
          messageService.showMessage(failure.message, MessageType.error);
          emit(AuthError(message: failure.message));
        },
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
            messageService.showMessage('Account created successfully', MessageType.success);
            emit(AuthSuccess(user: user));
          } else {
            const message = 'Failed to retrieve user information';
            messageService.showMessage(message, MessageType.error);
            emit(const AuthError(message: message));
          }
        },
      );
    } catch (e) {
      messageService.showMessage(e.toString(), MessageType.error);
      emit(AuthError(message: e.toString()));
    }
  }
}