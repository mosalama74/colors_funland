import 'package:color_funland/core/components/animated_container_widget.dart';
import 'package:color_funland/core/components/two_items_bottom_navigation.dart';
import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/components/app_bar_row.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
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
                            numOfLevels: '8',
                                                      ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 32.h),
                          child: ProgressItem(
                            featureImage: AppIcons.colorMixingIcon,
                            featurName: 'Color Mising',
                            numOfLevels: '8',
                                                      ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 32.h),
                          child: ProgressItem(
                            featureImage: AppIcons.colorMatchIcon,
                            featurName: 'Color Match',
                            numOfLevels: '8',
                                                      ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 32.h),
                          child: ProgressItem(
                            featureImage: AppIcons.learningcolors,
                            featurName: 'Learning Colors',
                            numOfLevels: '8',
                            
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
          padding: EdgeInsets.only(bottom: 50.h),
          child: TwoItemsBottomNavigation(
            insideGame: true,
            onBackPressed: () => Navigator.pop(context),
          ),
        ),
      ),
    );
  }
}

class ProgressItem extends StatefulWidget {
  const ProgressItem(
      {super.key,
      required this.featurName,
      required this.featureImage,
      required this.numOfLevels,
      });
  final String featurName;
  final String featureImage;
  final String numOfLevels;

  @override
  State<ProgressItem> createState() => _ProgressItemState();
}

class _ProgressItemState extends State<ProgressItem> {
  double _value = 10; // Initial slider position

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 90.w,right: 125.w),
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
                    '${widget.numOfLevels} levels',
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
                      const RoundSliderThumbShape(enabledThumbRadius: 14),
                ),
                child: SizedBox(
                  width: 300.w,
                  child: Slider(
                    min: 0,
                    max: 50,
                    value: _value,
                    onChanged: (newValue) {
                      setState(() {
                        _value = newValue;
                        print(_value);
                      });
                    },
                  ),
                ),
              ),
              
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '44/100',
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff000000),
                    ),
                  ),
                  Text(
                    'Level 3',
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
