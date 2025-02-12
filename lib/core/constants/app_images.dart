import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

 const String _authImagesPath = "assets/images/auth_images";
 const String _gameBoardImagesPath = "assets/images/game_board";
 const String _myPaintingImagesPath = "assets/images/mypainting_images";

class AppImages {

/* Landing Page */
  static const String landingBg = "$_authImagesPath/landing_page_bg.png";
  static const String landingChildImage = "$_authImagesPath/landing_page_img.png";
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
    static const String learningColors = "$_gameBoardImagesPath/learningcolor.png";
    static const String matchColors = "$_gameBoardImagesPath/matchcolor.png";
    static const String myPainting = "$_gameBoardImagesPath/mypainting.png";
    static const String lightGameBoard = "$_gameBoardImagesPath/lightGameBoard.png";
    static const String darkGamBoard = "$_gameBoardImagesPath/darkGamBoard.png";
    static const String yellowshadow = "$_gameBoardImagesPath/yellowshadow.svg";
    static const String childPhoto = "$_gameBoardImagesPath/childPhoto.png";
    static const String childphotoframe = "$_gameBoardImagesPath/childphotoframe.png";

    ///********************* My Painting *********************/
    static const String paintingGirl = "$_myPaintingImagesPath/paintingGirl.svg";
    static const String animals = "$_myPaintingImagesPath/animals.png";
    static const String charactersClosed = "$_myPaintingImagesPath/charactersClosed.png";
    static const String charactersOpened = "$_myPaintingImagesPath/charactersOpened.png";
    static const String dinasourClosed = "$_myPaintingImagesPath/dinasourClosed.png";
    static const String dinasourOpened = "$_myPaintingImagesPath/dinasourOpened.png";
    static const String fishes = "$_myPaintingImagesPath/fishes.png";
    static const String flowers = "$_myPaintingImagesPath/flowers.png";
    static const String paintByNumbersClosed = "$_myPaintingImagesPath/paintByNumbersClosed.png";
    static const String paintByNumbersOpened = "$_myPaintingImagesPath/paintByNumbersOpened.png";
    static const String placesClosed = "$_myPaintingImagesPath/placesClosed.png";
    static const String placesOpened = "$_myPaintingImagesPath/placesOpened.png";
    static const String vehiclesClosed = "$_myPaintingImagesPath/vehiclesClosed.png";
    static const String vehiclesOpen = "$_myPaintingImagesPath/vehiclesOpen.png";
    static const String duckFram = "$_myPaintingImagesPath/duckFram.png";
    static const String bearFram = "$_myPaintingImagesPath/bearFram.png";
    static const String beeFram = "$_myPaintingImagesPath/beeFram.png";
    static const String catFram = "$_myPaintingImagesPath/catFram.png";
    static const String elephantFram = "$_myPaintingImagesPath/elephantFram.png";
    static const String girafeFram = "$_myPaintingImagesPath/girafeFram.png";
    static const String kangarooFram = "$_myPaintingImagesPath/kangarooFram.png";
    static const String lionBabyFram = "$_myPaintingImagesPath/lionBabyFram.png";
    static const String lionFram = "$_myPaintingImagesPath/lionFram.png";
    static const String turtleFram = "$_myPaintingImagesPath/turtleFram.png";
    static const String bearuncolored = "$_myPaintingImagesPath/bearuncolored.svg";
    static const String beeuncolored = "$_myPaintingImagesPath/beeuncolored.svg";
    static const String coloredduck = "$_myPaintingImagesPath/coloredduck.svg";
    static const String catuncolored = "$_myPaintingImagesPath/catuncolored.svg";
    static const String duckuncolored = "$_myPaintingImagesPath/duckuncolored.svg";
    static const String elephantuncolored = "$_myPaintingImagesPath/elephantuncolored.svg";
    static const String giraffeuncolored = "$_myPaintingImagesPath/giraffeuncolored.svg";
    static const String kangarouncolored = "$_myPaintingImagesPath/kangarouncolored.svg";
    static const String lionBabyuncolored = "$_myPaintingImagesPath/lionBabyuncolored.svg";
    static const String turtleuncolored = "$_myPaintingImagesPath/turtleuncolored.svg";
    static const String lionuncolored = "$_myPaintingImagesPath/lionuncolored.svg";

}


/* logo image */

 Widget logoImage =  SvgPicture.asset(
                        AppImages.logo,
                        height: 128.h,
                      );

 Widget appBarlogoImage = SvgPicture.asset(
                        AppImages.logo,
                        height: 102.h,
                      );
