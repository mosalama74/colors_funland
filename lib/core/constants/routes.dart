import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/features/addProfileInfo/presentation/pages/addd_profile_info_screen.dart';
import 'package:color_funland/features/addProfileInfo/presentation/pages/change_password_screen.dart';
import 'package:color_funland/features/addProfileInfo/presentation/pages/delete_account_screen.dart';
import 'package:color_funland/features/addProfileInfo/presentation/pages/forget_password_screen.dart';
import 'package:color_funland/features/auth/presentation/pages/email_verification_screen.dart';
import 'package:color_funland/features/auth/presentation/pages/landing_page.dart';
import 'package:color_funland/features/auth/presentation/pages/login_page.dart';
import 'package:color_funland/features/auth/presentation/pages/signup_screen.dart';
import 'package:color_funland/features/game_board/presentation/pages/game_board_screen.dart';
import 'package:color_funland/features/my_painting/pages/my_painting_samples.dart';
import 'package:color_funland/features/my_painting/pages/myPaintingScreen.dart';
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
  '/email-verification': (context) => const EmailVerificationScreen(),
  '/gameBoard': (context) => const GameBoardScreen(),
   '/myPaintingSamples' : (context) => const MyPaintingSamples(),
    '/mypaintingScreen': (context) => const MyPaintingScreen(),
   '/duckColor':(context) => PaintScreen(uncoloredImage: AppImages.duckuncolored,coloredImage: AppImages.coloredduck),
  '/bearColor':(context) => PaintScreen(uncoloredImage: AppImages.bearuncolored,coloredImage: AppImages.coloredduck),
 '/giraffeColor':(context) => PaintScreen(uncoloredImage: AppImages.giraffeuncolored,coloredImage: AppImages.coloredduck),
 '/elephantColor':(context) => PaintScreen(uncoloredImage: AppImages.elephantuncolored,coloredImage: AppImages.coloredduck),
  '/lionColor':(context) => PaintScreen(uncoloredImage: AppImages.lionuncolored,coloredImage: AppImages.coloredduck),
  '/tigerColor':(context) => PaintScreen(uncoloredImage: AppImages.catuncolored,coloredImage: AppImages.coloredduck),
  '/turtleColor':(context) => PaintScreen(uncoloredImage: AppImages.turtleuncolored,coloredImage: AppImages.coloredduck),
  '/beeColor':(context) => PaintScreen(uncoloredImage: AppImages.beeuncolored,coloredImage: AppImages.coloredduck),
 '/lion2Color':(context) => PaintScreen(uncoloredImage: AppImages.lionBabyuncolored,coloredImage: AppImages.coloredduck),
 '/kangarooColor':(context) =>  PaintScreen(uncoloredImage: AppImages.kangarouncolored,coloredImage: AppImages.coloredduck),


};


