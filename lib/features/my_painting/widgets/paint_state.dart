import 'package:flutter/material.dart';
import 'paint_stroke.dart';

/// Manages the state of the paint canvas
class PaintState extends ValueNotifier<List<PaintStroke?>> {
  // Constants
  static const double kDefaultStrokeWidth = 15.0;
  static const double kMinStrokeWidth = 5.0;
  static const double kMaxStrokeWidth = 50.0;

  // Paint properties
  Color _selectedColor = Colors.yellow; // Changed initial color for better visibility
  double _strokeWidth = kDefaultStrokeWidth;
  bool _isDrawing = false;
  PaintStroke? _currentStroke;

  // Canvas reference
  final GlobalKey canvasKey = GlobalKey();

  PaintState() : super([]);

  // Getters
  Color get selectedColor => _selectedColor;
  double get strokeWidth => _strokeWidth;
  bool get isDrawing => _isDrawing;
  List<PaintStroke?> get strokes => value;

  void startStroke(Offset point) {
    if (_isDrawing) return; // Prevent multiple starts
    _isDrawing = true;
    
    // Get the canvas bounds
    final RenderBox? renderBox = canvasKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    
    final Size size = renderBox.size;
    
    // Clamp the point within the canvas bounds
    final clampedPoint = Offset(
      point.dx.clamp(0, size.width),
      point.dy.clamp(0, size.height)
    );
    
    final paint = Paint()
      ..color = _selectedColor
      ..isAntiAlias = true
      ..strokeWidth = _strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    _currentStroke = PaintStroke(clampedPoint, paint, _selectedColor, _strokeWidth);
    
    // Create a new list and add the stroke
    final newStrokes = List<PaintStroke?>.from(value);
    newStrokes.add(_currentStroke);
    value = newStrokes;
    notifyListeners(); // Ensure UI updates
  }

  void addPoint(Offset point) {
    if (!_isDrawing || _currentStroke == null) return;
    
    // Get the canvas bounds
    final RenderBox? renderBox = canvasKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    
    final Size size = renderBox.size;
    
    // Clamp the point within the canvas bounds
    final clampedPoint = Offset(
      point.dx.clamp(0, size.width),
      point.dy.clamp(0, size.height)
    );
    
    // Add point to current stroke
    _currentStroke!.addPoint(clampedPoint);
    
    // Force a rebuild
    notifyListeners();
  }

  void endStroke() {
    if (!_isDrawing) return;
    _isDrawing = false;
    
    if (_currentStroke != null) {
      // Only add null marker if we actually had a stroke
      final newStrokes = List<PaintStroke?>.from(value);
      newStrokes.add(null);
      value = newStrokes;
      _currentStroke = null;
      notifyListeners();
    }
  }

  void clear() {
    _isDrawing = false;
    _currentStroke = null;
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
    notifyListeners();
  }
}