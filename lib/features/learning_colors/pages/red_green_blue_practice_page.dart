import 'package:color_funland/core/components/app_bar_row.dart';
import 'package:color_funland/core/components/learning_colors_btm_nav_bar.dart';
import 'package:color_funland/core/components/win_screen.dart';
import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/constants/model.dart';
import 'package:color_funland/features/addProfileInfo/presentation/cubit/profile_info_cubit.dart';
import 'package:color_funland/features/addProfileInfo/presentation/pages/child_progress_scareen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RedGreenBluePracticePage extends StatefulWidget {
  const RedGreenBluePracticePage({
    super.key,
    required this.images,
    required this.lessonImage,
  });
  final List<String> images;
  final String lessonImage;

  @override
  State<RedGreenBluePracticePage> createState() =>
      _RedGreenBluePracticePageState();
}

class _RedGreenBluePracticePageState extends State<RedGreenBluePracticePage> {
  void _increaseCounterGame() {
    setState(() {
      if (LearningColorsProgress.gamesCounter < 9) {
        LearningColorsProgress.gamesCounter++;
      }
    });
  }

  void _increaseLevelCounter() {
    setState(() {
      if (LearningColorsProgress.gamesCounter < 9) {
        LearningColorsProgress.levelsCounter++;
      }
    });
  }

  final List<String> redTargetList = [];
  final List<String> greenTargetList = [];
  final List<String> blueTargetList = [];

  Map<String, bool> checkedImages = {}; // Tracks checked images

  void checkColorMatching(String selectedImage) {
    setState(() {
      if (widget.lessonImage == AppImages.redlesson) {
        bool isRed =
            redImagesGroub[AppImages.redlesson]?.contains(selectedImage) ??
                false;
        // Mark the image as checked
        checkedImages[selectedImage] = isRed;
        // Add only if it's red and not already in the list
        if (isRed && !redTargetList.contains(selectedImage)) {
          redTargetList.add(selectedImage);
        }
      }

      if (widget.lessonImage == AppImages.greenlesson) {
        bool isGreen =
            greenImagesGroub[AppImages.greenlesson]?.contains(selectedImage) ??
                false;
        checkedImages[selectedImage] = isGreen;
        if (isGreen && !greenTargetList.contains(selectedImage)) {
          greenTargetList.add(selectedImage);
        }
      }

      if (widget.lessonImage == AppImages.bluelesson) {
        bool isBlue =
            blueImagesGroub[AppImages.bluelesson]?.contains(selectedImage) ??
                false;
        checkedImages[selectedImage] = isBlue;
        if (isBlue && !blueTargetList.contains(selectedImage)) {
          blueTargetList.add(selectedImage);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRow(
        gameGroup: "Learning Colors",
        inSideGame: true,
        appBarIcon: AppIcons.learningcolors,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 49.w),
        child: Center(
          child: SizedBox(
            height: 421.h,
            child: Row(
              children: [
                Column(
                  children: [
                    SvgPicture.asset(
                      widget.lessonImage,
                      height: 351.h,
                      width: 366.w,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        AppImages.playsongbtn,
                        height: 59.h,
                        width: 224.w,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 50.w, right: 50.w, top: 50.h),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: .80 / .60,
                          mainAxisSpacing: 10.h,
                          crossAxisSpacing: 0.w),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        String image = widget.images[index];
                        return buildItem(
                          image: image,
                          isChecked: checkedImages[image] ?? false, // Use Map
                          onTap: () {
                            checkColorMatching(image);
                          },
                        );
                      },
                      itemCount: widget.images.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: LearningColorsBtmNavBar(
        isVideoCompleted: true,
        onBackPressed: () {
          Navigator.pop(context);
        },
        onNextPressed: () {
          setState(() {
            if (widget.lessonImage == AppImages.redlesson &&
                redTargetList.length ==
                    redImagesGroub[AppImages.redlesson]?.length) {
              if (LearningColorsProgress.gamesCounter < 1) {
                _increaseCounterGame();
                context.read<ProfileInfoCubit>().updateLearningColorsProgress(
                    learningColorsGameCounter:
                        LearningColorsProgress.gamesCounter,
                    learningColorsLevelCounter:
                        LearningColorsProgress.levelsCounter);
              }
              showWinScreen(
                context,
                () => Navigator.pushReplacementNamed(
                    context, "/learningColorslesson1"),
              );
            }

            if (widget.lessonImage == AppImages.greenlesson &&
                greenTargetList.length ==
                    greenImagesGroub[AppImages.greenlesson]?.length) {
              if (LearningColorsProgress.gamesCounter < 2) {
                _increaseCounterGame();
                context.read<ProfileInfoCubit>().updateLearningColorsProgress(
                    learningColorsGameCounter:
                        LearningColorsProgress.gamesCounter,
                    learningColorsLevelCounter:
                        LearningColorsProgress.levelsCounter);
              }
              showWinScreen(
                context,
                () => Navigator.pushReplacementNamed(
                    context, "/learningColorslesson1"),
              );
            }

            if (widget.lessonImage == AppImages.bluelesson &&
                blueTargetList.length ==
                    blueImagesGroub[AppImages.bluelesson]?.length) {
              if (LearningColorsProgress.gamesCounter < 3) {
                _increaseCounterGame();
                _increaseLevelCounter();
                LearningColorsProgress.lockedIndex = 1;
                context.read<ProfileInfoCubit>().updateLearningColorsProgress(
                    learningColorsGameCounter:
                        LearningColorsProgress.gamesCounter,
                    learningColorsLevelCounter:
                        LearningColorsProgress.levelsCounter);
              }
              showWinScreen(
                context,
                () => Navigator.pushReplacementNamed(
                    context, "/learningColorsboard"),
              );
            }
          });
        },
      ),
    );
  }
}

Widget buildItem(
    {required String image,
    required void Function()? onTap,
    required bool isChecked}) {
  return InkWell(
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    onTap: onTap,
    child: Stack(
      children: [
        Image.asset(
          image,
          height: 200.h,
          width: 220.w,
          fit: BoxFit.contain,
        ),
        if (isChecked)
          Positioned(
            top: 20.h,
            right: 20.w,
            child: Icon(Icons.check_box, color: Colors.green, size: 30),
          ),
      ],
    ),
  );
}
