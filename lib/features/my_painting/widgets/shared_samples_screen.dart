import 'package:color_funland/core/components/animated_container_widget.dart';
import 'package:color_funland/core/components/app_bar_row.dart';
import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/components/three_items_bottom_navigation.dart';
import 'package:color_funland/features/my_painting/model.dart';
import 'package:color_funland/features/my_painting/widgets/sample_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SharedSamplesScreen extends StatefulWidget {
  const SharedSamplesScreen(
      {super.key,
      required this.frames,
      required this.paintingImages,
      required this.title});

  final List<GridItem> frames;
  final List<String> paintingImages;
  final String title;

  @override
  State<SharedSamplesScreen> createState() => _SharedSamplesScreenState();
}

class _SharedSamplesScreenState extends State<SharedSamplesScreen> {
  final GlobalKey<AnimatedContainerState> _containerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
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
                padding: EdgeInsets.only(left: 46.w, right: 52.w),
                child: SampleScreenWidget(
                  title: widget.title,
                  gridHeight: MediaQuery.of(context).size.height * .56,
                  items: widget.frames,
                  crossAxisCount: 5,
                  pageGroup: widget.paintingImages,
                  insidecategory: false,
                  insideanimals: true,
                  childAspectRatio: 1 / .90,
                ),
              ),
              AnimatedContainerWidget(key: _containerKey),
            ],
          ),
        ),
        bottomNavigationBar: ThreeItemsBottomNavigation(
          insideGame: true,
          onBackPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
