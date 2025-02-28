import 'package:color_funland/features/auth/data/repositories/firebase_auth_repository.dart';
import 'package:color_funland/features/auth/domain/repositories/repository.dart';
import 'package:color_funland/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:color_funland/features/auth/domain/usecases/signin_usecase.dart';
import 'package:color_funland/features/auth/domain/usecases/signup_usecase.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:color_funland/core/services/message_service.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubits
  sl.registerFactory(
    () => AuthCubit(
      signInUseCase: sl(),
      signUpUseCase: sl(),
      messageService: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));

  // Core
  sl.registerLazySingleton<MessageService>(() => ToastMessageService());

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => FirebaseAuthRepository(
      firebaseAuth: sl(),
      firestore: sl(),
    ),
  );

  // External
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}