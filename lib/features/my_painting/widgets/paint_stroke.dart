import 'package:flutter/material.dart';

/// Represents a point in a paint stroke with its position and paint properties
class PaintStroke {
  final Offset offset;
  final Paint paint;
  final Color color;
  final double strokeWidth;

  PaintStroke(this.offset, this.paint, this.color, this.strokeWidth);

  PaintStroke copyWith({Color? newColor, double? newStrokeWidth}) {
    return PaintStroke(
      offset,
      Paint()
        ..color = newColor ?? color
        ..strokeWidth = newStrokeWidth ?? strokeWidth
        ..strokeCap = paint.strokeCap
        ..strokeJoin = paint.strokeJoin
        ..style = paint.style
        ..isAntiAlias = paint.isAntiAlias,
      newColor ?? color,
      newStrokeWidth ?? strokeWidth,
    );
  }
}
