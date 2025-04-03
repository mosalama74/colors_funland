import 'package:color_funland/core/components/animated_container_widget.dart';
import 'package:color_funland/core/components/app_bar_row.dart';
import 'package:color_funland/core/components/three_items_bottom_navigation.dart';
import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LearningColorsLessons extends StatefulWidget {
  const LearningColorsLessons({
    super.key,
    required this.images,
    required this.headText,
    required this.lessonImage,
    required this.headText2,
  });
  final List<String> images;
  final String headText;
  final String headText2;
  final String lessonImage;

  @override
  State<LearningColorsLessons> createState() => _LearningColorsLessonsState();
}

class _LearningColorsLessonsState extends State<LearningColorsLessons> {
  final GlobalKey<AnimatedContainerState> _containerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRow(
        gameGroup: "Learning Colors",
        inSideGame: true,
        appBarIcon: AppIcons.learningcolors,
        containerKey: _containerKey,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 46.w, right: 52.w),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: Text(
                  widget.headText,
                  style: ts64Magic400,
                )),
                Center(
                    child: Text(
                  widget.headText2,
                  style: ts32minnie400.copyWith(letterSpacing: 15.sp),
                )),
                SizedBox(
                  height: 24.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.42.w),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        widget.lessonImage,
                        height: 351.h,
                        width: 366.w,
                      ),
                      SizedBox(
                        height: 295.97.h,
                        child: ListView.builder(
                          itemBuilder: (context, index) => buildItem(
                            image: widget.images[index],
                            onTap: () {
                              if (index == 0) {
                                Navigator.pushNamed(context, '/redLessonVideo');
                              } else if (index == 1) {
                                Navigator.pushNamed(context, '/greenLessonVideo');
                              } else if (index == 2) {
                                Navigator.pushNamed(context, '/blueLessonVideo');
                              }
                            },
                          ),
                          itemCount: widget.images.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AnimatedContainerWidget(
            key: _containerKey,
          ),
        ],
      ),
      bottomNavigationBar: ThreeItemsBottomNavigation(insideGame: true),
    );
  }
}

Widget buildItem({required String image, required void Function()? onTap}) {
  return Padding(
    padding: EdgeInsets.only(right: 24.w),
    child: InkWell(
      onTap: onTap,
      child: SvgPicture.asset(
        image,
        height: 200.h,
        width: 220.w,
        fit: BoxFit.contain,
      ),
    ),
  );
}
