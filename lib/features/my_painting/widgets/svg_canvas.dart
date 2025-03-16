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

  PathSvgItem({required this.path, required this.fill});
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

    for (var item in items) {
        // 1. Draw the black border **slightly larger** to appear around the shape
    final borderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0  // Adjust border thickness as needed
      ..strokeJoin = StrokeJoin.miter; // Smooth edges

    // 2. Draw the original shape **with the border first**
    canvas.drawPath(item.path, borderPaint);

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

    items.add(PathSvgItem(path: path, fill: color));
  }

  return VectorImage(items: items, size: size);
}

// Widget to display the SVG and handle painting
class SvgCanvas extends StatefulWidget {
  final VectorImage vectorImage;
  final Color selectedColor;
  final double scaleFactor;

  const SvgCanvas({
    super.key,
    required this.vectorImage,
    required this.selectedColor,
    this.scaleFactor = 1.10, // Default scale factor
  });

  @override
  State<SvgCanvas> createState() => _SvgCanvasState();
}

class _SvgCanvasState extends State<SvgCanvas> {
  void _onTap(Offset position) {
    for (var item in widget.vectorImage.items) {
      if (item.path.contains(position)) {
        setState(() {
          item.fill = widget.selectedColor;
        });
        break;
      }
    }
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
