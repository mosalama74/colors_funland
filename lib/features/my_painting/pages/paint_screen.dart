import 'package:color_funland/core/components/animated_container_widget.dart';
import 'package:color_funland/core/components/fail_screen.dart';
import 'package:color_funland/core/components/win_screen.dart';
import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/components/app_bar_row.dart';
import 'package:color_funland/core/components/three_items_bottom_navigation.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/constants/frame_state_manager.dart';
import 'package:color_funland/core/constants/model.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:color_funland/features/addProfileInfo/presentation/cubit/profile_info_cubit.dart';
import 'package:color_funland/features/addProfileInfo/presentation/pages/child_progress_scareen.dart';
import 'package:color_funland/features/my_painting/widgets/color_tools.dart';
import 'package:color_funland/features/my_painting/widgets/paint_state.dart';
import 'package:color_funland/features/my_painting/widgets/svg_canvas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:color_funland/features/my_painting/services/painting_service.dart';

class PaintScreen extends StatefulWidget {
  final String uncoloredImage;
  final String coloredImage;
  final String categoryName;
  final List<Color> colorTools;
  final String itemKey;

  const PaintScreen({
    super.key,
    required this.uncoloredImage,
    required this.coloredImage,
    required this.categoryName,
    required this.colorTools,
    required this.itemKey,
  });

  @override
  State<PaintScreen> createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {
  final GlobalKey<AnimatedContainerState> _containerKey = GlobalKey();

  void _increaseCounterGame() {
    setState(() {
      if (PaintingProgress.gamesCounter < 10) {
        PaintingProgress.gamesCounter++;
      }
    });
  }

  void _increaseLevelCounter() {
    setState(() {
      if (PaintingProgress.gamesCounter < 10) {
        PaintingProgress.levelsCounter++;
      }
    });
  }

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
          paintedPercentage >= 60.0; // Show widget when 80% is painted
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
        await rootBundle.loadString(widget.uncoloredImage);
    final String coloredSvgData =
        await rootBundle.loadString(widget.coloredImage);

    setState(() {
      _vectorImage = parseSvg(uncoloredSvgData);
      _coloredVectorImage = parseSvg(coloredSvgData);
    });
  }

