import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:color_funland/core/components/app_bar_row.dart';
import 'package:color_funland/features/game_board/presentation/widgets/three_items_bottom_navigation.dart';
import 'package:color_funland/features/my_painting/widgets/color_tools.dart';
import 'package:color_funland/features/my_painting/widgets/paint_canvas.dart';
import 'package:color_funland/features/my_painting/widgets/paint_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PaintScreen extends StatefulWidget {
  final String uncoloredImage;
  final String coloredImage;
  final String categoryName;
  const PaintScreen({
    super.key,
    required this.uncoloredImage,
    required this.coloredImage,
    required this.categoryName ,
  });

  @override
  State<PaintScreen> createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {
  final PaintState _paintState = PaintState();
  bool _showReferenceImage = false;

  void _toggleShowReferenceImage() {
    setState(() {
      _showReferenceImage = !_showReferenceImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarRow(
        gameGroup: "Paintings",
        inSideGame: true,
        appBarIcon: AppIcons.paintingsIcon,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 49.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.27,
                            left: 10.w),
                        child: InkWell(
                          onTap: () {
                            _toggleShowReferenceImage();
                          },
                          child: SizedBox(
                            width: 67.w,
                            height: 67.h,
                            child: SvgPicture.asset(
                              AppIcons.help,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        widget.categoryName,
                        style: ts64Magic400,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding:  EdgeInsets.only(right: 290.w),
                            child: _showReferenceImage
                                ? SvgPicture.asset(
                                    widget.coloredImage,
                                    height: 230.53.h,
                                  )
                                : Container(
                                    height: 230.53.h,
                                  ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: PaintCanvas(
                                  paintState: _paintState,
                                  uncoloredImage: widget.uncoloredImage,
                                  brushImage: AppImages.brush,
                                  coloredImage: AppImages.coloredduck,
                                ),
                              ),
                              Positioned(
                                right: 0,
                                child: ColorTools(
                                  selectedColor: _paintState.selectedColor,
                                  onColorSelected: (color) => setState(() {
                                    _paintState.setColor(color);
                                  }),
                                  strokeWidth: _paintState.strokeWidth,
                                  onStrokeWidthChanged: (width) => setState(() {
                                    _paintState.setStrokeWidth(width);
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // AnimatedContainerWidget(key: containerKey),
          ],
        ),
      ),
      bottomNavigationBar: ThreeItemsBottomNavigation(
        insideGame: true,
        onBackPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
