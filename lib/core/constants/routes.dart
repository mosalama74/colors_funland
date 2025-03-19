import 'package:color_funland/core/components/win_screen.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/utils/app_colors.dart';
import 'package:color_funland/features/addProfileInfo/presentation/pages/addd_profile_info_screen.dart';
import 'package:color_funland/features/addProfileInfo/presentation/pages/change_password_screen.dart';
import 'package:color_funland/features/addProfileInfo/presentation/pages/child_progress_scareen.dart';
import 'package:color_funland/features/addProfileInfo/presentation/pages/delete_account_screen.dart';
import 'package:color_funland/features/addProfileInfo/presentation/pages/forget_password_screen.dart';
import 'package:color_funland/features/auth/presentation/pages/email_verification_screen.dart';
import 'package:color_funland/features/auth/presentation/pages/landing_page.dart';
import 'package:color_funland/features/auth/presentation/pages/login_page.dart';
import 'package:color_funland/features/auth/presentation/pages/signup_screen.dart';
import 'package:color_funland/features/color_match/pages/color_match.dart';
import 'package:color_funland/features/color_match/pages/color_match_animals.dart';
import 'package:color_funland/features/color_match/pages/color_match_foods.dart';
import 'package:color_funland/features/color_match/pages/color_match_shapes.dart';
import 'package:color_funland/features/color_mixing/pages/color_mixing.dart';
import 'package:color_funland/features/color_mixing/pages/color_mixing_levels.dart';
import 'package:color_funland/features/color_mixing/pages/color_mixing_sample.dart';
import 'package:color_funland/features/game_board/presentation/pages/game_board_screen.dart';
import 'package:color_funland/features/my_painting/model.dart';
import 'package:color_funland/features/my_painting/pages/animals_samples_screen.dart';
import 'package:color_funland/features/my_painting/pages/fishes_samples_screen.dart';
import 'package:color_funland/features/my_painting/pages/flowers_samples_screen.dart';
import 'package:color_funland/features/my_painting/pages/my_painting_screen.dart';
import 'package:color_funland/features/my_painting/pages/paint_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  '/gameBoard': (context) =>const  GameBoardScreen(),
  '/mypaintingScreen': (context) => const MyPaintingScreen(),
  '/animalsSamplesScreen': (context) => const AnimalsSamplesScreen(),
  '/fishesSamplesScreen': (context) => const FishesSamplesScreen(),
  '/flowersSamplesScreen': (context) => const FlowersSamplesScreen(),
    '/colorMatchScreen' : (context) => const ColorMatchScreen(),
   '/colorMatchShapes' : (context) => const ColorMatchShapes(),
   '/colorMatchFoods' : (context) => const ColorMatchFoods(),
   '/colorMatchAnimals' : (context) => const ColorMatchAnimals(),
   '/winScreen' : (context) => const WinScreen(),

  ///*********************  Animals   ********************** */
  
  '/duckColor': (context) => PaintScreen(
      uncoloredImage: AppImages.duckuncolored,
      coloredImage: AppImages.duckcolored,
      categoryName: "Animals",
      colorTools: AppColors.duckColors,
      ),
  '/elephantColor': (context) => PaintScreen(
      uncoloredImage: AppImages.elephantuncolored,
      coloredImage: AppImages.elephantcolored,categoryName: "Animals",
      colorTools: AppColors.elephantColors,
      ),
  '/catColor': (context) => PaintScreen(
      uncoloredImage: AppImages.catuncolored,
      coloredImage: AppImages.catcolored,categoryName: "Animals",
      colorTools: AppColors.catColors,
      ),
  '/giraffeColor': (context) => PaintScreen(
      uncoloredImage: AppImages.giraffeuncolored,
      coloredImage: AppImages.giraffecolored,categoryName: "Animals",
      colorTools: AppColors.giraffeColors,
      ),
  '/lionColor': (context) => PaintScreen(
      uncoloredImage: AppImages.lionuncolored,
      coloredImage: AppImages.lioncolored,categoryName: "Animals",
      colorTools: AppColors.lionColors,
      ),


  ///*********************  Fishes   ********************** */
  
  '/dolphinColor': (context) => PaintScreen(
      uncoloredImage: AppImages.dolphinuncolored,
      coloredImage: AppImages.dolphincolored,categoryName: "Fishes",
      colorTools: AppColors.dolphinColors,
      ),
  '/octupusColor': (context) => PaintScreen(
      uncoloredImage: AppImages.octopusuncolored,
      coloredImage: AppImages.octopuscolored,categoryName: "Fishes",
      colorTools: AppColors.octupusColors,
      ),
  '/fishColor': (context) => PaintScreen(
      uncoloredImage: AppImages.fishuncolored,
      coloredImage: AppImages.fishcolored,categoryName: "Fishes",
      colorTools: AppColors.fishColors,
      ),
  '/pufferfishColor': (context) => PaintScreen(
      uncoloredImage: AppImages.pufferfishuncolored,
      coloredImage: AppImages.pufferfishcolored,categoryName: "Fishes",
      colorTools: AppColors.pufferfishColors,),
  '/seahorseColor': (context) => PaintScreen(
      uncoloredImage: AppImages.seahorseuncolored,
      coloredImage: AppImages.seahorsecolored,categoryName: "Fishes",
      colorTools: AppColors.seahorseColors,),

  ///*********************  Flowers   ********************** */
  
  
  '/flowerColor1': (context) => PaintScreen(
      uncoloredImage: AppImages.floweruncolored1,
      coloredImage: AppImages.flowercolored1,categoryName: "Floweres",
      colorTools: AppColors.flower1Colors,),
  '/flowerColor2': (context) => PaintScreen(
      uncoloredImage: AppImages.floweruncolored2,
      coloredImage: AppImages.flowercolored2,categoryName: "Floweres",
      colorTools: AppColors.flower2Colors,),
  '/flowerColor3': (context) => PaintScreen(
      uncoloredImage: AppImages.floweruncolored3,
      coloredImage: AppImages.flowercolored3,categoryName: "Floweres",
       colorTools: AppColors.flower3Colors,),
  '/flowerColor4': (context) => PaintScreen(
      uncoloredImage: AppImages.floweruncolored4,
      coloredImage: AppImages.flowercolored4,categoryName: "Floweres",
       colorTools: AppColors.flower4Colors,),
  '/flowerColor5': (context) => PaintScreen(
      uncoloredImage: AppImages.floweruncolored5,
      coloredImage: AppImages.flowercolored5,categoryName: "Floweres",
       colorTools: AppColors.flower5Colors,),




