import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/features/game_board/presentation/widgets/app_bar_row.dart';
import 'package:color_funland/features/game_board/presentation/widgets/three_items_bottom_navigation.dart';
import 'package:color_funland/features/my_painting/model.dart';
import 'package:color_funland/features/my_painting/widgets/painting_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyPaintingSamples extends StatefulWidget {
  const MyPaintingSamples({super.key});

  @override
  State<MyPaintingSamples> createState() => _MyPaintingSamplesState();
}

class _MyPaintingSamplesState extends State<MyPaintingSamples> {
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
          gameGroup: "Paintings",
          inSideGame: true,
          appBarIcon: AppIcons.paintingsIcon,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 46.w, right: 52.w),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48.09.w),
                  child: Expanded(
                    child: PaintingWidget(
                      gridHeight: 400.h,
                      items: paintingAnimals,
                      crossAxisCount: 5,
                      pageGroup: paintingScreen,
                      insidecategory: false,
                      insideanimals: true,
                      childAspectRatio: 1 /.98,
                    ),
                  ),
                ),
               
              ],
            ),
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
