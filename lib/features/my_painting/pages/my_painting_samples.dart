import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/features/game_board/presentation/widgets/app_bar_row.dart';
import 'package:color_funland/features/game_board/presentation/widgets/bottom_navigation.dart';
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
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 46.w, right: 52.w),
            child: Column(
              children: [
                Column(
                  children: [
                    AppBarRow(
                      userName: "Adam",
                      gameGroup: "Paintings",
                      inSideGame: true,
                      appBarIcon: AppIcons.paintingsIcon,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 48.09.w),
                      child: PaintingWidget(
                        items: paintingAnimals,
                        crossAxisCount: 5,
                        pageGroup: myPaintingScreen,
                        insidecategory: false,
                        insideanimals: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigation(
          insideGame: true,
          onBackPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
