import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

const String _authImagesPath = "assets/images/auth_images";
const String _gameBoardImagesPath = "assets/images/game_board";
const String _myPaintingImagesPath = "assets/images/mypainting_images";
const String _fishesPath = "assets/images/mypainting_images/fishes";
const String _flowersPath = "assets/images/mypainting_images/flowers";

class AppImages {
/* Landing Page */
  static const String landingBg = "$_authImagesPath/landing_page_bg.png";
  static const String landingChildImage =
      "$_authImagesPath/landing_page_img.png";
  static const String purbleBtnBg = "$_authImagesPath/purbleBtn.png";
  static const String redBtnBg = "$_authImagesPath/redBtn.png";

  /* Login Page */
  static const String loginBg = "$_authImagesPath/login_bg.png";
  static const String logo = "$_authImagesPath/Logo.svg";

  /* forget Password page */
  static const String gradientBg = "$_authImagesPath/gradient_bg.png";
  static const String curvedBtmCardBg = "$_authImagesPath/curvedBtmCardBg.png";

  /* add profile info page */
  static const String cardBg = "$_authImagesPath/cardBg.png";
  static const String defaultUploadImage = "$_authImagesPath/uploadimg.png";

  /// ****************** Game Board **********************

  static const String cardBoard = "$_gameBoardImagesPath/cardBoard.png";
  static const String colorMixing = "$_gameBoardImagesPath/colormixing.png";
  static const String learningColors =
      "$_gameBoardImagesPath/learningcolor.png";
  static const String matchColors = "$_gameBoardImagesPath/matchcolor.png";
  static const String myPainting = "$_gameBoardImagesPath/mypainting.png";
  static const String lightGameBoard =
      "$_gameBoardImagesPath/lightGameBoard.png";
  static const String darkGamBoard = "$_gameBoardImagesPath/darkGamBoard.png";
  static const String yellowshadow = "$_gameBoardImagesPath/yellowshadow.svg";
  static const String childPhoto = "$_gameBoardImagesPath/childPhoto.png";
  static const String childphotoframe =
      "$_gameBoardImagesPath/childphotoframe.png";

  ///********************* My Painting *********************/
  static const String paintingGirl = "$_myPaintingImagesPath/paintingGirl.svg";
  static const String myPaintingCardBg =
      "$_myPaintingImagesPath/myPaintingCardBg.png";
  static const String animals = "$_myPaintingImagesPath/animals.png";
  static const String fishes = "$_myPaintingImagesPath/fishes.png";
  static const String flowers = "$_myPaintingImagesPath/flowers.png";
  static const String characters = "$_myPaintingImagesPath/characters.png";
  static const String dinasour = "$_myPaintingImagesPath/dinasour.png";
  static const String paintByNumbers =
      "$_myPaintingImagesPath/paintByNumbers.png";
  static const String places = "$_myPaintingImagesPath/places.png";
  static const String vehicles = "$_myPaintingImagesPath/vehicles.png";
  static const String locked = "$_myPaintingImagesPath/locked.png";
  static const String brush = "$_myPaintingImagesPath/brush.svg";
  static const String brushHair = "$_myPaintingImagesPath/brush_hair.svg";
  static const String brushHandle = "$_myPaintingImagesPath/brush_handle.svg";

  ///***************  animals frames  **************** */

  static const String duckFram = "$_myPaintingImagesPath/duckFram.png";
  static const String catFram = "$_myPaintingImagesPath/catFram.png";
  static const String elephantFram = "$_myPaintingImagesPath/elephantFram.png";
  static const String girafeFram = "$_myPaintingImagesPath/girafeFram.png";
  static const String kangarooFram = "$_myPaintingImagesPath/kangarooFram.png";
  static const String lionFram = "$_myPaintingImagesPath/lionFram.png";
  static const String tigerFram = "$_myPaintingImagesPath/tigerFram.png";
  static const String turtleFram = "$_myPaintingImagesPath/turtleFram.png";
  static const String beeFram = "$_myPaintingImagesPath/beeFram.png";
  static const String lionBabyFram = "$_myPaintingImagesPath/lionBabyFram.png";

  ///************************    animals            ********************* */

  static const String duckUncolored =
      "$_myPaintingImagesPath/duckUncolored.png";
  static const String duckColored= "$_myPaintingImagesPath/duckColored.png";

  static const String elephantUncolored =
      "$_myPaintingImagesPath/elephantUncolored.png";
  static const String elephantColored = "$_myPaintingImagesPath/elephantColored.png";

