import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AppImages {

/* Landing Page */
  static const String landingBg = "assets/images/landing_page_bg.png";
  static const String landingChildImage = "assets/images/landing_page_img.png";
  /* Login Page */
  static const String loginBg = "assets/images/login_bg.png";
  static const String logo = "assets/images/Logo.svg";

  /* forget Password page */
  static const String gradientBg = "assets/images/gradient_bg.png";
  static const String curvedBtmCardBg = "assets/images/curvedBtmCardBg.png";
}


/* logo image */

 Widget logoImage =  SvgPicture.asset(
                        AppImages.logo,
                        height: 128.h,
                      );
