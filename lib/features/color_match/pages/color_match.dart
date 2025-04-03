import 'package:color_funland/core/components/animated_container_widget.dart';
import 'package:color_funland/core/components/app_bar_row.dart';
import 'package:color_funland/core/components/three_items_bottom_navigation.dart';
import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/features/color_match/widgets/color_match_widget.dart';
import 'package:color_funland/core/constants/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ColorMatchScreen extends StatefulWidget {
  const ColorMatchScreen({super.key});

  @override
  State<ColorMatchScreen> createState() => _MyPaintingScreenState();
}

class _MyPaintingScreenState extends State<ColorMatchScreen> {
  final GlobalKey<AnimatedContainerState> _containerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBarRow(
          gameGroup: "Color Match",
          inSideGame: true,
          appBarIcon: AppIcons.colorMatchIcon,
          containerKey: _containerKey,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 45.w, right: 51.w),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 102.71.h, horizontal: 180.w),
                  child: SvgPicture.asset(
                    AppImages.colorMatchCardBg,
                    width: 822.w,
                    height: 308.h,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 61.w, right: 67.w, top: 60.71.h, bottom: 60.71.h),
                  child: ColorMatchWidget(
                    items: colorMatchItem,
                    crossAxisCount: 4,
                    gridHeight: 392.h,
                    pageGroup: colorMatchSamplesScreens,
                    insidecategory: true,
                    insideanimals: false,
                    title: '',
                  ),
                ),
              ),
              AnimatedContainerWidget(key: _containerKey),
            ],
          ),
        ),
        bottomNavigationBar: ThreeItemsBottomNavigation(
          insideGame: true,
        ),
      ),
    );
  }
}
