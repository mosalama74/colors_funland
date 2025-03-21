import 'package:color_funland/core/components/app_bar_row.dart';
import 'package:color_funland/core/components/three_items_bottom_navigation.dart';
import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ColorMixingSampls extends StatefulWidget {
  const ColorMixingSampls({super.key, required this.images, required this.width, required this.headText, required this.imageWidth, required this.imageHeight, this.onTap});
final List<String> images;
final double width;
final double imageWidth;
final double imageHeight;
final String headText;
final void Function()? onTap;
  @override
  State<ColorMixingSampls> createState() => _ColorMixingSamplsState();
}

class _ColorMixingSamplsState extends State<ColorMixingSampls> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRow(gameGroup: "Color Mixing", inSideGame: true,appBarIcon: AppIcons.colorMixingIcon,),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text(widget.headText,style: ts64Magic400,)),
          SizedBox(height: 48.h,),
          Container(
            height: 189.42.h,
              padding: EdgeInsets.symmetric(horizontal: 91.w),
              child: ListView.builder(itemBuilder: (context, index) => _Item(image: widget.images[index], width: widget.width,
                  imageWidth: widget.imageWidth,imageHeight:widget.imageHeight ),
                  itemCount: widget.images.length,scrollDirection: Axis.horizontal,shrinkWrap: true,),),
          SizedBox(height: 73.h,),
          InkWell(onTap: widget.onTap,
            child:SvgPicture.asset(AppIcons.practiceBtn) ,)
        ],
      ),
      bottomNavigationBar: ThreeItemsBottomNavigation(insideGame: true),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({ required this.image, required this.width, required this.imageWidth, required this.imageHeight,});
  final String image;
  final double width;
  final double imageWidth;
  final double imageHeight;
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        SvgPicture.asset(image,
          height: imageHeight,
          width: imageWidth,
          // height: 188.68.h, width: 188.73.w,
        ),
        SizedBox(width: width,)
      ],
    );
  }
}
