import 'package:color_funland/core/components/animated_container_widget.dart';
import 'package:color_funland/core/components/app_bar_row.dart';
import 'package:color_funland/core/components/three_items_bottom_navigation.dart';
import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ColorMatchAnimals extends StatefulWidget {
  const ColorMatchAnimals({super.key});

  @override
  State<ColorMatchAnimals> createState() => _ColorMatchAnimalsState();
}

class _ColorMatchAnimalsState extends State<ColorMatchAnimals> {
  final GlobalKey<AnimatedContainerState> _containerKey = GlobalKey();

  List<String> sourceList = [
    AppImages.animalColorMatchFish,
    AppImages.animalColorMatchInsect,
    AppImages.animalColorMatchFrog,
    AppImages.animalColorMatchColoredBird,
    AppImages.animalColorMatchBird,
    AppImages.animalColorMatchUnicorn,
    AppImages.animalcolormatchsnake,
  ];
  List<String> targetList = [AppImages.animalColorMatchTiger];

  // خريطة لتحديد الحيوانات التي لها نفس اللون
  final Map<String, List<String>> animalColorGroups = {
    AppImages.animalColorMatchTiger: [
      AppImages.animalColorMatchBird,
      AppImages.animalColorMatchFish,
    ],
  };

  void checkAnimalMatch(String selectedAnimal) {
    setState(() {
      if (animalColorGroups[AppImages.animalColorMatchTiger] ?.contains(selectedAnimal) ?? false) {
        sourceList.remove(selectedAnimal); 
        targetList.add(selectedAnimal);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              padding: EdgeInsets.only(right: 52.w, left: 46.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 37.w),
                        child: InkWell(
                          onTap: () {},
                          child: SizedBox(
                            width: 67.w,
                            height: 67.h,
                            child: SvgPicture.asset(AppIcons.help),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: AlignmentDirectional.center,
                          child: Text("Animals", style: ts64Magic400),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 91.w),
                    child: DragTarget<String>(
                      onAccept: (item) {
                        checkAnimalMatch(item);
                      },
                      builder: (context, candidateData, rejectedData) {
                        return Container(
                          height: 200.h,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Color(0xffFFAE0F),
                            borderRadius: BorderRadius.circular(180.r),
                            border: Border.all(
                              color: Color(0xffD18B00),
                              width: 9.w,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: targetList
                                .map((item) => Padding(
                                      padding: EdgeInsets.only(left: 10.w),
                                      child: _Card(image: item),
                                    ))
                                .toList(),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    height: 153.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: sourceList
                          .map(
                            (item) => Draggable(
                              data: item,
                              feedback: Material(
                                child: _Card(image: item),
                              ),
                              childWhenDragging: Opacity(
                                opacity:
                                    0.5, 
                                child: _Card(image: item),
                              ),
                              child: _Card(image: item),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainerWidget(key: _containerKey),
          ],
        ),
      ),
      bottomNavigationBar: ThreeItemsBottomNavigation(insideGame: true),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.h,
      width: 160.w,
      child: Card(
        color: Colors.white,
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.4.w, vertical: 20.h),
          child: SvgPicture.asset(image),
        ),
      ),
    );
  }
}
