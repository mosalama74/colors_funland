import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/features/game_board/presentation/widgets/app_bar_row.dart';
import 'package:color_funland/features/game_board/presentation/widgets/bottom_navigation.dart';
import 'package:color_funland/features/my_painting/model.dart';
import 'package:color_funland/features/my_painting/widgets/painting_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

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
            padding: EdgeInsets.only(left: 45.w, right: 51.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppBarRow(
                  userName: "Adam",
                  gameGroup: "Paintings",
                  inSideGame: true,
                  appBarIcon: AppIcons.paintingsIcon,
                ),
                SizedBox(
                  height:499.h,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppImages.paintingGirl,
                        height: 358.65.h,
                        width: 313.29.w,
                      ),
                      SizedBox(
                        width: 32.w,
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 95.5.h),
                              child: Image.asset(AppImages.myPaintingCardBg,width: 822.w,),
                            ),
                            PaintingWidget(
                              items: gridItems,
                              crossAxisCount: 4,
                              pageGroup: myPaintingSamples,
                              insidecategory: true,
                              insideanimals: false,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 7.71.h,),
                BottomNavigation(
                            insideGame: true,
                            onBackPressed: () => Navigator.pop(context),
                          ),
              ],
            ),
          ),
        ),
       
      ),
    );
  }
}
