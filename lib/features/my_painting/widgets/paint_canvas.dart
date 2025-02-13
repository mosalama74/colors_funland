import 'package:color_funland/features/my_painting/widgets/paint_state.dart';
import 'package:color_funland/features/my_painting/widgets/paint_stroke.dart';
import 'package:color_funland/features/my_painting/widgets/stroke_painter.dart';
import 'package:flutter/material.dart';


class PaintCanvas extends StatefulWidget {
  final PaintState paintState;
  final String uncoloredImage;

  const PaintCanvas({
    super.key,
    required this.paintState, required this.uncoloredImage,
  });

  @override
  State<PaintCanvas> createState() => _PaintCanvasState();
}

class _PaintCanvasState extends State<PaintCanvas> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.30,
      height: MediaQuery.of(context).size.height * 0.55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Layer
            Container(color: Colors.white),
            
            // Paint Layer with Instant Updates
            RepaintBoundary(
              child: ValueListenableBuilder<List<PaintStroke?>>(
                valueListenable: widget.paintState,
                builder: (context, strokes, _) {
                  return CustomPaint(
                    painter: StrokePainter(
                      strokes: strokes,
                      currentColor: widget.paintState.selectedColor,
                    ),
                    size: Size.infinite,
                    isComplex: true,
                    willChange: true,
                  );
                },
              ),
            ),
            
            // Duck Outline Layer
            Positioned.fill(
              top: 50,
              child: IgnorePointer(
                child: Image.asset(
                  widget.uncoloredImage,
                  key: widget.paintState.canvasKey,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            
            // Touch Handler
            Positioned.fill(
              child: GestureDetector(
                onPanStart: (details) {
                  final RenderBox box = context.findRenderObject() as RenderBox;
                  final Offset localPosition = box.globalToLocal(details.globalPosition);
                  widget.paintState.startStroke(localPosition);
                },
                onPanUpdate: (details) {
                  final RenderBox box = context.findRenderObject() as RenderBox;
                  final Offset localPosition = box.globalToLocal(details.globalPosition);
                  widget.paintState.addPoint(localPosition);
                },
                onPanEnd: (_) {
                  widget.paintState.endStroke();
                },
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}