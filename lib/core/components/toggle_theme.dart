import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToggleTheme extends StatefulWidget {
  const ToggleTheme({super.key});

  // Use a ValueNotifier to notify UI updates
  static final ValueNotifier<bool> isLight = ValueNotifier(false);
  
  static bool isLightMode() => isLight.value;

  @override
  _ToggleThemeState createState() => _ToggleThemeState();
}

class _ToggleThemeState extends State<ToggleTheme> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: ToggleTheme.isLight,
      builder: (context, isLightMode, child) {
        return GestureDetector(
          onTap: () {
            ToggleTheme.isLight.value = !ToggleTheme.isLight.value;
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 63.w,
            height: 36.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(
                  isLightMode ?  AppImages.switchbutton : AppImages.switchbuttonfalse ,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  left: isLightMode ? 30.w : 2.w,
                  top: 2.h,
                  child: Image.asset(
                    isLightMode ? AppIcons.darkIcon : AppIcons.lightIcon,
                    width: 32.38.w,
                    height: 32.38.h,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
