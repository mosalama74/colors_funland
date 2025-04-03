import 'package:color_funland/core/components/animated_container_widget.dart';
import 'package:color_funland/core/components/app_bar_row.dart';
import 'package:color_funland/core/components/fail_screen.dart';
import 'package:color_funland/core/components/three_items_bottom_navigation.dart';
import 'package:color_funland/core/components/win_screen.dart';
import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:color_funland/features/color_match/widgets/svg_canvas_numbers.dart';
import 'package:color_funland/features/my_painting/widgets/paint_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:palette_generator/palette_generator.dart';

class ColorMatchNumbers extends StatefulWidget {
  const ColorMatchNumbers({super.key});

  @override
  _ColorMatchNumbersState createState() => _ColorMatchNumbersState();
}

class _ColorMatchNumbersState extends State<ColorMatchNumbers> {
  final GlobalKey<AnimatedContainerState> _containerKey = GlobalKey();
  Color _selectedColor = Colors.black;
  String? _selectedImagePath; // Stores the path of the selected image

  VectorImage? _vectorImage;
  VectorImage? _coloredVectorImage;

  final PaintState _paintState = PaintState();

  bool isPaintingComplete = false;

  bool isPaintingCorrect = false;

  void _checkPaintingCompletion(
      List<PathSvgItem> paintedRegions, bool isCorrect) {
    int totalRegions = paintedRegions.length;
    int paintedCount = paintedRegions
        .where((region) =>
            region.fill != Colors.transparent && region.fill != Colors.white)
        .length;

    double paintedPercentage = (paintedCount / totalRegions) * 100;

    print("Total Regions: $totalRegions");
    print("Painted Regions: $paintedCount");
    print("Painting Completion: $paintedPercentage%");

    setState(() {
      isPaintingComplete =
          paintedPercentage >= 50.0; // Show widget when 80% is painted
      isPaintingCorrect = isCorrect;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSvg();
  }

  // Load and parse the SVG file
  Future<void> _loadSvg() async {
    final String uncoloredSvgData =
        await rootBundle.loadString(AppImages.numbersuncolored2);
    final String coloredSvgData =
        await rootBundle.loadString(AppImages.numberscolored);

    setState(() {
      _vectorImage = parseSvg(uncoloredSvgData);
      _coloredVectorImage = parseSvg(coloredSvgData);
    });
  }

  // Method to reset the SVG image
  void _resetSvg() async {
    final String svgData =
        await rootBundle.loadString(AppImages.numbersuncolored2);
    setState(() {
      _vectorImage = parseSvg(svgData); // Reload the original SVG
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarRow(
        gameGroup: "Color Match",
        inSideGame: true,
        appBarIcon: AppIcons.colorMatchIcon,
        containerKey: _containerKey,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 46.w, right: 52.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      if (isPaintingComplete)
                        InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            if (isPaintingCorrect) {
                              print('success paint');
                              showWinScreen(
                                context,
                                () => Navigator.pushReplacementNamed(
                                    context, "/colorMatchScreen"),
                              );
                            } else {
                              showFailureScreen(
                                  context); // Show failure screen as a modal

                              print('error paint');
                            }
                          },
                          child: Image.asset(
                            AppIcons.donebtn,
                            height: 65.h,
                            width: 86.w,
                          ),
                        ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * .33,
                      ),
                      Text(
                        'Flowers',
                        style: ts64Magic400,
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * .30,
                      ),
                      InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: _resetSvg,
                        child: SvgPicture.asset(
                          AppIcons.reset,
                          width: 60.w,
                          height: 60.h,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  numberImage(AppImages.number1colormatch),
                                  numberImage(AppImages.number2colormatch),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  numberImage(AppImages.number3colormatch),
                                  numberImage(AppImages.number4colormatch),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            child: Center(
                              child: _vectorImage != null
                                  ? SvgCanvasNumbers(
                                      vectorImage: _vectorImage!,
                                      selectedColor: _selectedColor,
                                      onPaintUpdate: _checkPaintingCompletion,
                                      coloredVectorImage: _coloredVectorImage!,
                                      scaleFactor: 1.0,
                                    )
                                  : const CircularProgressIndicator(), // Show a loading indicator until SVG is loaded
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  numberImage(AppImages.number5colormatch),
                                  numberImage(AppImages.number6colormatch),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  numberImage(AppImages.blackcolor),
                                  numberImage(AppImages.number7colormatch),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainerWidget(key: _containerKey),
          ],
        ),
      ),
      bottomNavigationBar: ThreeItemsBottomNavigation(
        insideGame: true,
        onBackPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget numberImage(String path) {
    return GestureDetector(
      onTap: () async {
        final svgString = await rootBundle.loadString(path);
        final color = _extractFillColor(svgString);
        setState(() {
          _selectedColor = color;
          _paintState.setColor(color);
          _selectedImagePath = path;
        });
      },
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color:
                _selectedImagePath == path ? Colors.blue : Colors.transparent,
            width: 3,
          ),
        ),
        child: SvgPicture.asset(
          path,
          height: 150.h,
          width: 150.w,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

// Extracts the first fill color from the SVG
  Color _extractFillColor(String svgData) {
    final regex = RegExp(r'fill="(#?[0-9a-fA-F]{6,8})"');
    final match = regex.firstMatch(svgData);
    if (match != null) {
      return _parseColor(match.group(1)!);
    }
    return Colors.black; // Default color if no fill is found
  }

// Converts hex string to Color object
  Color _parseColor(String hexColor) {
    if (hexColor.startsWith('#')) {
      hexColor = hexColor.substring(1);
    }
    if (hexColor.length == 6) {
      return Color(int.parse('0xFF$hexColor'));
    } else if (hexColor.length == 8) {
      return Color(int.parse('0x$hexColor'));
    }
    return Colors.black;
  }
}
