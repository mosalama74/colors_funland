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
import 'package:color_funland/features/color_mixing/pages/color_mixing.dart';
import 'package:color_funland/features/color_mixing/pages/color_mixing_levels.dart';
import 'package:color_funland/features/color_mixing/pages/color_mixing_next_activity.dart';
import 'package:color_funland/features/color_mixing/pages/color_mixing_sample.dart';
import 'package:color_funland/features/game_board/presentation/pages/game_board_screen.dart';
import 'package:color_funland/features/my_painting/pages/animals_samples_screen.dart';
import 'package:color_funland/features/my_painting/pages/fishes_samples_screen.dart';
import 'package:color_funland/features/my_painting/pages/flowers_samples_screen.dart';
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
  '/fishesSamplesScreen': (context) => const FishesSamplesScreen(),
  '/flowersSamplesScreen': (context) => const FlowersSamplesScreen(),
  '/colorMixingScreen' : (context) => const ColorMixingScreen(),
   '/colorMixingSampls' : (context) => const ColorMixingSampls(),
   '/colorMixingLevels' : (context) => const ColorMixingLevels2(),
   '/colorMixingNextActivity' : (context) => const ColorMixingNextActivity(),

  ///*********************  Animals   ********************** */
  
  '/duckColor': (context) => PaintScreen(
      uncoloredImage: AppImages.duckUncolored,
      coloredImage: AppImages.duckColored,categoryName: "Animals",),
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


  ///*********************  Fishes   ********************** */
  
  '/dolphinColor': (context) => PaintScreen(
      uncoloredImage: AppImages.dolphinUncolored,
      coloredImage: AppImages.dolphinColored,categoryName: "Fishes",),
  '/octupusColor': (context) => PaintScreen(
      uncoloredImage: AppImages.octopusUncolored,
      coloredImage: AppImages.octopusColored,categoryName: "Fishes",),
  '/fishColor': (context) => PaintScreen(
      uncoloredImage: AppImages.fishUncolored,
      coloredImage: AppImages.fishColored,categoryName: "Fishes",),
  '/pufferfishColor': (context) => PaintScreen(
      uncoloredImage: AppImages.pufferfishUncolored,
      coloredImage: AppImages.pufferfishColored,categoryName: "Fishes",),
  '/seahorseColor': (context) => PaintScreen(
      uncoloredImage: AppImages.seahorseUncolored,
      coloredImage: AppImages.seahorseColored,categoryName: "Fishes",),

  ///*********************  Flowers   ********************** */
  
  
  '/flowerColor1': (context) => PaintScreen(
      uncoloredImage: AppImages.flowerUncolored1,
      coloredImage: AppImages.flowerColored1,categoryName: "Floweres",),
  '/flowerColor2': (context) => PaintScreen(
      uncoloredImage: AppImages.flowerUncolored2,
      coloredImage: AppImages.flowerColored2,categoryName: "Floweres",),
  '/flowerColor3': (context) => PaintScreen(
      uncoloredImage: AppImages.flowerUncolored3,
      coloredImage: AppImages.flowerColored3,categoryName: "Floweres",),
  '/flowerColor4': (context) => PaintScreen(
      uncoloredImage: AppImages.flowerUncolored4,
      coloredImage: AppImages.flowerColored4,categoryName: "Floweres",),
  '/flowerColor5': (context) => PaintScreen(
      uncoloredImage: AppImages.flowerUncolored5,
      coloredImage: AppImages.flowerColored5,categoryName: "Floweres",),

















};
