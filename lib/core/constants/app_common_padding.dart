import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCommonPadding {

  static final loginPagePadding = EdgeInsets.only(
                top: 64.h, 
                bottom: 27.h, 
                right: 337.w, 
                left: 306.w
              );
  static final forgetPasswordPagePadding =  EdgeInsets.only(
                        left: 77.w, right: 45.w, top: 77.12.h,bottom:115.12.h);

  static final EdgeInsetsGeometry screenOuterPadding =EdgeInsets.only(
                top: 64.h, bottom: 26.h, right: 337.w, left: 306.w);


  static final EdgeInsetsGeometry screenInnerPadding =EdgeInsets.symmetric(
                        horizontal: 61.w, vertical: 41.62.h);

}
