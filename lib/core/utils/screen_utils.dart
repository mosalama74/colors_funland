import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenUtils {
  static const Size tabletDesignSize = Size(1280, 800);
  static const Size mobileDesignSize = Size(375, 812);

  static bool isTablet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width >= 600;
  }

  static double getHorizontalPadding(BuildContext context) {
    return isTablet(context) ? 40.w : 20.w;
  }

  static double getVerticalPadding(BuildContext context) {
    return isTablet(context) ? 32.h : 16.h;
  }

  static EdgeInsets getScreenPadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: getHorizontalPadding(context),
      vertical: getVerticalPadding(context),
    );
  }

  static double getResponsiveWidth(BuildContext context, double width) {
    return isTablet(context) ? width * 1.5 : width;
  }

  static double getResponsiveHeight(BuildContext context, double height) {
    return isTablet(context) ? height * 1.2 : height;
  }

  static double getFontSize(BuildContext context, double size) {
    return isTablet(context) ? size * 1.2 : size;
  }

  static double getIconSize(BuildContext context, double size) {
    return isTablet(context) ? size * 1.3 : size;
  }
}
