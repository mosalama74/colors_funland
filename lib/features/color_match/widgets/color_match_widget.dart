import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/constants/model.dart';
import 'package:color_funland/features/addProfileInfo/presentation/pages/child_progress_scareen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorMatchWidget extends StatelessWidget {
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

  const ColorMatchWidget({
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
    return SizedBox(
      height: gridHeight ?? 392.h,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 1 / 1.3,
         mainAxisSpacing: 0,
        ),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildColorMatch(
          index: index,
          item: GridItem(
            title: items[index].title,
            imageUrl: items[index].imageUrl,
            onTap: () {
                if ( index == 0) {
                      Navigator.of(context).pushReplacementNamed(pageGroup[0]);
                    } else if (ColorMatchProgress.gamesCounter >=1 &&
                        index == 1) {
                      Navigator.of(context).pushReplacementNamed(pageGroup[1]);
                    } else if (ColorMatchProgress.gamesCounter >= 2 &&
                        index == 2) {
                      Navigator.of(context).pushReplacementNamed(pageGroup[2]);
                    } else if (ColorMatchProgress.gamesCounter >= 3 &&
                        index == 3) {
                      Navigator.of(context).pushReplacementNamed(pageGroup[3]);
                    }
            },
          ),
        ),
        itemCount: items.length,
      ),
    );
  }

  Widget _buildColorMatch({
    required GridItem item,
    required int index,
  }) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: item.onTap,
      child: 
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Image.asset(
                item.imageUrl,
                width: item.imgWidth,
                height: item.imgHeight,
                fit: BoxFit.contain,
              ),
              index > ColorMatchProgress.lockedIndex
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
    );
  }
}
