import 'package:flutter/material.dart';
import 'paint_stroke.dart';

/// Manages the state of the paint canvas
class PaintState extends ValueNotifier<List<PaintStroke?>> {
  // Constants
  static const double kDefaultStrokeWidth = 15.0;
  static const double kMinStrokeWidth = 5.0;
  static const double kMaxStrokeWidth = 50.0;

  // Paint properties
  Color _selectedColor = Colors.yellow;
  double _strokeWidth = kDefaultStrokeWidth;
  bool _isDrawing = false;

  // Canvas reference
  final GlobalKey canvasKey = GlobalKey();

  PaintState() : super([]);

  // Getters
  Color get selectedColor => _selectedColor;
  double get strokeWidth => _strokeWidth;
  bool get isDrawing => _isDrawing;
  List<PaintStroke?> get strokes => value;

  void startStroke(Offset point) {
    _isDrawing = true;
    addPoint(point);
  }

  void addPoint(Offset point) {
    if (!_isDrawing) return;
    
    final paint = Paint()
      ..color = _selectedColor
      ..isAntiAlias = true
      ..strokeWidth = _strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final newStroke = PaintStroke(point, paint, _selectedColor, _strokeWidth);
    value = List.from(value)..add(newStroke);
  }

  void endStroke() {
    _isDrawing = false;
    value = List.from(value)..add(null); // Mark end of stroke
  }

  void clear() {
    value = [];
    notifyListeners();
  }

  void setColor(Color color) {
    _selectedColor = color;
    notifyListeners();
  }

  void setStrokeWidth(double width) {
    _strokeWidth = width.clamp(kMinStrokeWidth, kMaxStrokeWidth);
    notifyListeners();
  }

  void undo() {
    if (value.isEmpty) return;
    
    // Remove points until we find a null (end of stroke marker)
    final newStrokes = List<PaintStroke?>.from(value);
    while (newStrokes.isNotEmpty && newStrokes.last != null) {
      newStrokes.removeLast();
    }
    if (newStrokes.isNotEmpty) {
      newStrokes.removeLast(); // Remove the null marker
    }
    
    value = newStrokes;
  }
}