import 'package:color_funland/core/components/animated_container_widget.dart';
import 'package:color_funland/core/components/app_bar_row.dart';
import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/components/three_items_bottom_navigation.dart';
import 'package:color_funland/core/constants/model.dart';
import 'package:color_funland/features/learning_colors/widgets/learning_colors_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LearningColorsBoard extends StatefulWidget {
  const LearningColorsBoard({super.key});

  @override
  State<LearningColorsBoard> createState() => _LearningColorsBoardState();
}

class _LearningColorsBoardState extends State<LearningColorsBoard> {
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
          gameGroup: "Learning Colors",
          inSideGame: true,
          appBarIcon: AppIcons.learningcolors,
          containerKey: _containerKey,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 29.w,vertical: 48.68.h),
                child: Center(
                  child: LearningColorsWidget(
                    items: learningColorsItem,
                    crossAxisCount: 3,
                    gridHeight: 416.h,
                    pageGroup: learningColorsLessons,
                    insidecategory: true,
                    insideanimals: false,
                    title: '',
                  ),
                ),
              ),
              AnimatedContainerWidget(
                key: _containerKey,
              ),
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
