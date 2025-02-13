import 'package:animate_do/animate_do.dart';
import 'package:color_funland/core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TwoItemsBottomNavigation extends StatelessWidget {
  const TwoItemsBottomNavigation({
    super.key,
    required this.insideGame,
    this.onBackPressed,
    this.onSoundPressed,
  });

  final bool insideGame;
  final VoidCallback? onBackPressed;
  final VoidCallback? onSoundPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 34.51.w),
      child: SizedBox(
        height: 81.07.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onBackPressed,
              child: insideGame == true
                  ? SlideInRight(
                      duration: Duration(milliseconds: 1500),
                      from: 1050,
                      child: SvgPicture.asset(
                        AppIcons.backButton,
                        height: 81.07.h,
                        width: 79.08.w,
                      ),
                    )
                  : SvgPicture.asset(
                      AppIcons.logoutButton,
                      height: 90.82.h,
                      width: 227.w,
                    ),
            ),
            
            GestureDetector(
              onTap: onSoundPressed,
              child: insideGame == true
                  ? SvgPicture.asset(
                      AppIcons.soundButton,
                       width: 79.08.w,
                        height: 81.07.h,
                    )
                  : SlideInLeft(
                      duration: 1500.milliseconds,
                      from: 1000,
                      child: SvgPicture.asset(
                        AppIcons.soundButton,
                        width: 79.08.w,
                        height: 81.07.h,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
