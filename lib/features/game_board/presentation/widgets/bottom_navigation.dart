import 'package:animate_do/animate_do.dart';
import 'package:color_funland/core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
    required this.insideGame,
    this.onBackPressed,
    this.onHomePressed,
    this.onSoundPressed,
  });

  final bool insideGame;
  final VoidCallback? onBackPressed;
  final VoidCallback? onHomePressed;
  final VoidCallback? onSoundPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 63.h),
          child: GestureDetector(
            onTap: onBackPressed,
            child: SizedBox(
                height: 90.82.h,
                width: 227.w,
                child: insideGame == true
                    ? SlideInRight(
                        duration: Duration(milliseconds: 1500),
                        from: 1050,
                        child: SvgPicture.asset(
                          AppIcons.backButton,
                          height: 90.82.h,
                          width: 227.w,
                        ),
                      )
                    : SvgPicture.asset(
                        AppIcons.logoutButton,
                        height: 90.82.h,
                        width: 227.w,
                      )),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 60.78.h),
          child: insideGame == true
              ? GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed("/gameBoard");
                  },
                  child: SizedBox(
                      height: 90.82.h,
                      width: 227.w,
                      child: SvgPicture.asset(AppIcons.homeButton,
                          width: 227.w, height: 90.82.h)),
                )
              : null,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 63.h),
          child: GestureDetector(
            onTap: onSoundPressed,
            child: SizedBox(
                height: 90.82.h,
                width: 227.w,
                child: insideGame == true
                    ? SvgPicture.asset(AppIcons.soundButton,
                        width: 227.w, height: 90.82.h)
                    : SlideInLeft(
                        duration: 1500.milliseconds,
                        from: 1000,
                        child: SvgPicture.asset(AppIcons.soundButton,
                            width: 227.w, height: 90.82.h),
                      )),
          ),
        ),
      ],
    );
  }
}

// GestureDetector(
// onTap: () {
//
// },
// child: Container(
// child: SvgPicture.asset(
// ImageAssets.drawer,
// width: 49,
// height: 49,
// ),)
// ),
