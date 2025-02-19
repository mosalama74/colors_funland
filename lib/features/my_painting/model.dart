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

final List<String> animalsPaintingScreen = [
  '/duckColor',
  '/elephantColor',
  '/catColor',
  '/giraffeColor',
  '/lionColor',

];

final List<String> myPaintingSamplesScreen = [
 '/animalsSamplesScreen',
  '/mypaintingScreen',
  "/bearColor",
  "/giraffeColor",
  "/elephantColor",
  "/lionColor",
  "/tigerColor",
  "/turtleColor",
  "/beeColor",
  "/lion2Color",
  "/kangarooColor",
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

final List<GridItem> animalsFram = [
  GridItem(
    imageUrl: AppImages.duckFram,
    imgWidth: 190.17.w,
  ),
  GridItem(
    imageUrl: AppImages.elephantFram,
    imgWidth: 190.17.w,
  ),
  GridItem(
    imageUrl: AppImages.catFram,
    imgWidth: 190.17.w,
  ),
  GridItem(
    imageUrl: AppImages.girafeFram,
    imgWidth: 190.17.w,
  ),
  GridItem(
    imageUrl: AppImages.lionFram,
    imgWidth: 190.17.w,
  ),
  GridItem(
    imageUrl: AppImages.tigerFram,
    imgWidth: 190.17.w,
  ),
  GridItem(
    imageUrl: AppImages.turtleFram,
    imgWidth: 190.17.w,
  ),
  GridItem(
    imageUrl: AppImages.beeFram,
    imgWidth: 190.17.w,
  ),
  GridItem(
    imageUrl: AppImages.lionBabyFram,
    imgWidth: 190.17.w,
  ),
  GridItem(
    imageUrl: AppImages.kangarooFram,
    imgWidth: 190.17.w,
  ),
];
