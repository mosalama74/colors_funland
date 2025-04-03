import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/constants/model.dart';
import 'package:color_funland/features/addProfileInfo/presentation/pages/child_progress_scareen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LearningColorsWidget extends StatelessWidget {
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

  const LearningColorsWidget({
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
      height: gridHeight ?? 416.h,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 1 / .98,
        ),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildlearningColors(
          index: index,
          
          item: GridItem(
            title: items[index].title,
            imageUrl: items[index].imageUrl,
            onTap: () {
               if ( index == 0) {
                      Navigator.of(context).pushNamed(pageGroup[0]);
                    } else if (LearningColorsProgress.gamesCounter >=3 &&
                        index == 1) {
                      Navigator.of(context).pushNamed(pageGroup[1]);
                    } else if (LearningColorsProgress.gamesCounter >= 6 &&
                        index == 2) {
                      Navigator.of(context).pushNamed(pageGroup[2]);
                    }
            },
          ),
        ),
        itemCount: items.length,
      ),
    );
  }

  Widget _buildlearningColors({
    required GridItem item,
    required int index,
  }) {
    return Center(
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: item.onTap,
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Image.asset(
              item.imageUrl,
              width: item.imgWidth,
              height: item.imgHeight,
              fit: BoxFit.cover,
            ),
            index >  LearningColorsProgress.lockedIndex
                ? Positioned(
                  top: 60.h,
                  right:50.w ,
                  left: 200.w,
                  child: Image.asset(
                      AppImages.locked,
                      width: 55.w,
                      height: 55.h,
                    ),
                )
                : Positioned(
                    top: 60.h,
                  right:50.w ,
                  left: 200.w,
                  child: SizedBox(
                      width: 55.w,
                      height: 55.h,
                    ),
                ),
          ],
        ),
      ),
    );
  }
}


