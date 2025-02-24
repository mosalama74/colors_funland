import 'package:color_funland/core/components/app_bar_row.dart';
import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:color_funland/core/components/three_items_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ColorMixingSampls extends StatefulWidget {
  const ColorMixingSampls({super.key});

  @override
  State<ColorMixingSampls> createState() => _ColorMixingSamplsState();
}

class _ColorMixingSamplsState extends State<ColorMixingSampls> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRow(gameGroup: "Color Mixing", inSideGame: true,appBarIcon: AppIcons.colorMixingIcon,),
      body: Column(
        children: [
          Text("Level 1- 3 Colors",style: ts64Magic400,),
          SizedBox(height: 48.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            SvgPicture.asset(AppImages.colorPurple,height: 188.68.h, width: 188.73.w,),
              SizedBox(width: 82.w,),
              SvgPicture.asset(AppImages.colorRed,height: 188.68.h, width: 188.73.w,),
              SizedBox(width: 82.w,),
              SvgPicture.asset(AppImages.colorGreen,height: 188.68.h, width: 188.73.w,)
          ],),
          SizedBox(height: 73.h,),
          InkWell(onTap: () {
            Navigator.of(context).pushNamed("/colorMixingLevels");
          },
            child:SvgPicture.asset(AppIcons.practiceBtn) ,)
        ],
      ),
      bottomNavigationBar: ThreeItemsBottomNavigation(insideGame: true),
    );
  }
}
