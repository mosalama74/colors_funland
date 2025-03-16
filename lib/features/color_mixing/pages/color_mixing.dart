import 'package:color_funland/core/components/animated_container_widget.dart';
import 'package:color_funland/core/components/app_bar_row.dart';
import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/features/color_mixing/widgets/color_mixing_widget.dart';
import 'package:color_funland/core/components/three_items_bottom_navigation.dart';
import 'package:color_funland/features/my_painting/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorMixingScreen extends StatefulWidget {
  const ColorMixingScreen({super.key});

  @override
  State<ColorMixingScreen> createState() => _ColorMixingScreenState();
}

class _ColorMixingScreenState extends State<ColorMixingScreen> {
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
          gameGroup: "Color Mixing",
          inSideGame: true,
          appBarIcon: AppIcons.colorMixingIcon,
          containerKey: _containerKey,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 45.w,
                  right: 51.w,
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 8.7.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        AppImages.colorMixingGirl2,
                        height: 430.78.h,
                        width: 393.49.w,
                      ),
                      SizedBox(
                        width: 32.w,
                      ),
                      ColorMixingWidget(
                        items: colorMixingItem,
                        crossAxisCount: 3,
                        gridHeight: 496.h,
                        pageGroup: colorMixingSamples,
                        insidecategory: true,
                        insideanimals: false,
                        title: '',
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedContainerWidget(key: _containerKey,),
            ],
          ),
        ),
        bottomNavigationBar: ThreeItemsBottomNavigation(
          insideGame: true,
          onBackPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
