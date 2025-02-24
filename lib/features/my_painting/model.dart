import 'dart:ui';

import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/constants/app_strings.dart';
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
  '/fishesSamplesScreen',
  '/flowersSamplesScreen',
];

final List<GridItem> gridItems = [
  GridItem(
    title: AppStrings.animals,
    imageUrl: AppImages.animals,
    imgWidth: 180.w,
  ),
  GridItem(
    title: AppStrings.fishes,
    imageUrl: AppImages.fishes,
    imgWidth: 180.w,
  ),
  GridItem(
    title: AppStrings.flowers,
    imageUrl: AppImages.flowers,
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

final List<String> animalsPaintingScreen = [
  '/duckColor',
  '/elephantColor',
  '/catColor',
  '/giraffeColor',
  '/lionColor',
];

final List<GridItem> animalsFram = [
  GridItem(
    imageUrl: AppImages.duckFram,
  ),
  GridItem(
    imageUrl: AppImages.elephantFram,
  ),
  GridItem(
    imageUrl: AppImages.catFram,
  ),
  GridItem(
    imageUrl: AppImages.girafeFram,
  ),
  GridItem(
    imageUrl: AppImages.lionFram,
  ),
  GridItem(
    imageUrl: AppImages.tigerFram,
  ),
  GridItem(
    imageUrl: AppImages.turtleFram,
  ),
  GridItem(
    imageUrl: AppImages.beeFram,
  ),
  GridItem(
    imageUrl: AppImages.lionBabyFram,
  ),
  GridItem(
    imageUrl: AppImages.kangarooFram,
  ),
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
  '/flowerColor5',
];

final List<GridItem> flowersFram = [
  GridItem(
    imageUrl: AppImages.flowerFram1,
  ),
  GridItem(
    imageUrl: AppImages.flowerFram2,
  ),
  GridItem(
    imageUrl: AppImages.flowerFram3,
  ),
  GridItem(
    imageUrl: AppImages.flowerFram4,
  ),
  GridItem(
    imageUrl: AppImages.flowerFram5,
  ),
  GridItem(
    imageUrl: AppImages.flowerFram6,
  ),
  GridItem(
    imageUrl: AppImages.flowerFram7,
  ),
  GridItem(
    imageUrl: AppImages.flowerFram8,
  ),
  GridItem(
    imageUrl: AppImages.flowerFram9,
  ),
  GridItem(
    imageUrl: AppImages.flowerFram10,
  ),
];


///****************** Color Mixing Screen **************/
final List<GridItem> colorMixingItem = [
  GridItem(
    imageUrl: AppImages.number1,
    imgHeight:223.56.h,
    imgWidth: 264.w
  ),
  GridItem(
    imageUrl: AppImages.number2,
      imgHeight:223.56.h,
      imgWidth: 264.w
  ),
  GridItem(
    imageUrl: AppImages.number3,
      imgHeight:223.56.h,
      imgWidth: 264.w
  ),
  GridItem(
    imageUrl: AppImages.number4,
      imgHeight:223.56.h,
      imgWidth: 264.w
  ),
  GridItem(
    imageUrl: AppImages.number5,
      imgHeight:223.56.h,
      imgWidth: 264.w
  ),
  GridItem(
    imageUrl: AppImages.number6,
      imgHeight:223.56.h,
      imgWidth: 264.w
  ),
];

final List<String> colorMixingSamples = [
  '/colorMixingSampls',
];
