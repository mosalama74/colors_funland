import 'dart:ui';

import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/constants/app_strings.dart';
import 'package:color_funland/features/addProfileInfo/presentation/pages/child_progress_scareen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridItem {
  final String? title;
  final String imageUrl;
  final VoidCallback? onTap;
  final double? imgWidth;
  final double? imgHeight;
  final bool? isSvg;

  GridItem({
    this.title = "",
    required this.imageUrl,
    this.onTap,
    this.imgWidth,
    this.imgHeight,
    this.isSvg = false, 
  });
}

final List<String> myPaintingSamplesScreen = [
  '/animalsSamplesScreen',
  '/flowersSamplesScreen',
];

final List<GridItem> gridItems = [
  GridItem(
    title: AppStrings.animals,
    imageUrl: AppImages.animals,
    imgWidth: 180.w,
  ),
  GridItem(
    title: AppStrings.flowers,
    imageUrl: AppImages.flowers,
    imgWidth: 180.w,
  ),
  GridItem(
    title: AppStrings.fishes,
    imageUrl: AppImages.fishes,
    imgWidth: 180.w,
  ),
  GridItem(
    title: AppStrings.vehicles,
    imageUrl: AppImages.vehicles,
    imgWidth: 180.w,
  ),
  GridItem(
    title: AppStrings.dinosaur,
    imageUrl: AppImages.dinasour,
    imgWidth: 180.w,
  ),
  GridItem(
    title: AppStrings.characters,
    imageUrl: AppImages.characters,
    imgWidth: 180.w,
  ),
  GridItem(
    title: AppStrings.places,
    imageUrl: AppImages.places,
    imgWidth: 180.w,
  ),
  GridItem(
    title: AppStrings.paintMyNumbers,
    imageUrl: AppImages.paintByNumbers,
    imgWidth: 180.w,
  ),
];

///*************   Animals Section  ************** */

final List<GridItem> animalsFram = [
   GridItem(
    imageUrl: PaintingProgress.isPainted(AppImages.uncoloredelephantfram) ? 
      AppImages.coloredelephantfram : AppImages.uncoloredelephantfram,
    title: "elephant",
  ),
  GridItem(
    imageUrl: PaintingProgress.isPainted(AppImages.uncoloredturtle2fram) ? 
      AppImages.coloredturtlefram : AppImages.uncoloredturtle2fram,
    title: "turtle",
  ),
  GridItem(
    imageUrl: PaintingProgress.isPainted(AppImages.uncoloredpenguinfram) ? 
      AppImages.coloredpenguinfram : AppImages.uncoloredpenguinfram,
    title: "penguin",
  ),
  GridItem(
    imageUrl: PaintingProgress.isPainted(AppImages.uncoloredelephante2fram) ? 
      AppImages.coloredelephante2fram : AppImages.uncoloredelephante2fram,
    title: "elephante2",
  ),
  GridItem(
    imageUrl: PaintingProgress.isPainted(AppImages.uncoloredmonkey2fram) ? 
      AppImages.coloredmonkey2fram : AppImages.uncoloredmonkey2fram,
    title: "monkey2",
  ),
    GridItem(
      imageUrl: AppImages.tigerFram,
          title: "tiger",

    ),
    GridItem(
      imageUrl: AppImages.turtleFram,
          title: "turtle",

    ),
    GridItem(
      imageUrl: AppImages.beeFram,
          title: "bee",

    ),
    GridItem(
      imageUrl: AppImages.lionBabyFram,
          title: "lionBaby",

    ),
    GridItem(
      imageUrl: AppImages.kangarooFram,
          title: "kangaroo",

    ),
  ];
  
final List<String> animalsPaintingScreen = [
  '/elephantColor',
  '/turtleColor',
  '/penguinColor',
  '/elephante2Color',
  '/monkey2Color',
];



///*************   Fishes Section  ************** */

final List<String> fishesPaintingScreen = [
  '/dolphinColor',
  '/octupusColor',
  '/fishColor',
  '/pufferfishColor',
  '/seahorseColor',
];

final List<GridItem> fishesFram = [
  GridItem(
    imageUrl: AppImages.dolphinFram,
  ),
  GridItem(
    imageUrl: AppImages.octopusFram,
  ),
  GridItem(
    imageUrl: AppImages.fishFram,
  ),
  GridItem(
    imageUrl: AppImages.pufferfishFram,
  ),
  GridItem(
    imageUrl: AppImages.seahorseFram,
  ),
  GridItem(
    imageUrl: AppImages.fishFram2,
  ),
  GridItem(
    imageUrl: AppImages.sharkFram,
  ),
  GridItem(
    imageUrl: AppImages.fishFram3,
  ),
  GridItem(
    imageUrl: AppImages.crabFram,
  ),
  GridItem(
    imageUrl: AppImages.smilefishFram,
  ),
];

///*************   Flowers Section  ************** */

final List<String> flowersPaintingScreen = [
  '/flowerColor1',
  '/flowerColor2',
  '/flowerColor3',
  '/flowerColor4',
];

