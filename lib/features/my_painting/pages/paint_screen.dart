import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/features/game_board/presentation/widgets/app_bar_row.dart';
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
  const PaintScreen(
      {super.key,
      required this.uncoloredImage,
      required this.coloredImage,
      this.categoryName = "Animal"});

  @override
  State<PaintScreen> createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {
  final PaintState _paintState = PaintState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Column(
              children: [
                // App Bar
                AppBarRow(
                  gameGroup: "Paintings",
                  inSideGame: true,
                  appBarIcon: AppIcons.paintingsIcon,
                ),
                Stack(
                  children: [
                    // Title

                    // Reference Image
                    _ReferenceImage(widget.coloredImage),

                    // Paint Canvas
                    Center(
                      child: PaintCanvas(
                        paintState: _paintState,
                        uncoloredImage: widget.uncoloredImage,
                      ),
                    ),
                    const _TitleWidget("Animal"),
                  ],
                ),
              ],
            ),
          ),
          // Color Tools
          Positioned(
            right: 0,
            top: 140,
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
        ]),
      ),
      bottomNavigationBar: ThreeItemsBottomNavigation(
        insideGame: true,
        onBackPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  final String categoryName;
  const _TitleWidget(this.categoryName);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Text(
          categoryName,
          textAlign: TextAlign.center,
          style: TextStyle(
            backgroundColor: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: 'Comic',
          ),
        ),
      ),
    );
  }
}

class _ReferenceImage extends StatelessWidget {
  final String imageColored;
  const _ReferenceImage(
    this.imageColored,
  );

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16.w,
      top: 0,
      child: Column(
        children: [
          Container(
              width: 40.w,
              height: 40.h,
              decoration: const BoxDecoration(
                color: Color(0xFFF0E6FF),
                shape: BoxShape.circle,
              ),
              child: InkWell(
                onTap: () {},
                child: SizedBox(
                  width: 67.w,
                  height: 67.h,
                  child: SvgPicture.asset(
                    AppIcons.help,
                  ),
                ),
              )),
          const SizedBox(height: 16),
          Image.asset(
            imageColored,
            height: 320,
          ),
        ],
      ),
    );
  }
}