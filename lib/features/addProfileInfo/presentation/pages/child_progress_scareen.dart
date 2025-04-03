import 'package:color_funland/core/components/animated_container_widget.dart';
import 'package:color_funland/core/components/two_items_bottom_navigation.dart';
import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/components/app_bar_row.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:color_funland/features/addProfileInfo/presentation/cubit/profile_info_cubit.dart';
import 'package:color_funland/features/addProfileInfo/presentation/cubit/profile_info_state.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ChildProgressScreen extends StatefulWidget {
  const ChildProgressScreen({super.key});

  @override
  State<ChildProgressScreen> createState() => _ChildProgressScreenState();
}

class _ChildProgressScreenState extends State<ChildProgressScreen> {
  final GlobalKey<AnimatedContainerState> _containerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    int paintingGameCounter = 0;
    int paintingLevelCounter = 1;
    int colorMixingGameCounter = 0;
    int colorMixingLevelCounter = 1;
    int colorMatchGameCounter = 0;
    int colorMatchLevelCounter = 1;
    int learningColorsGameCounter = 0;
    int learningColorsLevelCounter = 1;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetChildDataSuccessState) {
            paintingGameCounter = state.child['paintingGameCounter'] ?? 0;
            paintingLevelCounter = state.child['paintingLevelCounter'] ?? 1;
            colorMixingGameCounter = state.child['colorMixingGameCounter'] ?? 0;
            colorMixingLevelCounter = state.child['colorMixingLevelCounter'] ?? 1;
            colorMatchGameCounter = state.child['colorMatchGameCounter'] ?? 0;
            colorMatchLevelCounter = state.child['colorMatchLevelCounter'] ?? 1;
            learningColorsGameCounter =
                state.child['learningColorsGameCounter'] ?? 0;
            learningColorsLevelCounter =
                state.child['learningColorsLevelCounter'] ?? 1;
          }
          return BlocConsumer<ProfileInfoCubit, ProfileInfoState>(
            listener: (context, state) {  },
            builder: (context, state) {
               if (state is GetChildSuccessState ) {
            paintingGameCounter = state.child['paintingGameCounter'] ?? 0;
            paintingLevelCounter = state.child['paintingLevelCounter'] ?? 1;
            colorMixingGameCounter = state.child['colorMixingGameCounter'] ?? 0;
            colorMixingLevelCounter = state.child['colorMixingLevelCounter'] ?? 1;
            colorMatchGameCounter = state.child['colorMatchGameCounter'] ?? 0;
            colorMatchLevelCounter = state.child['colorMatchLevelCounter'] ?? 1;
            learningColorsGameCounter =
                state.child['learningColorsGameCounter'] ?? 0;
            learningColorsLevelCounter =
                state.child['learningColorsLevelCounter'] ?? 1;
          }
              return Scaffold(
                extendBodyBehindAppBar: true,
                appBar: AppBarRow(
                  gameGroup: "Progress",
                  inSideGame: true,
                  appBarIcon: AppIcons.paintingsIcon,
                  containerKey: _containerKey,
                ),
                body: SafeArea(
                  child: Stack(
                    children: [
                      Container(
                        height: 612.h,
                        width: MediaQuery.sizeOf(context).width,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppImages.progressBg),
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 190.w),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 20.h),
                                  child: ProgressItem(
                                    featureImage: AppIcons.paintingsIcon,
                                    featurName: 'Paintings',
                                    totalLevels: 2,
                                    totalGameNumbers: 10,
                                    currentLevel:
                                        paintingLevelCounter, 
                                    finishedGameNumbers:
                                        paintingGameCounter, 
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 32.h),
                                  child: ProgressItem(
                                    featureImage: AppIcons.colorMixingIcon,
                                    featurName: 'Color Mixing',
                                    totalLevels: 3,
                                    totalGameNumbers: 9,
                                    currentLevel:
                                        colorMixingLevelCounter, 
                                    finishedGameNumbers:
                                        colorMixingGameCounter, 
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 32.h),
                                  child: ProgressItem(
                                    featureImage: AppIcons.colorMatchIcon,
                                    featurName: 'Color Match',
                                    totalLevels: 4,
                                    totalGameNumbers: 4,
                                    currentLevel:
                                        colorMatchLevelCounter, 
                                    finishedGameNumbers:
                                        colorMatchGameCounter, 
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 32.h),
                                  child: ProgressItem(
                                    featureImage: AppIcons.learningcolors,
                                    featurName: 'Learning Colors',
                                    totalLevels: 3,
                                    totalGameNumbers: 9,
                                    currentLevel:
                                        learningColorsLevelCounter, 
                                    finishedGameNumbers:
                                        learningColorsGameCounter, 
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      AnimatedContainerWidget(key: _containerKey),
                    ],
                  ),
                ),
                bottomNavigationBar: Padding(
                  padding: EdgeInsets.only(bottom: 30.h),
                  child: TwoItemsBottomNavigation(
                    insideGame: true,
                    onBackPressed: () => Navigator.pop(context),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ProgressItem extends StatefulWidget {
  const ProgressItem({
    super.key,
    required this.featurName,
    required this.featureImage,
    required this.totalLevels,
    required this.currentLevel,
    required this.totalGameNumbers,
    required this.finishedGameNumbers,
  });
  final String featurName;
  final String featureImage;
  final int totalLevels;
  final int currentLevel;
  final int totalGameNumbers;
  final int finishedGameNumbers;

  @override
  State<ProgressItem> createState() => _ProgressItemState();
}

class _ProgressItemState extends State<ProgressItem> {
  double _value = 0; // Initial slider position



  int _calcPercentage() {
    return (widget.finishedGameNumbers / widget.totalGameNumbers * 100).toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 90.w, right: 125.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                widget.featureImage,
                width: 82.w,
                height: 82.h,
              ),
              SizedBox(
                width: 20.w,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.featurName,
                    style: ts24minnie400,
                  ),
                  Text(
                    '${widget.totalLevels} levels',
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff5B5B5B),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 10, // Adjust track thickness
                  inactiveTrackColor: Colors.grey.shade400, // Background track
                  activeTrackColor: Colors.green, // Hidden for gradient effect
                  thumbColor: Colors.white, // Hidden to use custom thumb
                  overlayColor: Colors.transparent,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 12),
                ),
                child: SizedBox(
                  width: 300.w,
                  child: Slider(
                    min: 0,
                    max: 100,
                    value: _calcPercentage().toDouble(),
                    onChanged: (value) => setState(() => _value = value),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_calcPercentage()}%',
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff000000),
                    ),
                  ),
                  Text(
                    'Level ${widget.currentLevel}',
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff000000),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PaintingProgress {
  static int levelsCounter = 1;
  static int gamesCounter = 0;
   static int lockedPaintingBoardIndex = 0;
   static int lockedanimals = 1;
   static int lockedflowers = 1;

 // Map to track which items have been painted
  static final Map<String, bool> paintedItems = {};
  static final Map<String, bool> completedPaintings = {};

  // Check if an item has been painted
  static bool isPainted(String itemKey) {
    return paintedItems[itemKey] == true;
  }

  // Mark an item as painted
  static void markItemAsPainted(String itemKey) {
    paintedItems[itemKey] = true;
  }

  // Get the correct frame image based on painting status
  static String getFrameImage(String uncoloredFrame, String coloredFrame) {
    return isPainted(uncoloredFrame) ? coloredFrame : uncoloredFrame;
  }

  
}

class ColorMixingProgress {
  static int levelsCounter = 1;
  static int gamesCounter = 0;
     static int lockedIndex = 0;


  ColorMixingProgress(
      int colorMixingLevelsCounter, int colorMixingGamesCounter) {
    levelsCounter = colorMixingLevelsCounter;
    gamesCounter = colorMixingGamesCounter;
  }
}

class ColorMatchProgress {
  static int levelsCounter = 1;
  static int gamesCounter = 0;
     static int lockedIndex = 0;


  ColorMatchProgress(int colorMatchLevelsCounter, int colorMatchGamesCounter) {
    levelsCounter = colorMatchLevelsCounter;
    gamesCounter = colorMatchGamesCounter;
  }
}

class LearningColorsProgress {
  static int levelsCounter = 1;
  static int gamesCounter = 0;
     static int lockedIndex = 0;


  LearningColorsProgress(
      int learningColorsLevelsCounter, int learningColorsGamesCounter) {
    levelsCounter = learningColorsLevelsCounter;
    gamesCounter = learningColorsGamesCounter;
  }
}

