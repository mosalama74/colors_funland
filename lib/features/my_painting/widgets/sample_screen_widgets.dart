import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:color_funland/core/constants/model.dart';
import 'package:color_funland/features/addProfileInfo/presentation/pages/child_progress_scareen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SampleScreenWidget extends StatefulWidget {
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

  const SampleScreenWidget({
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
  State<SampleScreenWidget> createState() => _SampleScreenWidgetState();
}

class _SampleScreenWidgetState extends State<SampleScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.insideanimals == true
            ? Text(
                widget.title,
                textAlign: TextAlign.center,
                style: ts64Magic400,
              )
            : Container(),
        SizedBox(
          height: MediaQuery.of(context).size.height * .56,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.crossAxisCount,
              childAspectRatio: widget.childAspectRatio,
            ),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => _buildPaintingItem(
              index: index,
              item: GridItem(
                title: widget.items[index].title,
                imageUrl: widget.items[index].imageUrl,
                onTap: () {
                  if (widget.title == 'Animals') {
                    controlPaintingAnimalsGames(index, context);
                  } else if (widget.title == 'Flowers') {
                    controlPaintingFlowersGames(index, context);
                  }
                },
              ),
            ),
            itemCount: widget.items.length,
          ),
        ),
      ],
    );
  }

  void controlPaintingAnimalsGames(int index, BuildContext context) {
    setState(() {
      if (index == 0) {
        Navigator.of(context).pushNamed(widget.pageGroup[0]);
      } else if (PaintingProgress.gamesCounter >= 1 && index == 1) {
        Navigator.of(context).pushNamed(widget.pageGroup[1]);
      } else if (PaintingProgress.gamesCounter >= 2 && index == 2) {
        Navigator.of(context).pushNamed(widget.pageGroup[2]);
      } else if (PaintingProgress.gamesCounter >= 3 && index == 3) {
        Navigator.of(context).pushNamed(widget.pageGroup[3]);
      } else if (PaintingProgress.gamesCounter >= 4 && index == 4) {
        Navigator.of(context).pushNamed(widget.pageGroup[4]);
      }
    });
  }

  void controlPaintingFlowersGames(int index, BuildContext context) {
    if (PaintingProgress.gamesCounter >= 5 && index == 0) {
      Navigator.of(context).pushNamed(widget.pageGroup[0]);
    } else if (PaintingProgress.gamesCounter >= 6 && index == 1) {
      Navigator.of(context).pushNamed(widget.pageGroup[1]);
    } else if (PaintingProgress.gamesCounter >= 7 && index == 2) {
      Navigator.of(context).pushNamed(widget.pageGroup[2]);
    } else if (PaintingProgress.gamesCounter >= 8 && index == 3) {
      Navigator.of(context).pushNamed(widget.pageGroup[3]);
    } else if (PaintingProgress.gamesCounter >= 9 && index == 4) {
      Navigator.of(context).pushNamed(widget.pageGroup[4]);
    }
  }

  Widget _buildPaintingItem({
    required GridItem item,
    required int index,
  }) {

    return InkWell(
      highlightColor: Colors.transparent, // Disable highlight effect
      splashColor: Colors.transparent, // Disable splash effect
      onTap: item.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Image.asset(
                item.imageUrl,
                width: 222.w,
                height: 211.62.h,
                fit: BoxFit.contain,
              ),
              index > getlockedPaintingName()
                  ? Image.asset(
                      AppImages.locked,
                      width: 66.w,
                      height: 66.h,
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }

  int getlockedPaintingName() {
    int lockedIndex = 0;
    if (widget.title == 'Animals') {
      lockedIndex = PaintingProgress.lockedanimals;
    } else if (widget.title == 'Flowers') {
      lockedIndex = PaintingProgress.lockedflowers;
    }
    return lockedIndex;
  }
}
