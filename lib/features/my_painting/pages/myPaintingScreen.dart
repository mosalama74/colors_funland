import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/features/game_board/presentation/widgets/app_bar_row.dart';
import 'package:color_funland/features/game_board/presentation/widgets/bottom_navigation.dart';
import 'package:color_funland/features/my_painting/model.dart';
import 'package:color_funland/features/my_painting/widgets/painting_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyPaintingScreen extends StatefulWidget {
  const MyPaintingScreen({super.key});

  @override
  State<MyPaintingScreen> createState() => _MyPaintingScreenState();
}

class _MyPaintingScreenState extends State<MyPaintingScreen> {
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
            padding: const EdgeInsets.symmetric(horizontal: 60),
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
                    PaintingWidget(
                      items: gridItems,
                      crossAxisCount: 4,
                      spacing: 16,
                      pageGroup: myPaintingScreen,
                      leftImage: AppImages.paintingGirl,
                      insidecategory: true,
                      insideanimals: false,
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
