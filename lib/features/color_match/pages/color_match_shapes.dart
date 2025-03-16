import 'package:color_funland/core/components/animated_container_widget.dart';
import 'package:color_funland/core/components/app_bar_row.dart';
import 'package:color_funland/core/components/three_items_bottom_navigation.dart';
import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ColorMatchShapes extends StatefulWidget {
  const ColorMatchShapes({super.key});

  @override
  State<ColorMatchShapes> createState() => _ColorMixingSamplsState();
}

class _ColorMixingSamplsState extends State<ColorMatchShapes> {
  final GlobalKey<AnimatedContainerState> _containerKey = GlobalKey();

  // Map to track which colors have been correctly placed
  Map<String, bool> colorMatched = {
    'orange': false,
    'blue': false,
    'purple': false,
    'green': false,
    'yellow': false,
    'red': false,
  };

  // Map of colors to their corresponding containers
  final Map<Color, String> colorToContainer = {
    Color(0xffF57615): AppImages.emptyOrangColorMatchShapes,
    Color(0xff0FA6DB): AppImages.emptyBlueColorMatchShapes,
    Color(0xffC373D6): AppImages.emptyPurpleColorMatchShapes,
    Color(0xff78C843): AppImages.emptyGreenColorMatchShapes,
    Color(0xffFFB700): AppImages.emptyYellowColorMatchShapes,
    Color(0xffD74143): AppImages.emptyRedColorMatchShapes,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRow(
        gameGroup: "Color Match",
        inSideGame: true,
        appBarIcon: AppIcons.colorMatchIcon,
        containerKey: _containerKey,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 52.w, left: 46.w),
              child: Column(
                children: [
                  Row(children: [
                    Padding(
                      padding: EdgeInsets.only(left: 37.w),
                      child: InkWell(
                        onTap: () {},
                        child: SizedBox(
                          width: 67.w,
                          height: 67.h,
                          child: SvgPicture.asset(
                            AppIcons.help,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Align(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              "Shapes",
                              style: ts64Magic400,
                            ))),
                  ]),
                  SizedBox(
                    height: 75.5.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 68.5.w),
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Stack(
                        children: [
                          // Target containers
                          _buildTargetContainer(
                              AppImages.emptyOrangColorMatchShapes,
                              0,
                              0,
                              Color(0xffF57615)),
                          _buildTargetContainer(
                              AppImages.emptyBlueColorMatchShapes,
                              174.w,
                              0,
                              Color(0xff0FA6DB)),
                          _buildTargetContainer(
                              AppImages.emptyPurpleColorMatchShapes,
                              174 * 2.w,
                              0,
                              Color(0xffC373D6)),
                          _buildTargetContainer(
                              AppImages.emptyGreenColorMatchShapes,
                              174 * 3.w,
                              0,
                              Color(0xff78C843)),
                          _buildTargetContainer(
                              AppImages.emptyYellowColorMatchShapes,
                              174 * 4.w,
                              0,
                              Color(0xffFFB700)),
                          _buildTargetContainer(
                              AppImages.emptyRedColorMatchShapes,
                              174 * 5.w,
                              0,
                              Color(0xffD74143)),

                          // Draggable color circles
                          Padding(
                            padding: EdgeInsets.only(top: 134.h),
                            child: Align(
                              alignment: AlignmentDirectional.bottomCenter,
                              child: Stack(
                                children: [
                                  _buildDraggableCircle(
                                      Color(0xffF57615), 0.w, 0.h),
                                  _buildDraggableCircle(
                                      Color(0xff0FA6DB), 75.w, -49.h),
                                  _buildDraggableCircle(
                                      Color(0xffC373D6), 101.w, 55.h),
                                  _buildDraggableCircle(
                                      Color(0xffD74143), 101.w, 0.h),
                                  _buildDraggableCircle(
                                      Color(0xffFFB700), 75.w, 20.h),
                                  _buildDraggableCircle(
                                      Color(0xff78C843), 15.w, 37.h),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainerWidget(key: _containerKey),
          ],
        ),
      ),
      bottomNavigationBar: ThreeItemsBottomNavigation(insideGame: true),
    );
  }

  Widget _buildTargetContainer(
      String image, double offsetX, double offsetY, Color targetColor) {
    return Transform.translate(
      offset: Offset(offsetX, offsetY),
      child: DragTarget<Color>(
        builder: (context, candidateData, rejectedData) {
          return Container(
            width: 220.w,
            height: 220.h,
            child: SvgPicture.asset(
              image,
              height: 220,
              width: 220,
              color: colorMatched[_getColorName(targetColor)] == true
                  ? targetColor
                  : null,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
          );
        },
        onWillAccept: (color) => color == targetColor,
        onAccept: (color) {
          setState(() {
            colorMatched[_getColorName(targetColor)] = true;
          });
        },
      ),
    );
  }

  Widget _buildDraggableCircle(Color color, double offsetX, double offsetY) {
    String colorName = _getColorName(color);
    if (colorMatched[colorName] == true) {
      return SizedBox(); // Hide the circle if it's already matched
    }

    return Transform.translate(
      offset: Offset(offsetX, offsetY),
      child: Draggable<Color>(
        data: color,
        child: Container(
          width: 173.w,
          height: 173.h,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        feedback: Container(
          width: 173.w,
          height: 173.h,
          decoration: BoxDecoration(
            color: color.withOpacity(0.8),
            shape: BoxShape.circle,
          ),
        ),
        childWhenDragging: Container(
          width: 173.w,
          height: 173.h,
          decoration: BoxDecoration(
            color: color.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  String _getColorName(Color color) {
    if (color == Color(0xffF57615)) return 'orange';
    if (color == Color(0xff0FA6DB)) return 'blue';
    if (color == Color(0xffC373D6)) return 'purple';
    if (color == Color(0xff78C843)) return 'green';
    if (color == Color(0xffFFB700)) return 'yellow';
    if (color == Color(0xffD74143)) return 'red';
    return '';
  }
}
