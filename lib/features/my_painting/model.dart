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

final List<String> paintingScreen = [
 '/duckColor',
  '/bearColor',
 '/giraffeColor',
 '/elephantColor',
  '/lionColor',
  '/tigerColor',
  '/turtleColor',
  '/beeColor',
 '/lion2Color',
 '/kangarooColor',

];

final List<String> myPaintingSamples = [
  '/myPaintingSamples',
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
  ),
  GridItem(
    title: AppStrings.flowers,
    imageUrl: AppImages.flowers,
  ),
  GridItem(
    title: AppStrings.fishes,
    imageUrl: AppImages.fishes,
  ),
  GridItem(
    title: AppStrings.vehicles,
    imageUrl: AppImages.vehiclesClosed,
  ),
  GridItem(
    title: AppStrings.dinosaur,
    imageUrl: AppImages.dinasourClosed,
  ),
  GridItem(
    title: AppStrings.characters,
    imageUrl: AppImages.charactersClosed,
  ),
  GridItem(
    title: AppStrings.places,
    imageUrl: AppImages.placesClosed,
  ),
  GridItem(
    title: AppStrings.paintMyNumbers,
    imageUrl: AppImages.paintByNumbersClosed,
  ),
];

final List<GridItem> paintingAnimals = [
  GridItem(imageUrl: AppImages.duckFram ,imgWidth: 217.17.w,imgHeight:211.59.h ),
  GridItem(imageUrl: AppImages.bearFram,imgWidth: 217.17.w,imgHeight:211.59.h ),
  GridItem(imageUrl: AppImages.girafeFram,imgWidth: 217.17.w,imgHeight:211.59.h ),
  GridItem(imageUrl: AppImages.elephantFram,imgWidth: 217.17.w,imgHeight:211.59.h ),
  GridItem(imageUrl: AppImages.lionFram,imgWidth: 217.17.w,imgHeight:211.59.h ),
  GridItem(imageUrl: AppImages.catFram,imgWidth: 217.17.w,imgHeight:211.59.h ),
  GridItem(imageUrl: AppImages.turtleFram,imgWidth: 217.17.w,imgHeight:211.59.h ),
  GridItem(imageUrl: AppImages.beeFram,imgWidth: 217.17.w,imgHeight:211.59.h ),
  GridItem(imageUrl: AppImages.lionBabyFram,imgWidth: 217.17.w,imgHeight:211.59.h ),
  GridItem(imageUrl: AppImages.kangarooFram,imgWidth: 217.17.w,imgHeight:211.59.h ),
];
