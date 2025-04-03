import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:color_funland/core/constants/model.dart';
import 'package:color_funland/features/addProfileInfo/presentation/pages/child_progress_scareen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorMixingWidget extends StatelessWidget {
  final List<GridItem> items;
  final String title;

  final int crossAxisCount;
  final List<String> pageGroup;
  final bool insidecategory;
  final bool insideanimals;
  final double? gridHeight;
  final double childAspectRatio;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  const ColorMixingWidget({
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
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: gridHeight ?? 268.h,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: .9 / 1,
              ),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => _buildColorMixing(
                index: index,
                item: GridItem(
                  title: items[index].title,
                  imageUrl: items[index].imageUrl,
                  onTap: () {
                    if ( index == 0) {
                      Navigator.of(context).pushNamed(pageGroup[0]);
                    } else if (ColorMixingProgress.gamesCounter >=3 &&
                        index == 1) {
                      Navigator.of(context).pushNamed(pageGroup[1]);
                    } else if (ColorMixingProgress.gamesCounter >= 6 &&
                        index == 2) {
                      Navigator.of(context).pushNamed(pageGroup[2]);
                    }
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

  Widget _buildColorMixing({
    required GridItem item,
    required int index,
  
  }) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
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
              
             index > ColorMixingProgress.lockedIndex
                  ? Image.asset(
                      AppImages.locked,
                      width: 66.w,
                      height: 66.h,
                    )
                  : SizedBox(
                      width: 66.w,
                      height: 66.h,
                    ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Level',
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
