import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/utils/app_colors.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:color_funland/features/my_painting/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PaintingWidget extends StatelessWidget {
  final List<GridItem> items;
  final int crossAxisCount;
  final double spacing;
  final String leftImage;
  final double hieght;
  final List<String> pageGroup;
  final double width;
  final bool insidecategory;
  final bool insideanimals;

  const PaintingWidget(
      {super.key,
      required this.items,
      required this.crossAxisCount,
      required this.spacing,
      required this.leftImage,
      this.hieght = 300,
      this.width = 313,
      required this.insidecategory,
      required this.pageGroup,
      required this.insideanimals});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 440.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          insidecategory == true
              ? Padding(
                  padding: EdgeInsets.only(right: 32.w),
                  child: SvgPicture.asset(AppImages.paintingGirl,
                      height: hieght, width: width),
                )
              : Container(),
          Expanded(
            child: Column(
              children: [
                insideanimals == true
                    ? Text(
                        'Animals',
                        textAlign: TextAlign.center,
                        style: ts64Magic400,
                      )
                    : Container(),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount),
                    itemBuilder: (context, index) => _buildPaintingItem(
                      item: GridItem(
                        title: items[index].title,
                        imageUrl: items[index].imageUrl,
                        onTap: () {
                          Navigator.of(context).pushNamed(pageGroup[index]);
                        },
                      ),
                    ),
                    itemCount: items.length,
                    padding: EdgeInsets.fromLTRB(0, 17.21.h, 55.21, 13.67.h),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaintingItem({required GridItem item,}) {
    return InkWell(
      onTap: item.onTap,
      child: Container(
        color: AppColors.cWhiteColor,
        child: Column(
          children: [ 
            Image.asset(
              item.imageUrl,
              width: item.imgWidth ?? 180.w,
              height: item.imgHeight ?? 176.27.h,
            ),
            Text(
              item.title!,
              style: ts24minnie400,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