final List<GridItem> flowersFram = [
  GridItem(
    imageUrl: PaintingProgress.isPainted(AppImages.uncoloredflower1fram) ? 
      AppImages.coloredflower1fram : AppImages.uncoloredflower1fram,
    title: "flower1",
  ),
  GridItem(
    imageUrl: PaintingProgress.isPainted(AppImages.uncoloredflower2fram) ? 
      AppImages.coloredflower2fram : AppImages.uncoloredflower2fram,
    title: "flower2",
  ),
  GridItem(
    imageUrl: PaintingProgress.isPainted(AppImages.uncoloredflower3fram) ? 
      AppImages.coloredflower3fram : AppImages.uncoloredflower3fram,
    title: "flower3",
  ),
  GridItem(
    imageUrl: PaintingProgress.isPainted(AppImages.uncoloredflower4Fram) ? 
      AppImages.coloredflower4fram : AppImages.uncoloredflower4Fram,
    title: "flower4",
  ),
  GridItem(
    imageUrl: AppImages.flowerFram5,
    title: "flower5",
  ),
  GridItem(
    imageUrl: AppImages.flowerFram6,
    title: "flower6",
  ),
  GridItem(
    imageUrl: AppImages.flowerFram7,
    title: "flower7",
  ),
  GridItem(
    imageUrl: AppImages.flowerFram8,
    title: "flower8",
  ),
  GridItem(
    imageUrl: AppImages.flowerFram9,
    title: "flower9",
  ),
  GridItem(
    imageUrl: AppImages.flowerFram10,
    title: "flower10",
  ),
];

///****************** Color Mixing Screen **************/
final List<GridItem> colorMixingItem = [
  GridItem(imageUrl: AppImages.number1, imgHeight: 223.56.h, imgWidth: 264.w),
  GridItem(imageUrl: AppImages.number2, imgHeight: 223.56.h, imgWidth: 264.w),
  GridItem(imageUrl: AppImages.number3, imgHeight: 223.56.h, imgWidth: 264.w),
];

final List<String> colorMixingSamples = [
  '/colorMixingSampls',
  '/colorMixingSampls2',
  '/colorMixingSampls3',
];

List<String> imageSample1 = [
  AppImages.colorPurple,
  AppImages.colorRed,
  AppImages.colorYellow,
];
List<String> imageSample2 = [
  AppImages.colordarkpurple,
  AppImages.colorGreen,
  AppImages.colorOrange,
];
List<String> imageSample3 = [
  AppImages.colorRed,
  AppImages.colorGreen,
  AppImages.colorPurple,
  AppImages.colorOrange,
  AppImages.colorBrown,
  AppImages.colordarkgreen,
];

///****************** Color match Screen **************/

final List<GridItem> colorMatchItem = [
  GridItem(
      // title:"Shapes",
      imageUrl: AppImages.colorMatchShapes,
      imgWidth: 264.w,
      imgHeight: 392.h),
  GridItem(
    // title: "Food",
    imageUrl: AppImages.colorMatchFoods,
    imgWidth: 264.w,
    imgHeight: 392.h,
  ),
  GridItem(
    // title: "Animals",
    imageUrl: AppImages.colorMatchAnimals,
    imgWidth: 264.w,
    imgHeight: 392.h,
  ),
  GridItem(
    // title: "Numbers",
    imageUrl: AppImages.colorMatchNumbers,
    imgWidth: 264.w,
    imgHeight: 392.h,
  ),
];
final List<String> colorMatchSamplesScreens = [
  '/colorMatchShapes',
  '/colorMatchFoods',
  "/colorMatchAnimals",
  "/colorMatchNumbers",
];

///****************** Learning Colors Screen **************/
final List<GridItem> learningColorsItem = [
  GridItem(
    imageUrl: AppImages.lesson1,
    imgHeight: 416.h,
  ),
  GridItem(
    imageUrl: AppImages.lesson2,
    imgHeight: 416.h,
  ),
  GridItem(
    imageUrl: AppImages.lesson3,
    imgHeight: 416.h,
  ),
];


final List<String> learningColorsLessons = [
  '/learningColorslesson1',
  '/learningColorslesson2',
  '/learningColorslesson3',
];


///************************************** lesson 1 *********************************/

List<String> lesson1Images = [
  AppImages.lessonredpalette,
  AppImages.lessongreenpalette,
  AppImages.lessonbluepallete,
];


List<String> redLessonImages = [
  AppImages.lesson1apple,
  AppImages.lesson1turtle,
  AppImages.lesson1Strawberry,
  AppImages.lesson1aunt,
  AppImages.lesson1fish,
  AppImages.lesson1pepper,

];

List<String> greenLessonImages = [
  AppImages.lesson1bird,
  AppImages.lesson1potato,
  AppImages.lesson1union,
  AppImages.lesson1banana,
  AppImages.lesson1vegetable,
  AppImages.lesson1crocodile,

];

List<String> blueLessonImages = [
  AppImages.lesson1frog,
  AppImages.lesson1bluebird,
  AppImages.lesson1grapes,
  AppImages.lesson1whole,
  AppImages.lesson1fish,
  AppImages.lesson1lake,

];


  final Map<String, List<String>> blueImagesGroub = {
     AppImages.bluelesson: [
      AppImages.lesson1bluebird,
      AppImages.lesson1whole,
      AppImages.lesson1lake
    ],
  };

 final Map<String, List<String>> redImagesGroub = {
    AppImages.redlesson: [
      AppImages.lesson1apple,
      AppImages.lesson1Strawberry,
      AppImages.lesson1aunt,
      AppImages.lesson1pepper,
    ],
  };

 final Map<String, List<String>> greenImagesGroub = {
    AppImages.greenlesson: [
      AppImages.lesson1bird,
      AppImages.lesson1vegetable,
      AppImages.lesson1crocodile,
    ],
  };


class Frames{

  static bool isElephanteColored = false;
}