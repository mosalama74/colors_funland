import 'package:color_funland/core/utils/text_styles.dart';
import 'package:color_funland/features/my_painting/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PaintingWidget extends StatelessWidget {
  final List<GridItem> items;
  final int crossAxisCount;
  final List<String> pageGroup;
  final bool insidecategory;
  final bool insideanimals;
  final double? gridHeight;
  final double childAspectRatio;

  const PaintingWidget({
    super.key,
    required this.items,
    required this.crossAxisCount,
    required this.insidecategory,
    required this.pageGroup,
    required this.insideanimals,
    this.gridHeight,  this.childAspectRatio = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          insideanimals == true
              ? Text(
                  'Animals',
                  textAlign: TextAlign.center,
                  style: ts64Magic400,
                )
              : Container(),
          SizedBox(
            height: gridHeight ?? 499.h,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: childAspectRatio,
                  mainAxisSpacing: 0.w),
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaintingItem({
    required GridItem item,
  }) {
    return InkWell(
      onTap: item.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          item.isSvg == true ? SvgPicture.asset(
            item.imageUrl,
            width: item.imgWidth ?? 180.w,
            height: item.imgHeight ?? 176.27.h,
          ) : Image.asset(
            item.imageUrl,
            width: item.imgWidth ?? 180.w,
            height: item.imgHeight ?? 176.27.h,
          ),
          SizedBox(
            height: 10.h,
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
    );
  }
}
