import 'package:color_funland/core/components/animated_container_widget.dart';
import 'package:color_funland/core/constants/app_icons.dart';

import 'package:color_funland/core/components/app_bar_row.dart';
import 'package:color_funland/core/components/three_items_bottom_navigation.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:color_funland/features/my_painting/widgets/color_tools.dart';
import 'package:color_funland/features/my_painting/widgets/paint_state.dart';
import 'package:color_funland/features/my_painting/widgets/svg_canvas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PaintScreen extends StatefulWidget {
  final String uncoloredImage;
  final String coloredImage;
  final String categoryName;
  final List<Color> colorTools;
  const PaintScreen({
    super.key,
    required this.uncoloredImage,
    required this.coloredImage,
    required this.categoryName,
    required this.colorTools,
  });

  @override
  State<PaintScreen> createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {
  final GlobalKey<AnimatedContainerState> _containerKey = GlobalKey();

  final PaintState _paintState = PaintState();

  VectorImage? _vectorImage;

  @override
  void initState() {
    super.initState();
    _loadSvg();
  }

  // Load and parse the SVG file
  Future<void> _loadSvg() async {
    final String svgData = await rootBundle.loadString('assets/images/mypainting_images/monkeyuncolored.svg');
    setState(() {
      _vectorImage = parseSvg(svgData);
    });
  }

  // Method to reset the SVG image
void _resetSvg() async {
  final String svgData = await rootBundle.loadString('assets/images/mypainting_images/monkeyuncolored.svg');
  setState(() {
    _vectorImage = parseSvg(svgData); // Reload the original SVG
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
        containerKey: _containerKey,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 49.w),
              child: Column(
                children: [
                  Text(
                    widget.categoryName,
                    style: ts64Magic400,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                                width: 188.w,
                                child: SvgPicture.asset(
                                  widget.coloredImage,
                                  height: 230.53.h,
                                )),
                            InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                Navigator.pushNamed(context, '/winScreen');
                              },
                              child: Image.asset(
                                AppIcons.donebtn,
                                height: 86.h,
                                width: 164.w,
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          child: Center(
                            child: _vectorImage != null
                                ? SvgCanvas(
                                    vectorImage: _vectorImage!,
                                    selectedColor: _paintState.selectedColor,
                                    scaleFactor: .60,
                                  )
                                : const CircularProgressIndicator(), // Show a loading indicator until SVG is loaded
                          ),
                        ),
                        ColorTools(
                          paletteColors: widget.colorTools,
                          selectedColor: _paintState.selectedColor,
                          onColorSelected: (color) => setState(() {
                            _paintState.setColor(color);
                          }),
                          strokeWidth: _paintState.strokeWidth,
                          onStrokeWidthChanged: (width) => setState(() {
                            _paintState.setStrokeWidth(width);
                          }),
                          activeTrackColor: _paintState.selectedColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 110.h,
              right: 230.w,
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap:_resetSvg,
                child: SvgPicture.asset(
                  AppIcons.reset,
                  width: 60.w,
                  height: 60.h,
                ),
              ),
            ),
            AnimatedContainerWidget(key: _containerKey),
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
