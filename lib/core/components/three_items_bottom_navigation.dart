import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/components/two_items_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ThreeItemsBottomNavigation extends StatelessWidget {
  const ThreeItemsBottomNavigation({
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
    return  SizedBox(
          height: 120.h,
          child: Stack(
            children: [
              TwoItemsBottomNavigation(
                insideGame: true,
                onBackPressed: () => Navigator.pop(context),
              ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacementNamed("/gameBoard");
                              },
                              child: SvgPicture.asset(AppIcons.homeButton,
                                  width: 227.w, height: 90.82.h),
                            ),
            ),
            ],
          ),
        );
  }
}
