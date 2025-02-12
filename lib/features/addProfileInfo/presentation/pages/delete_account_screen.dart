import 'package:color_funland/core/components/custom_text_field.dart';
import 'package:color_funland/core/components/elevated_btn.dart';
import 'package:color_funland/core/constants/app_common_padding.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/constants/app_strings.dart';
import 'package:color_funland/core/utils/app_colors.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({
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
                        SizedBox(height: 42.h),
                        Text(
                          AppStrings.deleteAccount,
                          style: ts52Black400,
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          AppStrings.deleteAccountText,
                          style: ts16Grey700,
                        ),
                        SizedBox(height: 32.h),

                        Text(
                          AppStrings.confirmDelete,
                          style: ts18Purble700,
                        ),
                        SizedBox(height: 17.h),
                        const CustomTextField(),
                        SizedBox(height: 32.h),

                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: ElevatedBtn(
                                isDelete: true,
                                text: AppStrings.delete,
                                onPressed: () {},
                                width: double.infinity,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  backgroundColor: AppColors.cWhiteColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(8.0.r)),
                                ),
                                child: Text(
                                  AppStrings.cancel,
                                  style: ts17Black700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 46.h),
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
