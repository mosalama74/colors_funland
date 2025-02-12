import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/utils/app_colors.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AppBarRow extends StatelessWidget {
  const AppBarRow({
    super.key,
    required this.userName,
    required this.gameGroup,
    required this.inSideGame,
    this.appBarIcon = "",
  });

  final String userName;
  final String gameGroup;
  final bool inSideGame;
  final String appBarIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            appBarlogoImage,
            Row(
              children: [
                Text(
                  userName,
                  style: bubleStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(width: 16.w),
                divider,
                SizedBox(width: 16.w),
                Text(
                  gameGroup,
                  style: ts36minnie400,
                ),
                SizedBox(width: 16.w),
                if (inSideGame)
                  SizedBox(
                    width: 63.w,
                    height: 63.h,
                    child: SvgPicture.asset(appBarIcon),
                  ),
              ],
            ),
            Row(
              children: [
                Stack(children: [
                  SvgPicture.asset(AppImages.yellowshadow,
                      width: 126.w, height: 133.h),
                  Positioned(
                      bottom: 20.25.h,
                      top: 35.75.h,
                      left: 32.w,
                      right: 26.33.w,
                      child: Container(     
                        decoration:_buildContainerDecoration2() ,
                        child: ClipOval(
                          child: CircleAvatar(
                            radius: 36.0, // Radius of the inner CircleAvatar
                            backgroundImage: AssetImage(AppImages.childPhoto)
                          ),
                        ),
                      )),
                ]),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    AppIcons.menu,
                    width: 49.w,
                    height: 49.h,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

BoxDecoration _buildContainerDecoration2() {
  return BoxDecoration(
    shape: BoxShape.circle, // Make it circular
    gradient: LinearGradient(
      colors: [
        AppColors.borderColor,
        AppColors.borderColor2
      ], // Gradient colors for the border
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    border: Border.all(
      width: 4.0, // Border width (thickness of the gradient border)
      color: Colors
          .transparent, // Making the border transparent to only show the gradient
    ),
  );
}


Widget divider = Container(
  width: 4.w,
  height: 35.h,
  color: AppColors.cBlackColor,
);