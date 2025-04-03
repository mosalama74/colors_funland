// Import necessary packages
import 'package:flutter/material.dart';
import 'package:xml/xml.dart';
import 'package:path_drawing/path_drawing.dart';

// Model classes for SVG representation
class VectorImage {
  final List<PathSvgItem> items;
  final Size? size;

  VectorImage({required this.items, this.size});
}

class PathSvgItem {
  final Path path;
  Color fill;
  final Color originalColor; // Store correct color from colored SVG

  PathSvgItem(
      {required this.path, required this.fill, required this.originalColor});
}

// Painter class for rendering SVG paths
class SvgPainter extends CustomPainter {
  final List<PathSvgItem> items;
  final double scaleFactor;

  SvgPainter(this.items, {this.scaleFactor = 1.10});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();

    // Move canvas to center before scaling
    canvas.translate(size.width / 2, size.height / 2);
    canvas.scale(scaleFactor);
    canvas.translate(-size.width / 2, -size.height / 2);

  Paint defaultStrokePaint = Paint()
    ..color = Colors.black  // Default stroke color
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;  // Adjust stroke width

    for (var item in items) {
          // Ensure all shapes have an outline
    canvas.drawPath(item.path, defaultStrokePaint);
    

      // 3. Draw the filled shape **on top of the border**
      final fillPaint = Paint()
        ..color = item.fill
        ..style = PaintingStyle.fill;

      canvas.drawPath(item.path, fillPaint);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(SvgPainter oldDelegate) => true;
}

// Function to parse SVG file data
VectorImage parseSvg(String svgData) {
  final document = XmlDocument.parse(svgData);
  List<PathSvgItem> items = [];
  Size? size;

  final svgElement = document.findAllElements('svg').first;
  String? viewBox = svgElement.getAttribute('viewBox');

  if (viewBox != null) {
    final parts = viewBox.split(' ');
    size = Size(double.parse(parts[2]), double.parse(parts[3]));
  }

  for (var element in document.findAllElements('path')) {
    final String? pathData = element.getAttribute('d');
    if (pathData == null) continue;
    Path path = parseSvgPathData(pathData);

    String? fillColor = element.getAttribute('fill');
    Color color = Colors.transparent; // Default color
    if (fillColor != null &&
        fillColor.startsWith("#") &&
        fillColor.length == 7) {
      color = Color(int.parse('0xff${fillColor.substring(1)}'));
    }

  items.add(PathSvgItem(path: path, fill: color, originalColor: color));

  }

  return VectorImage(items: items, size: size);
}

// Widget to display the SVG and handle painting
class SvgCanvasNumbers extends StatefulWidget {
  final VectorImage vectorImage;
  final VectorImage coloredVectorImage; // Add this
  final Color? selectedColor;
  final double scaleFactor;
  final void Function(List<PathSvgItem>,bool)? onPaintUpdate; // Callback to notify painting updates

  const SvgCanvasNumbers({
    super.key,
    required this.vectorImage,
    this.selectedColor,
    this.scaleFactor = 1.10, // Default scale factor
    this.onPaintUpdate,
    required this.coloredVectorImage,
  });

  @override
  State<SvgCanvasNumbers> createState() => _SvgCanvasNumbersState();
}

class _SvgCanvasNumbersState extends State<SvgCanvasNumbers> {
 void _onTap(Offset position) {
  for (var item in widget.vectorImage.items) {
    if (item.path.contains(position)) {
      setState(() {
        item.fill = widget.selectedColor ?? item.fill; // Keep original color if no color selected
      });

      // Compute correctness
      bool isCorrect = _isPaintingCorrect(widget.vectorImage.items);

      // Notify parent widget
      widget.onPaintUpdate?.call(widget.vectorImage.items, isCorrect);
      break;
    }
  }
}


 bool _isPaintingCorrect(List<PathSvgItem> paintedRegions) {
  int correctlyPainted = 0;
  int totalRegions = paintedRegions.length;
  int coloredTotalRegions = widget.coloredVectorImage.items.length;

  int minRegions = totalRegions < coloredTotalRegions ? totalRegions : coloredTotalRegions;

  for (int i = 0; i < minRegions; i++) {
    if (paintedRegions[i].fill == widget.coloredVectorImage.items[i].originalColor) {
      correctlyPainted++;
    }
  }

  double accuracy = (correctlyPainted / minRegions) * 100;

  bool isCorrect = accuracy >= 12.0;

  // // Print debugging info
  print("Painting Accuracy: $accuracy%");
  print("Correctly Painted Regions: $correctlyPainted / $minRegions");
  print("isPaintingCorrect: $isCorrect");

  return isCorrect;
}


  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: (widget.vectorImage.size?.width ?? 300) *
            widget.scaleFactor, // Increased space
        height: (widget.vectorImage.size?.height ?? 300) * widget.scaleFactor,
        child: GestureDetector(
          onTapUp: (details) => _onTap(details.localPosition),
          child: CustomPaint(
            painter: SvgPainter(widget.vectorImage.items,
                scaleFactor: widget.scaleFactor),
          ),
        ),
      ),
    );
  }
}



