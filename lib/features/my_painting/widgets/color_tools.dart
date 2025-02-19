import 'package:color_funland/core/components/gradient_box_border.dart';
import 'package:color_funland/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ColorTools extends StatefulWidget {
  final Function(Color) onColorSelected;
  final Color selectedColor;
  final Function(double)? onStrokeWidthChanged;
  final double strokeWidth;

  // Available colors
  static const List<Color> colors = [
    Colors.white,
    Colors.black,
    Colors.yellow,
    Color(0xFF4CAF50), // Green
    Color(0xFFFF9800), // Orange
    Color(0xFF2196F3), // Blue
    // Color(0xFF882601), // Blue
    // Color(0xFFFF861A), // Blue
    // Color(0xFF3498DB), // Blue

  ];

  const ColorTools({
    super.key,
    required this.onColorSelected,
    required this.selectedColor,
    this.onStrokeWidthChanged,
    this.strokeWidth = 15.0,
  });

  @override
  State<ColorTools> createState() => _ColorToolsState();
}

class _ColorToolsState extends State<ColorTools> {
  late double _currentStrokeWidth;

  @override
  void initState() {
    super.initState();
    _currentStrokeWidth = widget.strokeWidth;
  }

  @override
  Widget build(BuildContext context) {
    // Split colors into two columns
    final int midPoint = (ColorTools.colors.length / 2).ceil();
    final leftColors = ColorTools.colors.sublist(0, midPoint);
    final rightColors = ColorTools.colors.sublist(midPoint);

    return Container(
      width: 300.w,
      height: 410.h,
      decoration: BoxDecoration(
        color: const Color(0xFF2A0B4F),
        borderRadius: BorderRadius.circular(20.r),
        border: GradientBoxBorder(
          gradient: LinearGradient(
            colors: [AppColors.borderColor, AppColors.borderColor2],
          ),
          width: 5.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Two columns of colors
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RotatedBox(
                  quarterTurns: midPoint,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 330,
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.orange,
                            showValueIndicator: ShowValueIndicator.onlyForDiscrete ,
                            inactiveTrackColor: Colors.white.withOpacity(0.1),
                            thumbColor: Colors.white,
                            trackHeight: 30,
                            thumbShape: SliderComponentShape.noOverlay ,
                            overlayColor: Colors.white.withOpacity(0.1),
                            valueIndicatorColor: Colors.white,
                            valueIndicatorTextStyle: const TextStyle(
                              color: Color(0xFF2A0B4F),
                            ),
                          ),
                          child: Slider(
                            value: _currentStrokeWidth,
                            min: 5.0,
                            max: 50.0,
                            divisions: 45,
                            label: _currentStrokeWidth.round().toString(),
                            onChanged: (value) {
                              setState(() {
                                _currentStrokeWidth = value;
                              });
                              widget.onStrokeWidthChanged?.call(value);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Left column
                Padding(
                  padding:  EdgeInsets.only(top: 20.h),
                  child: SingleChildScrollView(
                    child: Column(
                      children: leftColors.map((color) => _buildColorButton(color)).toList(),
                    ),
                  ),
                ),
                // // Right column
                Padding(
                  padding:  EdgeInsets.only(top: 20.h),
                  child: SingleChildScrollView(
                    child: Column(

                      children: rightColors.map((color) => _buildColorButton(color)).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),

           SizedBox(height: 16.h),

          // Brush size slider
          if (widget.onStrokeWidthChanged != null) ...[
            
            const SizedBox(height: 16),
          ],


        ],
      ),
    );
  }

  Widget _buildColorButton(Color color) {
    final isSelected = widget.selectedColor == color;

    return Container(
      width: 89,
      height: 89,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: GestureDetector(
        onTap: () => widget.onColorSelected(color),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? Colors.white : Colors.transparent,
              width: 3,
            ),
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  color: color.withOpacity(0.5),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildToolButton({
  //   required IconData icon,
  //   required VoidCallback onTap,
  // }) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Container(
  //       width: 44,
  //       height: 44,
  //       decoration: BoxDecoration(
  //         color: Colors.white.withOpacity(0.1),
  //         shape: BoxShape.circle,
  //       ),
  //       child: Icon(
  //         icon,
  //         color: Colors.white,
  //         size: 24,
  //       ),
  //     ),
  //   );
  // }
}