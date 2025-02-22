import 'dart:ui' as ui;
import 'package:color_funland/features/my_painting/widgets/paint_state.dart';
import 'package:color_funland/features/my_painting/widgets/paint_stroke.dart';
import 'package:color_funland/features/my_painting/widgets/stroke_painter.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PaintCanvas extends StatefulWidget {
  final PaintState paintState;
  final String uncoloredImage;
  final String coloredImage;
  final String brushImage;

  const PaintCanvas({
    super.key,
    required this.paintState,
    required this.uncoloredImage,
    required this.coloredImage,
    required this.brushImage,
  });

  @override
  State<PaintCanvas> createState() => _PaintCanvasState();
}

class _PaintCanvasState extends State<PaintCanvas>
    with SingleTickerProviderStateMixin {
  Offset? _currentPosition;
  late String boardFrame;
  ui.Image? _coloredReferenceImage;
  final GlobalKey _paintKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    boardFrame = _getBoardFrame(widget.uncoloredImage);
    _loadColoredImage();
  }

  Future<void> _loadColoredImage() async {
    final ByteData data = await rootBundle.load(widget.coloredImage);
    final Uint8List bytes = data.buffer.asUint8List();
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.FrameInfo fi = await codec.getNextFrame();
    setState(() {
      _coloredReferenceImage = fi.image;
    });
  }

  Future<bool> compareWithReference() async {
    if (_coloredReferenceImage == null) return false;

    try {
      final RenderRepaintBoundary boundary = 
          _paintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage();
      final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return false;

      // Compare the images pixel by pixel
      final double similarityThreshold = 0.85; // 85% similarity required
      int matchingPixels = 0;
      int totalPixels = image.width * image.height;

      // TODO: Implement pixel comparison logic
      // This would require processing both images' pixel data
      // and comparing colors within a tolerance range

      double similarity = matchingPixels / totalPixels;
      return similarity >= similarityThreshold;
    } catch (e) {
      debugPrint('Error comparing images: $e');
      return false;
    }
  }

  String _getBoardFrame(String imagePath) {
    final imageName = imagePath.split('/').last.toLowerCase();
    
    if (imageName.contains('duck')) return AppImages.duckUncolored;
    if (imageName.contains('cat')) return AppImages.catUncolored;
    if (imageName.contains('elephant')) return AppImages.elephantUncolored;
    if (imageName.contains('giraffe')) return AppImages.giraffeUncolored;
    if (imageName.contains('kangaroo')) return AppImages.kangaroUncolored;
    if (imageName.contains('lion')) return AppImages.lionBabyUncolored;
    if (imageName.contains('tiger')) return AppImages.tigerUncolored;
    if (imageName.contains('turtle')) return AppImages.turtleUncolored;
    if (imageName.contains('bee')) return AppImages.beeUncolored;
    
    return AppImages.duckFram;
  }

  bool _isPointWithinBoardFrame(Offset point) {
    final RenderBox? canvasBox = widget.paintState.canvasKey.currentContext?.findRenderObject() as RenderBox?;
    if (canvasBox == null) return false;

    final Size canvasSize = canvasBox.size;
    final Offset canvasPosition = canvasBox.localToGlobal(Offset.zero);
    
    // Convert the point to be relative to the canvas position
    final Offset relativePoint = point - canvasPosition;
    
    return relativePoint.dx >= 0 && 
           relativePoint.dx <= canvasSize.width && 
           relativePoint.dy >= 0 && 
           relativePoint.dy <= canvasSize.height;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //  Image.asset(
        //   boardFrame,
        //   width: 230.w,
        //   key: widget.paintState.canvasKey,
        //   fit: BoxFit.cover,
        // ),
        
        ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Paint Layer with Instant Updates
              Padding(
                padding: EdgeInsets.all(20.w),
                child: RepaintBoundary(
                  key: _paintKey,
                  child: ValueListenableBuilder<List<PaintStroke?>>(
                    valueListenable: widget.paintState,
                    builder: (context, strokes, _) {
                      return CustomPaint(
                        painter: StrokePainter(
                          strokes: strokes,
                          currentColor: widget.paintState.selectedColor,
                          referenceImage: _coloredReferenceImage,
                        ),
                        size: Size.infinite,
                        isComplex: true,
                        willChange: true,
                      );
                    },
                  ),
                ),
              ),
             
      
              // // Image Layer
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Center(
                  child: Image.asset(
                    widget.uncoloredImage,
                    key: widget.paintState.canvasKey,
                    fit: BoxFit.contain,
                    width: 400.w,
                  ),
                ),
              ),
      
              // Touch Handler with Direct Updates
              Positioned.fill(
                child: RawGestureDetector(
                  gestures: <Type, GestureRecognizerFactory>{
                    PanGestureRecognizer: GestureRecognizerFactoryWithHandlers<PanGestureRecognizer>(
                      () => PanGestureRecognizer(),
                      (PanGestureRecognizer instance) {
                        instance
                          ..onStart = (details) {
                            final RenderBox box = context.findRenderObject() as RenderBox;
                            final localPosition = box.globalToLocal(details.globalPosition);
                            if (_isPointWithinBoardFrame(details.globalPosition)) {
                              setState(() => _currentPosition = localPosition);
                              widget.paintState.startStroke(localPosition);
                            }
                          }
                          ..onUpdate = (details) {
                            final RenderBox box = context.findRenderObject() as RenderBox;
                            final localPosition = box.globalToLocal(details.globalPosition);
                            if (_isPointWithinBoardFrame(details.globalPosition)) {
                              setState(() => _currentPosition = localPosition);
                              widget.paintState.addPoint(localPosition);
                            }
                          }
                          ..onEnd = (details) {
                            widget.paintState.endStroke();
                            compareWithReference().then((isAccurate) {
                              if (isAccurate) {
                                debugPrint('Painting matches the reference!');
                              }
                            });
                          };
                      },
                    ),
                  },
                  child: MouseRegion(
                    onHover: (event) {
                      final RenderBox box = context.findRenderObject() as RenderBox;
                      final localPosition = box.globalToLocal(event.position);
                      if (_isPointWithinBoardFrame(event.position)) {
                        setState(() => _currentPosition = localPosition);
                      } else {
                        setState(() => _currentPosition = null);
                      }
                    },
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),

              // Brush Cursor Layer
              if (_currentPosition != null)
                Positioned(
                  left: _currentPosition!.dx - 15.w,
                  top: _currentPosition!.dy - 15.w,
                  child: RepaintBoundary(
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topLeft,
                      children: [
                        SvgPicture.asset(
                          AppImages.brushHandle,
                          width: 15.92.w,
                          height: 255.57.h,
                          fit: BoxFit.contain,
                        ),
                        Positioned(
                          top: -20.h,
                          left: -20.w,
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              widget.paintState.selectedColor,
                              BlendMode.srcIn,
                            ),
                            child: SvgPicture.asset(
                              AppImages.brushHair,
                              width: 38.96.w,
                              height: 58.48.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}