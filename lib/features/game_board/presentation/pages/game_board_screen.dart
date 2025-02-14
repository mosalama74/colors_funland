import 'package:color_funland/color_funland_app.dart';
import 'package:color_funland/core/components/animated_container_widget.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/components/app_bar_row.dart';
import 'package:color_funland/features/game_board/presentation/widgets/two_items_bottom_navigation.dart';
import 'package:color_funland/features/game_board/presentation/widgets/games_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GameBoardScreen extends StatelessWidget {
  const GameBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return orientation == Orientation.landscape
            ? _buildLandscapeLayout()
            : _buildPortraitLayout();
      },
    );
  }

  Widget _buildLandscapeLayout() {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.lightGameBoard),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBarRow(
            gameGroup: "Activity Board",
            inSideGame: false,
            onTap: () {
              containerKey.currentState?.toggleContainer();
            },
          ),
          body: Stack(
              children: [
                SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 31.84.h),
                        child: const Games(),
                      ),
                      TwoItemsBottomNavigation(
                        insideGame: false,
                      ),
                    ],
                  ),
                ),
                AnimatedContainerWidget(key: containerKey),
              ],
            ),
          ),
        ),
     
    );
  }

  Widget _buildPortraitLayout() {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Image.asset(
        "assets/images/maskgroup.png",
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
