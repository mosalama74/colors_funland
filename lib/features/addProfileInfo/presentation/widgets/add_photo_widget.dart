import 'package:color_funland/core/utils/text_styles.dart';
import 'package:color_funland/features/addProfileInfo/presentation/widgets/upload_camera_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPhotoWidget extends StatelessWidget {
  const AddPhotoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
    
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Child Photo", style: ts18Purble700),
            SizedBox(height: 12.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                UploadCameraField(
                  icon: "assets/icons/upload.svg",
                  text: "Upload",
                  onTap: () {},
                ),
                UploadCameraField(
                  icon: "assets/icons/camera.svg",
                  text: "Camera",
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
        SizedBox(width: 12.w),
        Container(
          height: 180.h,
          width: 180.w,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage("assets/images/uploadimg.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );

    // Input
  }
}