  static const String catUncolored = "$_myPaintingImagesPath/catUncolored.png";
  static const String catColored = "$_myPaintingImagesPath/catColored.png";

  static const String giraffeUncolored =
      "$_myPaintingImagesPath/giraffeUncolored.png";
  static const String giraffeColored = "$_myPaintingImagesPath/giraffeColored.png";

  static const String lionUncolored =
      "$_myPaintingImagesPath/lionUncolored.png";
  static const String lionColored = "$_myPaintingImagesPath/lionColored.png";

  static const String tigerUncolored =
      "$_myPaintingImagesPath/tigerUncolored.png";

  static const String turtleUncolored =
      "$_myPaintingImagesPath/turtleUncolored.png";

  static const String beeUncolored = "$_myPaintingImagesPath/beeUncolored.png";

  static const String lionBabyUncolored =
      "$_myPaintingImagesPath/lionBabyUncolored.png";

  static const String kangaroUncolored =
      "$_myPaintingImagesPath/kangaroUncolored.png";

///************************   fishes Fram  ********************** */
  static const String dolphinFram = "$_fishesPath/dolphinFram.png";
  static const String octopusFram = "$_fishesPath/octopusFram.png";
  static const String fishFram = "$_fishesPath/fishFram.png";
  static const String pufferfishFram = "$_fishesPath/pufferfishFram.png";
  static const String seahorseFram = "$_fishesPath/seahorseFram.png";
  static const String fishFram2 = "$_fishesPath/fishFram2.png";
  static const String sharkFram = "$_fishesPath/sharkFram.png";
  static const String fishFram3 = "$_fishesPath/fishFram3.png";
  static const String crabFram = "$_fishesPath/crabFram.png";
  static const String smilefishFram = "$_fishesPath/smilefishFram.png";

///******************************  Fishes ******************** */

static const String dolphinUncolored =
      "$_fishesPath/dolphinUncolored.png";
  static const String dolphinColored= "$_fishesPath/dolphinColored.png";

  static const String octopusUncolored =
      "$_fishesPath/octopusUncolored.png";
  static const String octopusColored = "$_fishesPath/octopusColored.png";

  static const String fishUncolored = "$_fishesPath/fishUncolored.png";
  static const String fishColored = "$_fishesPath/fishColored.png";

  static const String pufferfishUncolored =
      "$_fishesPath/pufferfishUncolored.png";
  static const String pufferfishColored = "$_fishesPath/pufferfishColored.png";

  static const String seahorseUncolored =
      "$_fishesPath/seahorseUncolored.png";
  static const String seahorseColored = "$_fishesPath/seahorseColored.png";

///************************   flowers Fram  ********************** */
  static const String flowerFram1 = "$_flowersPath/flowerFram1.png";
  static const String flowerFram2 = "$_flowersPath/flowerFram2.png";
  static const String flowerFram3 = "$_flowersPath/flowerFram3.png";
  static const String flowerFram4 = "$_flowersPath/flowerFram4.png";
  static const String flowerFram5 = "$_flowersPath/flowerFram5.png";
  static const String flowerFram6 = "$_flowersPath/flowerFram6.png";
  static const String flowerFram7 = "$_flowersPath/flowerFram7.png";
  static const String flowerFram8 = "$_flowersPath/flowerFram8.png";
  static const String flowerFram9 = "$_flowersPath/flowerFram9.png";
  static const String flowerFram10 = "$_flowersPath/flowerFram10.png";

///******************************  Flowers  ******************** */

static const String flowerUncolored1 =
      "$_flowersPath/flowerUncolored1.png";
  static const String flowerColored1= "$_flowersPath/flowerColored1.png";

  static const String flowerUncolored2 =
      "$_flowersPath/flowerUncolored2.png";
  static const String flowerColored2 = "$_flowersPath/flowerColored2.png";

  static const String flowerUncolored3 = "$_flowersPath/flowerUncolored3.png";
  static const String flowerColored3 = "$_flowersPath/flowerColored3.png";

  static const String flowerUncolored4 =
      "$_flowersPath/flowerUncolored4.png";
  static const String flowerColored4 = "$_flowersPath/flowerColored4.png";

  static const String flowerUncolored5 =
      "$_flowersPath/flowerUncolored5.png";
  static const String flowerColored5 = "$_flowersPath/flowerColored5.png";


}
/* logo image */

Widget logoImage = SvgPicture.asset(
  AppImages.logo,
  height: 128.h,
);

Widget appBarlogoImage = SvgPicture.asset(
  AppImages.logo,
  height: 102.h,
);
