import 'package:color_funland/core/components/custom_text_field.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputChildInfoWidget extends StatelessWidget {
  const InputChildInfoWidget(
      {super.key, required this.nameController, required this.ageController});

  final TextEditingController nameController;
  final TextEditingController ageController;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Your Child Name',
              style: ts18Purble700,
            ),
            SizedBox(height: 17.h),
            CustomTextField(
              controller: nameController,
              width: 245.w,
            ),
          ],
        ),
        SizedBox(width: 32.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Child Age',
              style: ts18Purble700,
            ),
            SizedBox(height: 17.h),
            CustomTextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              maxLength: 2,
              width: 245.w,
            ),
          ],
        ),
      ],
    );
  }
}
