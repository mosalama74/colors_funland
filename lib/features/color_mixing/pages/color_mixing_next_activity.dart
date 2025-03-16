import 'package:color_funland/core/components/animated_container_widget.dart';
import 'package:color_funland/core/components/app_bar_row.dart';
import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:color_funland/core/components/three_items_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ColorMixingNextActivity extends StatefulWidget {
  const ColorMixingNextActivity({super.key});

  @override
  State<ColorMixingNextActivity> createState() => _ColorMixingSamplsState();
}

class _ColorMixingSamplsState extends State<ColorMixingNextActivity> {
  final GlobalKey<AnimatedContainerState> _containerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRow(
        gameGroup: "Color Mixing",
        inSideGame: true,
        appBarIcon: AppIcons.colorMixingIcon,
        containerKey: _containerKey,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 52.w, left: 46.w),
              child: Column(
                children: [
                  Row(children: [
                    Padding(
                      padding: EdgeInsets.only(left: 37.w),
                      child: InkWell(
                        onTap: () {},
                        child: SizedBox(
                          width: 67.w,
                          height: 67.h,
                          child: SvgPicture.asset(
                            AppIcons.help,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Align(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              "Level 1",
                              style: ts64Magic400,
                            ))),
                  ]),
                  SizedBox(
                    height: 27.74.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 68.5.w),
                    child: Container(
                      color: Color(0xffF6EEFA),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppImages.blueColorLevelForMix,
                            height: 166.95.h,
                            width: 180.w,
                          ),
                          SizedBox(
                            width: 70.38.w,
                          ),
                          SvgPicture.asset(
                            AppImages.plus,
                            height: 71.74.h,
                            width: 71.74.w,
                          ),
                          SizedBox(
                            width: 82.w,
                          ),
                          SvgPicture.asset(
                            AppImages.yellowColorLevelForMix,
                            height: 157.77.h,
                            width: 188.73.w,
                          ),
                          SizedBox(
                            width: 70.38,
                          ),
                          SvgPicture.asset(
                            AppImages.equal,
                            width: 71.74,
                            height: 33.86,
                          ),
                          SizedBox(
                            width: 70.38,
                          ),
                          Container(
                            height: 181.68,
                            width: 180,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                              AppImages.mixedColor,
                            ))),
                            child: Center(
                                child: SvgPicture.asset(
                              AppImages.questionMark,
                              width: 35,
                              height: 62,
                            )),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        AppImages.colorLevelGreen,
                        width: 100.w,
                        height: 92.68.h,
                      ),
                      SizedBox(
                        width: 41.w,
                      ),
                      SvgPicture.asset(
                        AppImages.dvider,
                        width: 9.w,
                        height: 40.h,
                      ),
                      SizedBox(
                        width: 41.w,
                      ),
                      SvgPicture.asset(
                        AppImages.colorLevelPurple,
                        width: 100.w,
                        height: 93.25.h,
                      ),
                      SizedBox(
                        width: 41.w,
                      ),
                      SvgPicture.asset(
                        AppImages.dvider,
                        width: 9.w,
                        height: 40.h,
                      ),
                      SizedBox(
                        width: 41.w,
                      ),
                      SvgPicture.asset(
                        AppImages.colorLevelYellow,
                        width: 100.w,
                        height: 92.68.h,
                      )
                    ],
                  )
                ],
              ),
            ),
            AnimatedContainerWidget(
              key: _containerKey,
            ),
          ],
        ),
      ),
      bottomNavigationBar: ThreeItemsBottomNavigation(insideGame: true),
    );
  }
}
