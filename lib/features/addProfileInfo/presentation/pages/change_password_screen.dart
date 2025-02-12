import 'package:color_funland/core/components/elevated_btn.dart';
import 'package:color_funland/core/components/password_text_field.dart';
import 'package:color_funland/core/constants/app_common_padding.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/constants/app_strings.dart';
import 'package:color_funland/core/utils/app_colors.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Center(
          child: Padding(
            padding: AppCommonPadding.screenOuterPadding,
            child: SingleChildScrollView(
              child: Card(
                 shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                  color: AppColors.cWhiteColor,
                  elevation: 5,
                  child: Padding(
                    padding: AppCommonPadding.screenInnerPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo
                     logoImage,
                      SizedBox(height: 20.h),
                      Text(
                        AppStrings.changePassword,
                        style: ts48Black400,
                      ),
                      SizedBox(height: 96.5.h),
                      Text(
                        AppStrings.newPassword,
                        style: ts18Purble700,
                      ),
                      SizedBox(height: 17.h),
                      const PasswordField(),
                      SizedBox(height: 21.h),
                            
                      Text(
                        AppStrings.retypePassword,
                        style: ts18Purble700,
                      ),
                      SizedBox(height: 17.h),
                      const PasswordField(),
                      SizedBox(height: 86.5.h),
                            
                      // Next Button
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 90.w),
                        child: ElevatedBtn(
                          text: AppStrings.next,
                          onPressed: () {},
                          width: double.infinity,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
            ),
    );
  }
}