///****************** color mixing ****************************/
  '/colorMixingScreen' : (context) => const ColorMixingScreen(),

   ///****************************************** Level 1 ***************************************************///

   '/colorMixingSampls' : (context) =>  ColorMixingSampls(
    images: imageSample1,
     width: 84.w,
     headText: 'Level 1- Primary Colors',
     imageWidth: 188.73.w,
     imageHeight:188.68.h,
     onTap: () {
     Navigator.of(context).pushNamed("/colorMixingLevels1");
   }, ),

   
   '/colorMixingLevels1' : (context) => const ColorMixingLevels1(
      firstColor: Color(0xff325EDA),
       secondColor: Color(0xffE80D15),
       resultColor: Color(0xff77398A),
       imageColor: AppImages.colorLevelPurple,
       chosseImageColor1: AppImages.colorLevelGreen,
       chosseImageColor2: AppImages.colorLevelPurple,
       chosseImageColor3: AppImages.colorLevelYellow, levelNumber: 'Level 1',
   ),
   '/colorMixingLevels1-2' : (context) => const ColorMixingLevels1(firstColor: Color(0xff325EDA),
       secondColor: Color(0xffF6CA43),
       resultColor: Color(0xff7CAE0D),
       imageColor: AppImages.colorLevelGreen,
       chosseImageColor1: AppImages.colorLevelGreen,
       chosseImageColor2: AppImages.colorLevelPurple,
       chosseImageColor3: AppImages.colorLevelYellow, levelNumber: 'Level 1',),
 '/colorMixingLevels1-3' : (context) => const ColorMixingLevels1(firstColor: Color(0xffEA0606),
     secondColor: Color(0xffF6CA43),
     resultColor: Color(0xffF29900),
     imageColor: AppImages.colorLevelOrange,
     chosseImageColor1: AppImages.colorLevelPurple,
     chosseImageColor2: AppImages.colorLevelGreen,
     chosseImageColor3: AppImages.colorLevelOrange, levelNumber: 'Level 1',),
 // '/colorMixingLevels1-4' : (context) => const ColorMixingLevels1(firstColor: Color(0xffEA0606),
 //     secondColor: Color(0xff368727),
 //     resultColor: Color(0xffF6CA43),
 //     imageColor: AppImages.colorLevelYellow,
 //     chosseImageColor1: AppImages.colorLevelBrown,
 //     chosseImageColor2: AppImages.colorLevelPurple,
 //     chosseImageColor3: AppImages.colorLevelYellow, levelNumber: 'Level 1',),

  ///********************************** Level 2 *******************************************************************///
  '/colorMixingSampls2' : (context) =>  ColorMixingSampls(
    images: imageSample2,
    width: 84.w,
    headText: 'Level 2- Secondary Colors',
    imageWidth: 188.73.w,
    imageHeight:188.68.h,onTap: () {
      Navigator.of(context).pushNamed("/colorMixingLevels2");
    }, ),
  '/colorMixingLevels2' : (context) => const ColorMixingLevels1(firstColor: Color(0xff77398A),
    secondColor: Color(0xffE80D15),
    resultColor: Color(0xffC905AD),
    imageColor: AppImages.colorLevelPink,
    chosseImageColor1: AppImages.colorLevelYellow,
    chosseImageColor2: AppImages.colorLevelGreen,
    chosseImageColor3: AppImages.colorLevelPink,
     levelNumber: 'Level 2',
  ),
  '/colorMixingLevels2-2' : (context) => const ColorMixingLevels1(
    firstColor: Color(0xff019A00),
    secondColor: Color(0xff0051D4),
    resultColor: Color(0xff0FB4C3),
    imageColor: AppImages.colorLevelBlueGreen,
    chosseImageColor1: AppImages.colorLevelPink,
    chosseImageColor2: AppImages.colorLevelBlueGreen,
    chosseImageColor3: AppImages.colorLevelYellow, levelNumber: 'Level 2',),
  '/colorMixingLevels3-2' : (context) => const ColorMixingLevels1(firstColor: Color(0xffFF7F00),
    secondColor: Color(0xffF6CA43),
    resultColor: Color(0xffF7A500),
    imageColor: AppImages.colorLevelOrange,
    chosseImageColor1: AppImages.colorLevelPurple,
    chosseImageColor2: AppImages.colorLevelGreen,
    chosseImageColor3: AppImages.colorLevelOrange, levelNumber: 'Level 2',),

  ///************************************ Level 3 ******************************************************************///
  '/colorMixingSampls3' : (context) =>  ColorMixingSampls(images: imageSample3,
      width: 20.w,
      headText: 'Level 3- Tertiary Colors',
      imageWidth: 150.w,
      imageHeight:150.h ,
  onTap: () {
Navigator.of(context).pushNamed("/colorMixingLevels3");
}, ),
  '/colorMixingLevels3' : (context) => const ColorMixingLevels1(firstColor: Color(0xffDB1D00),
    secondColor: Color(0xffF66F00),
    resultColor: Color(0xffF54700),
    imageColor: AppImages.colorLevelDarkOrange,
    chosseImageColor1: AppImages.colorLevelYellow,
    chosseImageColor2: AppImages.colorLevelGreen,
    chosseImageColor3: AppImages.colorLevelDarkOrange,
    levelNumber: 'Level 3',
  ),
  '/colorMixingLevels2-3' : (context) => const ColorMixingLevels1(
    firstColor: Color(0xffFDED00),
    secondColor: Color(0xff4E8D4B),
    resultColor: Color(0xffAFCC1C),
    imageColor: AppImages.colorLevelGreen,
    chosseImageColor1: AppImages.colorLevelOrange,
    chosseImageColor2: AppImages.colorLevelGreen,
    chosseImageColor3: AppImages.colorLevelDarkOrange, levelNumber: 'Level 3',),
  '/colorMixingLevels3-3' : (context) => const ColorMixingLevels1(
    firstColor: Color(0xff002AFF),
    secondColor: Color(0xff553245),
    resultColor: Color(0xff333270),
    imageColor: AppImages.colorLevelBluePurple,
    chosseImageColor1: AppImages.colorLevelBluePurple,
    chosseImageColor2: AppImages.colorLevelGreen,
    chosseImageColor3: AppImages.colorLevelDarkOrange, levelNumber: 'Level 3',),












};
