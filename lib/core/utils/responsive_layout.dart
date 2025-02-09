import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget portrait;
  final Widget landscape;

  const ResponsiveLayout({
    Key? key,
    required this.portrait,
    required this.landscape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return orientation == Orientation.portrait ? portrait : landscape;
      },
    );
  }
}

class ResponsiveUtils {
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static bool isSmallScreen(BuildContext context) {
    return screenWidth(context) < 600;
  }

  static bool isMediumScreen(BuildContext context) {
    return screenWidth(context) >= 600 && screenWidth(context) < 900;
  }

  static bool isLargeScreen(BuildContext context) {
    return screenWidth(context) >= 900;
  }

  static double responsiveFontSize(BuildContext context, double baseSize) {
    double scaleFactor = isSmallScreen(context) ? 1.0 : 
                        isMediumScreen(context) ? 1.2 : 1.4;
    return baseSize * scaleFactor;
  }

  static EdgeInsets responsivePadding(BuildContext context) {
    double horizontalPadding = isSmallScreen(context) ? 16.0 : 
                              isMediumScreen(context) ? 24.0 : 32.0;
    double verticalPadding = isSmallScreen(context) ? 12.0 : 
                            isMediumScreen(context) ? 16.0 : 24.0;
    
    return EdgeInsets.symmetric(
      horizontal: horizontalPadding,
      vertical: verticalPadding,
    );
  }

  static double responsiveIconSize(BuildContext context) {
    return isSmallScreen(context) ? 24.0 : 
           isMediumScreen(context) ? 32.0 : 40.0;
  }
}
