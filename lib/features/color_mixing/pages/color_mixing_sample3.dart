import 'package:color_funland/core/components/app_bar_row.dart';
import 'package:color_funland/core/components/three_items_bottom_navigation.dart';
import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ColorMixingSampls3 extends StatefulWidget {
  const ColorMixingSampls3({super.key,});

  @override
  State<ColorMixingSampls3> createState() => _ColorMixingSamplsState();
}

class _ColorMixingSamplsState extends State<ColorMixingSampls3> {
  List<String> imageSample3 =[
    AppImages.colorPurple,
    AppImages.colorRed,
    AppImages.colorGreen,
    AppImages.colorYellow,
    AppImages.colorOrange,
    AppImages.colorBrown,
    AppImages.colorBlue,
    AppImages.colorPink,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRow(gameGroup: "Color Mixing", inSideGame: true,appBarIcon: AppIcons.colorMixingIcon,),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text("Level 3- 3 Colors",style: ts64Magic400,)),
          SizedBox(height: 48.h,),
          Container(
            height: 189.42.h,
            padding: EdgeInsets.symmetric(horizontal: 137.w),
            child:
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Stack(
                children: [
                  _Item(image: imageSample3[0], dx: 0,dy: 0),
                  _Item(image: imageSample3[1], dx:121.43,dy: 0),
                  _Item(image: imageSample3[2], dx: 242.86,dy: 0),
                  _Item(image: imageSample3[3], dx: 364.29,dy: 0),
                  _Item(image: imageSample3[4], dx: 485.72,dy: 0),
                  _Item(image: imageSample3[5], dx: 607.15,dy: 0),
                  _Item(image: imageSample3[6], dx: 728.58,dy: 0),
                  _Item(image: imageSample3[7], dx: 850.01,dy: 0),
                ],
              ),
            )
            // ListView.builder(itemBuilder: (context, index) => _Item(image: imageSample3[index], width: 0,),
            //   itemCount:imageSample3.length,scrollDirection: Axis.horizontal,shrinkWrap: true,)
            ),
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

class _Item extends StatelessWidget {
  const _Item({ required this.image, required this.dx, required this.dy,});
  final String image;
  final double dx;
  final double dy;


  @override
  Widget build(BuildContext context) {
    return  Transform.translate(offset: Offset(dx, dy),
        child: SvgPicture.asset(image,height: 149.96.h, width: 150.w,));
  }
}
