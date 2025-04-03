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
import 'package:color_funland/features/color_match/pages/color_match_numbers.dart';
import 'package:color_funland/features/color_match/pages/color_match_shapes.dart';
import 'package:color_funland/features/color_mixing/pages/color_mixing.dart';
import 'package:color_funland/features/color_mixing/pages/color_mixing_levels.dart';
import 'package:color_funland/features/color_mixing/pages/color_mixing_sample.dart';
import 'package:color_funland/features/game_board/presentation/pages/game_board_screen.dart';
import 'package:color_funland/core/constants/model.dart';
import 'package:color_funland/features/learning_colors/pages/learning_colors_board.dart';
import 'package:color_funland/features/learning_colors/pages/learning_colors_lessons.dart';
import 'package:color_funland/features/learning_colors/pages/red_green_blue_practice_page.dart';
import 'package:color_funland/features/learning_colors/pages/red_green_blue_video_page.dart';
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
  '/gameBoard': (context) => const GameBoardScreen(),
  '/mypaintingScreen': (context) => const MyPaintingScreen(),
  '/animalsSamplesScreen': (context) => const AnimalsSamplesScreen(),
  //'/fishesSamplesScreen': (context) => const FishesSamplesScreen(),
  '/flowersSamplesScreen': (context) => const FlowersSamplesScreen(),
  '/colorMatchScreen': (context) => const ColorMatchScreen(),
  '/colorMatchShapes': (context) => const ColorMatchShapes(),
  '/colorMatchFoods': (context) => const ColorMatchFoods(),
  '/colorMatchAnimals': (context) => const ColorMatchAnimals(),
  '/colorMatchNumbers': (context) => ColorMatchNumbers(),
  '/winScreen': (context) => const WinScreen(),

  ///*********************  Animals   ********************** */

  '/elephantColor': (context) => PaintScreen(
        uncoloredImage: AppImages.uncoloredelephante,
        coloredImage: AppImages.coloredelephante,
        categoryName: "Animals",
        colorTools: AppColors.elephantColors,
        itemKey: 'elephant',
      ),
  '/turtleColor': (context) => PaintScreen(
        uncoloredImage: AppImages.uncoloredturtle,
        coloredImage: AppImages.coloredturtle,
        categoryName: "Animals",
        colorTools: AppColors.turtleColors,
        itemKey: 'turtle',
      ),
  '/penguinColor': (context) => PaintScreen(
        uncoloredImage: AppImages.uncoloredpenguin,
        coloredImage: AppImages.coloredpenguin,
        categoryName: "Animals",
        colorTools: AppColors.penguinColors,
        itemKey: 'penguin',
      ),
  '/elephante2Color': (context) => PaintScreen(
        uncoloredImage: AppImages.uncoloredelephante2,
        coloredImage: AppImages.coloredelephante2,
        categoryName: "Animals",
        colorTools: AppColors.elephante2Colors,
        itemKey: 'elephante2',
      ),
  '/monkey2Color': (context) => PaintScreen(
        uncoloredImage: AppImages.uncoloredmonkey2,
        coloredImage: AppImages.coloredmonkey2,
        categoryName: "Animals",
        colorTools: AppColors.monkey2Colors,
        itemKey: 'monkey2',
      ),

  ///*********************  Fishes   ********************** */

  // '/dolphinColor': (context) => PaintScreen(
  //       uncoloredImage: AppImages.dolphinFram,
  //       coloredImage: AppImages.coloreddolphinFram,
  //       categoryName: "Fishes",
  //       colorTools: AppColors.dolphinColors,
  //       itemKey: 'dolphin',
  //     ),
  // '/octopusColor': (context) => PaintScreen(
  //       uncoloredImage: AppImages.octopusFram,
  //       coloredImage: AppImages.coloredoctopusFram,
  //       categoryName: "Fishes",
  //       colorTools: AppColors.octopusColors,
  //       itemKey: 'octopus',
  //     ),
  // '/fishColor': (context) => PaintScreen(
  //       uncoloredImage: AppImages.fishFram,
  //       coloredImage: AppImages.coloredfishFram,
  //       categoryName: "Fishes",
  //       colorTools: AppColors.fishColors,
  //       itemKey: 'fish',
  //     ),
  // '/pufferfishColor': (context) => PaintScreen(
  //       uncoloredImage: AppImages.pufferfishFram,
  //       coloredImage: AppImages.coloredpufferfishFram,
  //       categoryName: "Fishes",
  //       colorTools: AppColors.pufferfishColors,
  //       itemKey: 'pufferfish',
  //     ),
  // '/seahorseColor': (context) => PaintScreen(
  //       uncoloredImage: AppImages.seahorseFram,
  //       coloredImage: AppImages.coloredseahorseFram,
  //       categoryName: "Fishes",
  //       colorTools: AppColors.seahorseColors,
  //       itemKey: 'seahorse',
  //     ),

  ///*********************  Flowers   ********************** */

  '/flowerColor1': (context) => PaintScreen(
        uncoloredImage: AppImages.floweruncolored1,
        coloredImage: AppImages.flowercolored1,
        categoryName: "Flowers",
        colorTools: AppColors.flower1Colors,
        itemKey: 'flower1',
      ),
  '/flowerColor2': (context) => PaintScreen(
        uncoloredImage: AppImages.floweruncolored2,
        coloredImage: AppImages.flowercolored2,
        categoryName: "Flowers", 
        colorTools: AppColors.flower2Colors,
        itemKey: 'flower2',
      ),
  '/flowerColor3': (context) => PaintScreen(
        uncoloredImage: AppImages.floweruncolored3,
        coloredImage: AppImages.flowercolored3,
        categoryName: "Flowers",
        colorTools: AppColors.flower3Colors,
        itemKey: 'flower3',
      ),
  '/flowerColor4': (context) => PaintScreen(
        uncoloredImage: AppImages.floweruncolored4,
        coloredImage: AppImages.flowercolored4,
        categoryName: "Flowers",
        colorTools: AppColors.flower4Colors,
        itemKey: 'flower4',
      ),
 

  ///****************** color mixing ****************************/
  '/colorMixingScreen': (context) => const ColorMixingScreen(),

  ///****************************************** Level 1 ***************************************************///

  '/colorMixingSampls': (context) => ColorMixingSampls(
        images: imageSample1,
        width: 84.w,
        headText: 'Level 1- Primary Colors',
        imageWidth: 188.73.w,
        imageHeight: 188.68.h,
        onTap: () {
          Navigator.of(context).pushNamed("/colorMixingLevels1");
        },
      ),

  '/colorMixingLevels1': (context) => const ColorMixingLevels1(
        firstColor: Color(0xff325EDA),
        secondColor: Color(0xffE80D15),
        resultColor: Color(0xff77398A),
        imageColor: AppImages.colorLevelPurple,
        chosseImageColor1: AppImages.colorLevelGreen,
        chosseImageColor2: AppImages.colorLevelPurple,
        chosseImageColor3: AppImages.colorLevelYellow,
        levelNumber: 'Level 1',
      ),
  '/colorMixingLevels1-2': (context) => const ColorMixingLevels1(
        firstColor: Color(0xff325EDA),
        secondColor: Color(0xffF6CA43),
        resultColor: Color(0xff7CAE0D),
        imageColor: AppImages.colorLevelGreen,
        chosseImageColor1: AppImages.colorLevelGreen,
        chosseImageColor2: AppImages.colorLevelPurple,
        chosseImageColor3: AppImages.colorLevelYellow,
        levelNumber: 'Level 1',
      ),
  '/colorMixingLevels1-3': (context) => const ColorMixingLevels1(
        firstColor: Color(0xffEA0606),
        secondColor: Color(0xffF6CA43),
        resultColor: Color(0xffF29900),
        imageColor: AppImages.colorLevelOrange,
        chosseImageColor1: AppImages.colorLevelPurple,
        chosseImageColor2: AppImages.colorLevelGreen,
        chosseImageColor3: AppImages.colorLevelOrange,
        levelNumber: 'Level 1',
      ),

  ///********************************** Level 2 *******************************************************************///
  '/colorMixingSampls2': (context) => ColorMixingSampls(
        images: imageSample2,
        width: 84.w,
        headText: 'Level 2- Secondary Colors',
        imageWidth: 188.73.w,
        imageHeight: 188.68.h,
        onTap: () {
          Navigator.of(context).pushNamed("/colorMixingLevels2");
        },
      ),
  '/colorMixingLevels2': (context) => const ColorMixingLevels1(
        firstColor: Color(0xff77398A),
        secondColor: Color(0xffE80D15),
        resultColor: Color(0xffC905AD),
        imageColor: AppImages.colorLevelPink,
        chosseImageColor1: AppImages.colorLevelYellow,
        chosseImageColor2: AppImages.colorLevelGreen,
        chosseImageColor3: AppImages.colorLevelPink,
        levelNumber: 'Level 2',
      ),
  '/colorMixingLevels2-2': (context) => const ColorMixingLevels1(
        firstColor: Color(0xff019A00),
        secondColor: Color(0xff0051D4),
        resultColor: Color(0xff0FB4C3),
        imageColor: AppImages.colorLevelBlueGreen,
        chosseImageColor1: AppImages.colorLevelPink,
        chosseImageColor2: AppImages.colorLevelBlueGreen,
        chosseImageColor3: AppImages.colorLevelYellow,
        levelNumber: 'Level 2',
      ),
  '/colorMixingLevels3-2': (context) => const ColorMixingLevels1(
        firstColor: Color(0xffFF7F00),
        secondColor: Color(0xffF6CA43),
        resultColor: Color(0xffF7A500),
        imageColor: AppImages.colorLevelOrange,
        chosseImageColor1: AppImages.colorLevelPurple,
        chosseImageColor2: AppImages.colorLevelGreen,
        chosseImageColor3: AppImages.colorLevelOrange,
        levelNumber: 'Level 2',
      ),

  ///************************************ Level 3 ******************************************************************///
  '/colorMixingSampls3': (context) => ColorMixingSampls(
        images: imageSample3,
        width: 20.w,
        headText: 'Level 3- Tertiary Colors',
        imageWidth: 150.w,
        imageHeight: 150.h,
        onTap: () {
          Navigator.of(context).pushNamed("/colorMixingLevels3");
        },
      ),
  '/colorMixingLevels3': (context) => const ColorMixingLevels1(
        firstColor: Color(0xffDB1D00),
        secondColor: Color(0xffF66F00),
        resultColor: Color(0xffF54700),
        imageColor: AppImages.colorLevelDarkOrange,
        chosseImageColor1: AppImages.colorLevelYellow,
        chosseImageColor2: AppImages.colorLevelGreen,
        chosseImageColor3: AppImages.colorLevelDarkOrange,
        levelNumber: 'Level 3',
      ),
  '/colorMixingLevels2-3': (context) => const ColorMixingLevels1(
        firstColor: Color(0xffFDED00),
        secondColor: Color(0xff4E8D4B),
        resultColor: Color(0xffAFCC1C),
        imageColor: AppImages.colorLevelGreen,
        chosseImageColor1: AppImages.colorLevelOrange,
        chosseImageColor2: AppImages.colorLevelGreen,
        chosseImageColor3: AppImages.colorLevelDarkOrange,
        levelNumber: 'Level 3',
      ),
  '/colorMixingLevels3-3': (context) => const ColorMixingLevels1(
        firstColor: Color(0xff002AFF),
        secondColor: Color(0xff553245),
        resultColor: Color(0xff333270),
        imageColor: AppImages.colorLevelBluePurple,
        chosseImageColor1: AppImages.colorLevelBluePurple,
        chosseImageColor2: AppImages.colorLevelGreen,
        chosseImageColor3: AppImages.colorLevelDarkOrange,
        levelNumber: 'Level 3',
      ),

  ///********************************* learning colors *****************************/

  '/learningColorsboard': (context) => LearningColorsBoard(),

  '/learningColorslesson1': (context) => LearningColorsLessons(
        headText: 'Lesson 1',
        headText2: 'Primary Colors',
        lessonImage: AppImages.colorspalette,
        images: lesson1Images,
      ),

  '/redLessonVideo': (context) => RedGreenBlueVideoPage(
        lessonImage: AppImages.redlesson,
        lessonNumber: 1,
        videoUrl:'https://s3-figma-videos-production-sig.figma.com/video/TEAM/1372081414108277178/198ed78810d3a6fe8b84eddcac9b2bbe927b1af9?Expires=1743984000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=dB--TqLRGx8BonukR-ruCn0NO1gk3~86ZH4nycby8agxpzkqSVRZNbWMds1xkIUJtaf7io0LvAfIabZB-6-jgNkHiD4-9EZf4NblIsP52EkaULYkWsHxNSNoQcF6UUnSJjZBEq01ZPHH9DODAyuFP~niaH9yyH0ayxpf1zStirCXpsVqi3qlW7zsdN03QeinPW0vG4n0L6IU39~bXDbJXFZoy-9fNsInh2SSxkU7HmgqPi7Y1caryGXBz-XXLXWhS~XtmOwBNP7l6RjcFCAFJrsF-Mz0Zfoi69FWADcXL~BD2JX5FtXaOkPwv1Eg-iaYT2c7V0XU~OGlajir7PcV3w__',

      ),
  '/greenLessonVideo': (context) => RedGreenBlueVideoPage(
        lessonImage: AppImages.greenlesson,
        lessonNumber: 2,
        videoUrl: 'https://s3-figma-videos-production-sig.figma.com/video/TEAM/1372081414108277178/d78fdfc06007e09ddf72a994252730dcbabd046e?Expires=1743984000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=jib~~8VY~3zx7YSaEe99dIZn31VDlQ0HyzTc0L7zaRyrorFd7T3ljphHkPbVWnIjcmdEmuI8O-5TaQJngXWp5hHOw3PQRR9tXkdTo-c~B15aFd6oH7U8AC4svQoAdBq-q7sXosgcjvk9wi~WfEwFsr-hOmMDbxMNWJ320dF2oANS7UccCiUSFEB7b8o76C4Xy9WAvLBwVmZiJispTuV-Td6LXGWjE5IvxBuLOGWU6fx~iyQywkutvLP4A-IUP-G7wa~hPIgDBsUK7dwGP0Y8jqq2ykLJOyp8XRdHpKZrtolyb-rVr68avFV2Hz9KSvsPKQppcEwcO5k~NQwPfYGgUA__',
 
      ),
  '/blueLessonVideo': (context) => RedGreenBlueVideoPage(
        lessonImage: AppImages.bluelesson,
        lessonNumber: 3,
        videoUrl: 'https://s3-figma-videos-production-sig.figma.com/video/TEAM/1372081414108277178/d94512402b8d856782afaf9de26ab4e89fc066d0?Expires=1743984000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=t~nCIrsmgkrA3bbgCCbX27J7qqmXD6TnvVT~HIHN2WtFkEkHhdJpWo4GcTYxS4xRfGYocCXMquhh8MncCSoGSYL1o9rPnVBFibxXNDbVBLqjBEx-wcStdQ6lHcDyVsJUw-YA-eimBfQHqv1sYrQtcjNwBx46vS8pGfIgt5VLR~RaHl0ZlZZ42tSNr6nFLoROFyppbG06M2E2QRHjDlo7vjWsCAtM57mvev5ETr51Pc132nODy6rBVSiOUnWmUjY2xe3fCRgUbCxn-ZzvjesArI102NvEnF5MBe~1GK3odf2CTZd9L22IYX~FZ6iBe94f9pOCQEdHnVbpZD7KTrPdpw__',

      ),

  '/redLesson': (context) => RedGreenBluePracticePage(
        images: redLessonImages,
        lessonImage: AppImages.redlesson,
      ),
  '/greenLesson': (context) => RedGreenBluePracticePage(
        images: greenLessonImages,
        lessonImage: AppImages.greenlesson,
      ),
  '/blueLesson': (context) => RedGreenBluePracticePage(
        images: blueLessonImages,
        lessonImage: AppImages.bluelesson,
      ),
};
