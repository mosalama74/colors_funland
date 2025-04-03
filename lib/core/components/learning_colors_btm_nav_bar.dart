import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/constants/app_images.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LearningColorsBtmNavBar extends StatefulWidget {
  const LearningColorsBtmNavBar({
    super.key,
    this.onBackPressed,
    this.onNextPressed,
     required this.isVideoCompleted,
  });

  final VoidCallback? onBackPressed;
  final VoidCallback? onNextPressed;
  final bool isVideoCompleted;

  @override
  _LearningColorsBtmNavBarState createState() =>
      _LearningColorsBtmNavBarState();
}

class _LearningColorsBtmNavBarState extends State<LearningColorsBtmNavBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: Stack(
        children: [
          twoItemsBtmNavBar(),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed("/gameBoard");
              },
              child: SvgPicture.asset(AppIcons.homeButton,
                  width: 227.w, height: 90.82.h),
            ),
          ),
        ],
      ),
    );
  }

  Padding twoItemsBtmNavBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(34.51.w, 0, 34.51.w, 0),
      child: SizedBox(
        height: 86.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: widget.onBackPressed,
                child: SvgPicture.asset(
                  AppIcons.backButton,
                  height: 81.07.h,
                  width: 79.08.w,
                )),
            if (widget.isVideoCompleted)
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: widget.onNextPressed,
                child: SvgPicture.asset(
                  AppImages.nextbtn,
                  width: 120.w,
                  height: 80.h,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
