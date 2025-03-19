import 'package:color_funland/core/components/app_bar_row.dart';
import 'package:color_funland/core/components/three_items_bottom_navigation.dart';
import 'package:color_funland/core/components/win_screen.dart';
import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ColorMixingLevels1 extends StatefulWidget {
  const ColorMixingLevels1(
      {super.key,
      required this.firstColor,
      required this.secondColor,
      required this.resultColor,
      this.onAccept,
      required this.imageColor,
      required this.chosseImageColor1,
      required this.chosseImageColor2,
      required this.chosseImageColor3,
      required this.levelNumber});
  final Color firstColor;
  final Color secondColor;
  final Color resultColor;
  final String imageColor;
  final String chosseImageColor1;
  final String chosseImageColor2;
  final String chosseImageColor3;
  final String levelNumber;

  final void Function(String)? onAccept;

  @override
  State<ColorMixingLevels1> createState() => _ColorMixingSamplsState();
}

class _ColorMixingSamplsState extends State<ColorMixingLevels1> {
  bool isCorrectColorPlaced = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRow(
        gameGroup: "Color Mixing",
        inSideGame: true,
        appBarIcon: AppIcons.colorMixingIcon,
      ),
      body: Padding(
        padding: EdgeInsets.only(right: 52.w, left: 46.w),
        child: Column(
          children: [
            Text(
              widget.levelNumber,
              style: ts64Magic400,
            ),
            SizedBox(
              height: 27.74.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 68.5.w),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                color: Color(0xffF6EEFA),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppImages.blueColorLevelForMix,
                      height: 166.95.h,
                      color: widget.firstColor,
                      width: 180.w,
                    ),
                    SizedBox(
                      width: 70.38.w,
                    ),
                    SvgPicture.asset(
                      AppImages.plus,
                      height: 71.74.h,
                      width: 71.74.w,
                    ),
                    SizedBox(
                      width: 82.w,
                    ),
                    SvgPicture.asset(
                      AppImages.redColorLevelForMix,
                      color: widget.secondColor,
                      height: 157.77.h,
                      width: 188.73.w,
                    ),
                    SizedBox(
                      width: 70.38,
                    ),
                    SvgPicture.asset(
                      AppImages.equal,
                      width: 71.74,
                      height: 33.86,
                    ),
                    SizedBox(
                      width: 70.38,
                    ),
                    DragTarget<String>(
                      builder: (context, candidateData, rejectedData) {
                        return SizedBox(
                          height: 181.68,
                          width: 180,
                          child: isCorrectColorPlaced
                              ? SizedBox(
                                  width: 180,
                                  height: 181.68,
                                  child: Image.asset(
                                    AppImages.mixedColored,
                                    width: 180,
                                    color: widget.resultColor,
                                    height: 181.68,
                                    fit: BoxFit.contain,
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(AppImages.mixedColor),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      AppImages.questionMark,
                                      width: 35,
                                      height: 62,
                                    ),
                                  ),
                                ),
                        );
                      },
                      onWillAccept: (data) =>
                          data == widget.imageColor && !isCorrectColorPlaced,
                      onAccept: (data) {
                        setState(() {
                          isCorrectColorPlaced = true;
                        });
                        //level 1
                        if (widget.firstColor == Color(0xff325EDA) &&
                            widget.secondColor == Color(0xffE80D15))
                          Future.delayed(
                            Duration(seconds: 1),
                            () => Navigator.pushNamed(
                                context, "/colorMixingLevels1-2"),
                          );
                        else if (widget.firstColor == Color(0xff325EDA) &&
                            widget.secondColor == Color(0xffF6CA43))
                          Future.delayed(
                            Duration(seconds: 1),
                            () => Navigator.pushNamed(
                                context, "/colorMixingLevels1-3"),
                          );
                        else if (widget.firstColor == Color(0xffEA0606) &&
                            widget.secondColor == Color(0xffF6CA43))
                          //   Future.delayed(Duration(seconds: 1),() => Navigator.pushNamed(context, "/colorMixingLevels1-4"),);
                          // else if(widget.firstColor==Color(0xffEA0606)&&widget.secondColor ==Color(0xff368727))
                          showWinScreen(
                            context,
                            () => Navigator.pushNamed(
                                context, "/colorMixingScreen"),
                          );
                        //level 2
                        else if (widget.firstColor == Color(0xff77398A) &&
                            widget.secondColor == Color(0xffE80D15))
                          Future.delayed(
                            Duration(seconds: 1),
                            () => Navigator.pushNamed(
                                context, "/colorMixingLevels2-2"),
                          );
                        else if (widget.firstColor == Color(0xff019A00) &&
                            widget.secondColor == Color(0xff0051D4))
                          Future.delayed(
                            Duration(seconds: 1),
                            () => Navigator.pushNamed(
                                context, "/colorMixingLevels3-2"),
                          );
                        else if (widget.firstColor == Color(0xffFF7F00) &&
                            widget.secondColor == Color(0xffF6CA43))
                          showWinScreen(
                            context,
                            () => Navigator.pushNamed(
                                context, "/colorMixingScreen"),
                          );
                        //level 3
                        else if (widget.firstColor == Color(0xffDB1D00) &&
                            widget.secondColor == Color(0xffF66F00))
                          Future.delayed(
                            Duration(seconds: 1),
                            () => Navigator.pushNamed(
                                context, "/colorMixingLevels2-3"),
                          );
                        else if (widget.firstColor == Color(0xffFDED00) &&
                            widget.secondColor == Color(0xff4E8D4B))
                          Future.delayed(
                            Duration(seconds: 1),
                            () => Navigator.pushNamed(
                                context, "/colorMixingLevels3-3"),
                          );
                        else if (widget.firstColor == Color(0xff002AFF) &&
                            widget.secondColor == Color(0xff553245))
                          showWinScreen(
                            context,
                            () => Navigator.pushNamed(
                                context, "/colorMixingScreen"),
                          );
                      },
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Draggable<String>(
                  data: widget.chosseImageColor1,
                  feedback: SvgPicture.asset(
                    widget.chosseImageColor1,
                    width: 100.w,
                    height: 92.68.h,
                  ),
                  childWhenDragging: SvgPicture.asset(
                    widget.chosseImageColor1,
                    width: 100.w,
                    height: 92.68.h,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  child: SvgPicture.asset(
                    widget.chosseImageColor1,
                    width: 100.w,
                    height: 92.68.h,
                    color: isCorrectColorPlaced &&
                            widget.imageColor == widget.chosseImageColor1
                        // &&widget.firstColor==Color(0xff325EDA)&&widget.secondColor==Color(0xffF6CA43)
                        ? Colors.grey.withOpacity(0.3)
                        : null,
                  ),
                ),
                SizedBox(
                  width: 41.w,
                ),
                SvgPicture.asset(
                  AppImages.dvider,
                  width: 9.w,
                  height: 40.h,
                ),
                SizedBox(
                  width: 41.w,
                ),
                Draggable<String>(
                  data: widget.chosseImageColor2,
                  feedback: SvgPicture.asset(
                    widget.chosseImageColor2,
                    width: 100.w,
                    height: 93.25.h,
                  ),
                  childWhenDragging: SvgPicture.asset(
                    widget.chosseImageColor2,
                    width: 100.w,
                    height: 93.25.h,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  child: SvgPicture.asset(
                    widget.chosseImageColor2,
                    width: 100.w,
                    height: 93.25.h,
                    color: isCorrectColorPlaced &&
                            widget.imageColor == widget.chosseImageColor2
                        // &&widget.firstColor==Color(0xff325EDA)&&widget.secondColor==Color(0xffE80D15)
                        ? Colors.grey.withOpacity(0.3)
                        : null,
                  ),
                ),
                SizedBox(
                  width: 41.w,
                ),
                SvgPicture.asset(
                  AppImages.dvider,
                  width: 9.w,
                  height: 40.h,
                ),
                SizedBox(
                  width: 41.w,
                ),
                Draggable<String>(
                  data: widget.chosseImageColor3,
                  feedback: SvgPicture.asset(
                    widget.chosseImageColor3,
                    width: 100.w,
                    height: 92.68.h,
                  ),
                  childWhenDragging: SvgPicture.asset(
                    widget.chosseImageColor3,
                    width: 100.w,
                    height: 92.68.h,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  child: SvgPicture.asset(
                    widget.chosseImageColor3,
                    width: 100.w,
                    height: 92.68.h,
                    color: isCorrectColorPlaced &&
                            widget.imageColor == widget.chosseImageColor3
                        // && widget.firstColor==Color(0xffEA0606)&&widget.secondColor==Color(0xffF6CA43)
                        ? Colors.grey.withOpacity(0.3)
                        : null,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: ThreeItemsBottomNavigation(insideGame: true),
    );
  }
}
