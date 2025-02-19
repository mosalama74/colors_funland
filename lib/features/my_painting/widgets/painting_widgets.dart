import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:color_funland/features/my_painting/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaintingWidget extends StatelessWidget {
  final List<GridItem> items;
  final int crossAxisCount;
  final List<String> pageGroup;
  final bool insidecategory;
  final bool insideanimals;
  final double? gridHeight;
  final double childAspectRatio;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  const PaintingWidget({
    super.key,
    required this.items,
    required this.crossAxisCount,
    required this.insidecategory,
    required this.pageGroup,
    required this.insideanimals,
    this.gridHeight,
    this.childAspectRatio = 1.0,
    this.crossAxisSpacing = 0.0,
    this.mainAxisSpacing = 0.0,
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
                  mainAxisSpacing: 0.w,
                  crossAxisSpacing: 10.h,
                  ),
                  physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => _buildPaintingItem(
                index: index,
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
    required int index,
  }) {
    return InkWell(
      onTap: item.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Image.asset(
                item.imageUrl,
                width: item.imgWidth,
                height: item.imgHeight,
                fit: BoxFit.cover,
              ),
              index > 3 ? Image.asset(AppImages.locked,width: 66.w,height: 66.h,) : Container(),
            ],
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
