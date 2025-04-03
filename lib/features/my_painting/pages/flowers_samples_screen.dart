import 'package:color_funland/core/components/animated_container_widget.dart';
import 'package:color_funland/core/components/app_bar_row.dart';
import 'package:color_funland/core/components/three_items_bottom_navigation.dart';
import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/constants/frame_state_manager.dart';
import 'package:color_funland/core/constants/model.dart';
import 'package:color_funland/features/addProfileInfo/presentation/pages/child_progress_scareen.dart';
import 'package:color_funland/features/my_painting/services/painting_service.dart';
import 'package:color_funland/features/my_painting/widgets/sample_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FlowersSamplesScreen extends StatefulWidget {
  const FlowersSamplesScreen({super.key});

  @override
  State<FlowersSamplesScreen> createState() => _FlowersSamplesScreenState();
}

class _FlowersSamplesScreenState extends State<FlowersSamplesScreen> {
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
                child: FutureBuilder(
                  future: PaintingService.initialize(),
                  builder: (context, snapshot) {
                    return SampleScreenWidget(
                      title: 'Flowers',
                      items: flowersFram.map((item) {
                        return GridItem(
                          title: item.title,
                          imageUrl: PaintingProgress.isPainted(item.imageUrl.contains('uncolored') 
                              ? item.imageUrl 
                              : FrameStateManager.getFrameForPainting(item.imageUrl) ?? item.imageUrl)
                              ? FrameStateManager.getColoredFrame(item.imageUrl) ?? item.imageUrl
                              : item.imageUrl,
                          onTap: item.onTap,
                        );
                      }).toList(),
                      crossAxisCount: 5,
                      pageGroup: flowersPaintingScreen,
                      insidecategory: false,
                      insideanimals: true,
                      childAspectRatio: 1 / .90,
                    );
                  },
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
