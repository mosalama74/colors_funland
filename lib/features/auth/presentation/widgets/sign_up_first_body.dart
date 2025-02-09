import 'package:color_funland/core/components/custom_text_field.dart';
import 'package:color_funland/core/components/elevated_btn.dart';
import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/constants/app_strings.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpFirstBody extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
    final String? Function(String?) emailValidator;

  final VoidCallback onNext;

  const SignUpFirstBody({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.onNext,
    required this.emailValidator,
  });



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Login Text
        Text(
          AppStrings.signUp,
          style: ts48Black400,
        ),
        SizedBox(height: 20.h),

        Text(
          AppStrings.parentInfo,
          style: ts18Black400,
        ),
        SizedBox(height: 20.h),

        // Username Field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.firstName,
              style: ts18Purble700,
            ),
            SizedBox(height: 17.h),
            CustomTextField(
              controller: firstNameController,
              icon: AppIcons.user,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter first name' : null,
              textInputAction: TextInputAction.next,
            ),
          ],
        ),

        SizedBox(height: 21.h),

        //lastname Field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.lastName,
              style: ts18Purble700,
            ),
            SizedBox(height: 17.h),
            CustomTextField(
              controller: lastNameController,
              icon: null,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter last name' : null,
              textInputAction: TextInputAction.next,
            ),
          ],
        ),

        //email Field
        SizedBox(height: 21.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.email,
              style: ts18Purble700,
            ),
            SizedBox(height: 17.h),
            CustomTextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              validator: emailValidator,

            ),
          ],
        ),
        SizedBox(height: 41.h),

        // Next Button
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 90.w),
          child: ElevatedBtn(
            text: AppStrings.next,
            onPressed: onNext,
            width: double.infinity,
          ),
        ),
      ],
    );
  }
}
