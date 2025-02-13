import 'package:color_funland/features/my_painting/widgets/paint_stroke.dart';
import 'package:flutter/material.dart';


class StrokePainter extends CustomPainter {
  final List<PaintStroke?> strokes;
  final Color currentColor;

  const StrokePainter({
    required this.strokes,
    required this.currentColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (strokes.isEmpty) return;

    Path? currentPath;
    Color? currentStrokeColor;
    double? currentStrokeWidth;
    
    void drawCurrentPath() {
      if (currentPath != null && currentStrokeColor != null && currentStrokeWidth != null) {
        final paint = Paint()
          ..color = currentStrokeColor
          ..strokeWidth = currentStrokeWidth
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..style = PaintingStyle.stroke
          ..isAntiAlias = true;
          
        canvas.drawPath(currentPath, paint);
      }
    }

    for (int i = 0; i < strokes.length; i++) {
      final stroke = strokes[i];
      
      if (stroke == null) {
        // End of current stroke, draw it
        drawCurrentPath();
        currentPath = null;
        currentStrokeColor = null;
        currentStrokeWidth = null;
        continue;
      }

      // If this is a new stroke or properties changed, start a new path
      if (currentPath == null || 
          currentStrokeColor != stroke.color ||
          currentStrokeWidth != stroke.strokeWidth) {
        drawCurrentPath();
        currentPath = Path();
        currentStrokeColor = stroke.color;
        currentStrokeWidth = stroke.strokeWidth;
        currentPath.moveTo(stroke.offset.dx, stroke.offset.dy);
      } else {
        currentPath.lineTo(stroke.offset.dx, stroke.offset.dy);
      }

      // If this is the last point, draw a dot
      if (i == strokes.length - 1 || strokes[i + 1] == null) {
        canvas.drawCircle(
          stroke.offset,
          stroke.strokeWidth / 2,
          Paint()
            ..color = stroke.color
            ..style = PaintingStyle.fill,
        );
      }
    }

    // Draw any remaining path
    drawCurrentPath();
  }

  @override
  bool shouldRepaint(covariant StrokePainter oldDelegate) => 
    oldDelegate.strokes != strokes || oldDelegate.currentColor != currentColor;
}