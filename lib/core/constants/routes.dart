import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/features/addProfileInfo/presentation/pages/addd_profile_info_screen.dart';
import 'package:color_funland/features/addProfileInfo/presentation/pages/change_password_screen.dart';
import 'package:color_funland/features/addProfileInfo/presentation/pages/child_progress_scareen.dart';
import 'package:color_funland/features/addProfileInfo/presentation/pages/delete_account_screen.dart';
import 'package:color_funland/features/addProfileInfo/presentation/pages/forget_password_screen.dart';
import 'package:color_funland/features/auth/presentation/pages/email_verification_screen.dart';
import 'package:color_funland/features/auth/presentation/pages/landing_page.dart';
import 'package:color_funland/features/auth/presentation/pages/login_page.dart';
import 'package:color_funland/features/auth/presentation/pages/signup_screen.dart';
import 'package:color_funland/features/game_board/presentation/pages/game_board_screen.dart';
import 'package:color_funland/features/my_painting/pages/animals_samples_screen.dart';
import 'package:color_funland/features/my_painting/pages/my_painting_screen.dart';
import 'package:color_funland/features/my_painting/pages/paint_screen.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const LandingPage(),
  '/login': (context) => const LoginScreen(),
  '/signup': (context) => const SignUpScreen(isFirstPage: true),
  '/addProfileInfo': (context) => const AddProfileInfoScreen(),
  '/forgetPassword': (context) => const ForgetPasswordScreen(),
  '/changePassword': (context) => const ChangePasswordScreen(),
  '/deleteAccount': (context) => const DeleteAccountScreen(),
  '/childProgress': (context) => const ChildProgressScreen(),
  '/email-verification': (context) => const EmailVerificationScreen(),
  '/gameBoard': (context) => const GameBoardScreen(),
  '/mypaintingScreen': (context) => const MyPaintingScreen(),
  '/animalsSamplesScreen': (context) => const AnimalsSamplesScreen(),

  ///*********************  Animals   ********************** */
  '/duckColor': (context) => PaintScreen(
      uncoloredImage: AppImages.duckUncolored,
      coloredImage: AppImages.coloredduck,categoryName: "Animals",),
  '/elephantColor': (context) => PaintScreen(
      uncoloredImage: AppImages.elephantUncolored,
      coloredImage: AppImages.elephantColored,categoryName: "Animals",),
  '/catColor': (context) => PaintScreen(
      uncoloredImage: AppImages.catUncolored,
      coloredImage: AppImages.catColored,categoryName: "Animals",),
  '/giraffeColor': (context) => PaintScreen(
      uncoloredImage: AppImages.giraffeUncolored,
      coloredImage: AppImages.giraffeColored,categoryName: "Animals",),
  '/lionColor': (context) => PaintScreen(
      uncoloredImage: AppImages.lionUncolored,
      coloredImage: AppImages.lionColored,categoryName: "Animals",),
};
