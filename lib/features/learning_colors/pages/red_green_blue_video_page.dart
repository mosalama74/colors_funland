import 'package:color_funland/core/components/app_bar_row.dart';
import 'package:color_funland/core/components/learning_colors_btm_nav_bar.dart';
import 'package:color_funland/core/components/video_player.dart';
import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

class RedGreenBlueVideoPage extends StatefulWidget {
  const RedGreenBlueVideoPage({
    super.key,
    required this.lessonImage,
    required this.lessonNumber,
    required this.videoUrl,
  });
  final String lessonImage;
  final String videoUrl;
  final int lessonNumber;

  @override
  State<RedGreenBlueVideoPage> createState() => _RedGreenBlueVideoPageState();
}

class _RedGreenBlueVideoPageState extends State<RedGreenBlueVideoPage> {
  late VideoPlayerController _videoController;
  bool isVideoCompleted = false;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      })
      ..addListener(() {
        if (_videoController.value.position >=
            _videoController.value.duration) {
          setState(() {
            isVideoCompleted = true;
          });
        }
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRow(
        gameGroup: "Learning Colors",
        inSideGame: true,
        appBarIcon: AppIcons.learningcolors,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 49.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    widget.lessonImage,
                    height: 351.h,
                    width: 366.w,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        setState(() {
                          if (_videoController.value.isPlaying) {
                            _videoController.pause();
                          } else {
                            _videoController.play();
                          }
                        });
                      });
                    },
                    child: SvgPicture.asset(
                      AppImages.playsongbtn,
                      height: 59.h,
                      width: 224.w,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              flex: 3,
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: VideoPlayerScreen(
                  controller: _videoController,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: LearningColorsBtmNavBar(
        isVideoCompleted: isVideoCompleted,
        onBackPressed: () {
          Navigator.pop(context);
        },
        onNextPressed: () {
          
          switch (widget.lessonNumber) {
            case 1:
              Navigator.pushNamed(context, '/redLesson');
              break;
            case 2:
              Navigator.pushNamed(context, '/greenLesson');
              break;
            case 3:
              Navigator.pushNamed(context, '/blueLesson');
              break;
          }
        },
      ),
    );
  }

 
}
 