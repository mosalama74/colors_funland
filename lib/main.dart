
import 'package:color_funland/color_funland_app.dart';
import 'package:color_funland/core/services/message_service.dart';
import 'package:color_funland/features/addProfileInfo/presentation/cubit/profile_info_cubit.dart';
import 'package:color_funland/features/my_painting/services/painting_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/domain/usecases/signin_usecase.dart';
import 'features/auth/domain/usecases/signup_usecase.dart';
import 'injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    await PaintingService.initialize();

  await di.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(
            messageService: di.sl<MessageService>(),
            signInUseCase: di.sl<SignInUseCase>(),
            signUpUseCase: di.sl<SignUpUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => ProfileInfoCubit(),
        ),
      ],
      child: ColorFunLandApp(),
    ),
  );
}
