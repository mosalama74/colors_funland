import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:color_funland/features/my_painting/widgets/paint_stroke.dart';

class StrokePainter extends CustomPainter {
  final List<PaintStroke?> strokes;
  final Color currentColor;
  final ui.Image? referenceImage;

  StrokePainter({
    required this.strokes,
    required this.currentColor,
    this.referenceImage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final stroke in strokes) {
      if (stroke == null || stroke.points.isEmpty) continue;

      final paint = Paint()
        ..color = stroke.color
        ..strokeWidth = stroke.width
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;

      if (stroke.points.length == 1) {
        // For single points, draw a dot
        canvas.drawCircle(
          stroke.points.first,
          stroke.width / 2,
          paint..style = PaintingStyle.fill,
        );
      } else {
        // For multiple points, draw a path
        final path = Path();
        path.moveTo(stroke.points.first.dx, stroke.points.first.dy);

        for (int i = 1; i < stroke.points.length; i++) {
          path.lineTo(stroke.points[i].dx, stroke.points[i].dy);
        }

        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(StrokePainter oldDelegate) {
    return oldDelegate.strokes != strokes ||
           oldDelegate.currentColor != currentColor ||
           oldDelegate.referenceImage != referenceImage;
  }
}