  // Method to reset the SVG image
  void _resetSvg() async {
    final String svgData = await rootBundle.loadString(widget.uncoloredImage);
    setState(() {
      _vectorImage = parseSvg(svgData); // Reload the original SVG
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarRow(
        gameGroup: "Paintings",
        inSideGame: true,
        appBarIcon: AppIcons.paintingsIcon,
        containerKey: _containerKey,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 49.w),
              child: Column(
                children: [
                  Text(
                    widget.categoryName,
                    style: ts64Magic400,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                                width: 188.w,
                                child: SvgPicture.asset(
                                  widget.coloredImage,
                                  height: 230.53.h,
                                )),
                            if (isPaintingComplete)
                              InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  if (isPaintingCorrect) {
                                    scoringColoredItems();
                                    print('success paint');
                                  } else {
                                    showFailureScreen(
                                        context); // Show failure screen as a modal

                                    print('error paint');
                                  }
                                },
                                child: Image.asset(
                                  AppIcons.donebtn,
                                  height: 86.h,
                                  width: 164.w,
                                ),
                              )
                          ],
                        ),
                        Expanded(
                          child: Center(
                            child: _vectorImage != null
                                ? SvgCanvas(
                                    vectorImage: _vectorImage!,
                                    selectedColor: _paintState.selectedColor,
                                    scaleFactor: 1.0,
                                    onPaintUpdate: _checkPaintingCompletion,
                                    coloredVectorImage:
                                        _coloredVectorImage!, // Pass the colored image
                                  )
                                : const CircularProgressIndicator(),
                          ),
                        ),
                        ColorTools(
                          paletteColors: widget.colorTools,
                          selectedColor: _paintState.selectedColor,
                          onColorSelected: (color) => setState(() {
                            _paintState.setColor(color);
                          }),
                          strokeWidth: _paintState.strokeWidth,
                          onStrokeWidthChanged: (width) => setState(() {
                            _paintState.setStrokeWidth(width);
                          }),
                          activeTrackColor: _paintState.selectedColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 110.h,
              right: 230.w,
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () => _resetSvg(), // Call the reset method
                child: SvgPicture.asset(
                  AppIcons.reset,
                  width: 60.w,
                  height: 60.h,
                ),
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

  void scoringColoredItems() async {
    await PaintingService.markItemAsPainted(widget.itemKey);
    FrameStateManager.updateFrameAfterPainting(widget.uncoloredImage);

    // Add this to ensure parent screens update
    if (mounted) {
      setState(() {});
    }
    if (widget.uncoloredImage == AppImages.uncoloredelephante) {
      if (PaintingProgress.gamesCounter < 1) {
        _increaseCounterGame();
        context.read<ProfileInfoCubit>().updatePaintingProgress(
            paintingGameCounter: PaintingProgress.gamesCounter,
            paintingLevelCounter: PaintingProgress.levelsCounter);
      }
      showWinScreen(
        context,
        () => Navigator.pushReplacementNamed(context, "/animalsSamplesScreen"),
      );
    }
    if (widget.uncoloredImage == AppImages.uncoloredturtle) {
      if (PaintingProgress.gamesCounter == 1) {
        _increaseCounterGame();
        context.read<ProfileInfoCubit>().updatePaintingProgress(
            paintingGameCounter: PaintingProgress.gamesCounter,
            paintingLevelCounter: PaintingProgress.levelsCounter);
        PaintingProgress.lockedanimals = 2;
      }
      showWinScreen(
        context,
        () => Navigator.pushReplacementNamed(context, "/animalsSamplesScreen"),
      );
    }
    if (widget.uncoloredImage == AppImages.uncoloredpenguin) {
      if (PaintingProgress.gamesCounter == 2) {
        _increaseCounterGame();
        context.read<ProfileInfoCubit>().updatePaintingProgress(
            paintingGameCounter: PaintingProgress.gamesCounter,
            paintingLevelCounter: PaintingProgress.levelsCounter);
        PaintingProgress.lockedanimals = 3;
      }
      showWinScreen(
        context,
        () => Navigator.pushReplacementNamed(context, "/animalsSamplesScreen"),
      );
    }
    if (widget.uncoloredImage == AppImages.uncoloredelephante2) {
      if (PaintingProgress.gamesCounter == 3) {
        _increaseCounterGame();
        context.read<ProfileInfoCubit>().updatePaintingProgress(
            paintingGameCounter: PaintingProgress.gamesCounter,
            paintingLevelCounter: PaintingProgress.levelsCounter);
        PaintingProgress.lockedanimals = 4;
      }
      showWinScreen(
        context,
        () => Navigator.pushReplacementNamed(context, "/animalsSamplesScreen"),
      );
    }
    if (widget.uncoloredImage == AppImages.uncoloredmonkey2) {
      if (PaintingProgress.gamesCounter == 4) {
        _increaseCounterGame();
        _increaseLevelCounter();

        context.read<ProfileInfoCubit>().updatePaintingProgress(
            paintingGameCounter: PaintingProgress.gamesCounter,
            paintingLevelCounter: PaintingProgress.levelsCounter);

        PaintingProgress.lockedPaintingBoardIndex = 1;
      }
      showWinScreen(
        context,
        () => Navigator.pushReplacementNamed(context, "/mypaintingScreen"),
      );
    }
    if (widget.uncoloredImage == AppImages.floweruncolored1) {
      if (PaintingProgress.gamesCounter == 5) {
        _increaseCounterGame();
        context.read<ProfileInfoCubit>().updatePaintingProgress(
            paintingGameCounter: PaintingProgress.gamesCounter,
            paintingLevelCounter: PaintingProgress.levelsCounter);
      }
      showWinScreen(
        context,
        () => Navigator.pushReplacementNamed(context, "/flowersSamplesScreen"),
      );
    }
    if (widget.uncoloredImage == AppImages.floweruncolored2) {
      if (PaintingProgress.gamesCounter == 6) {
        _increaseCounterGame();
        context.read<ProfileInfoCubit>().updatePaintingProgress(
            paintingGameCounter: PaintingProgress.gamesCounter,
            paintingLevelCounter: PaintingProgress.levelsCounter);
        PaintingProgress.lockedflowers = 2;
      }
      showWinScreen(
        context,
        () => Navigator.pushReplacementNamed(context, "/flowersSamplesScreen"),
      );
    }
    if (widget.uncoloredImage == AppImages.floweruncolored3) {
      if (PaintingProgress.gamesCounter == 7) {
        _increaseCounterGame();
        context.read<ProfileInfoCubit>().updatePaintingProgress(
            paintingGameCounter: PaintingProgress.gamesCounter,
            paintingLevelCounter: PaintingProgress.levelsCounter);
        PaintingProgress.lockedflowers = 3;
      }
      showWinScreen(
        context,
        () => Navigator.pushReplacementNamed(context, "/flowersSamplesScreen"),
      );
    }
    if (widget.uncoloredImage == AppImages.floweruncolored4) {
      if (PaintingProgress.gamesCounter == 8) {
        _increaseCounterGame();
        context.read<ProfileInfoCubit>().updatePaintingProgress(
            paintingGameCounter: PaintingProgress.gamesCounter,
            paintingLevelCounter: PaintingProgress.levelsCounter);
      }
      showWinScreen(
        context,
        () => Navigator.pushReplacementNamed(context, "/mypaintingScreen"),
      );
    }
  }
}
