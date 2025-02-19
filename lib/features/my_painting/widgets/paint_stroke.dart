import 'package:flutter/material.dart';

/// Represents a point in a paint stroke with its position and paint properties
class PaintStroke {
  final List<Offset> points = [];  // Make it mutable
  final Paint paint;
  final Color color;
  final double width;

  PaintStroke(
    Offset point, 
    this.paint, 
    this.color, 
    this.width,
  ) {
    points.add(point);  // Add initial point
  }

  void addPoint(Offset point) {
    points.add(point);
  }

  PaintStroke copyWith({Color? newColor, double? newWidth}) {
    return PaintStroke(
      points.first,
      Paint()
        ..color = newColor ?? color
        ..strokeWidth = newWidth ?? width
        ..strokeCap = paint.strokeCap
        ..strokeJoin = paint.strokeJoin
        ..style = paint.style
        ..isAntiAlias = paint.isAntiAlias,
      newColor ?? color,
      newWidth ?? width,
    )..points.addAll(points.skip(1));
  }
}