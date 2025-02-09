import 'package:color_funland/core/components/custom_text_field.dart';
import 'package:color_funland/core/components/elevated_btn.dart';
import 'package:color_funland/core/constants/app_common_padding.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/constants/app_strings.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.gradientBg),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: 
               AppCommonPadding.screenOuterPadding,
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        AppImages.curvedBtmCardBg,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: AppCommonPadding.forgetPasswordPagePadding,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // Logo
                       logoImage,
                        SizedBox(height: 42.h),
                        Text(
                          AppStrings.forgetPassword,
                          style: ts52Black400,
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          AppStrings.enterEmailOrPhone,
                          style: ts16Grey700,
                        ),
                        SizedBox(height: 32.h),
                        Text(
                         AppStrings.emailIdMobileNo,
                          style: ts18Purble700,
                        ),
                        SizedBox(height: 17.h),
                        const CustomTextField(),
                        SizedBox(height: 32.h),

                        // Next Button
                        Padding(
                          padding:  EdgeInsets.only(right: 90.w,left: 90.w),
                          child: ElevatedBtn(
                            text: AppStrings.send,
                            onPressed: () {
                             
                            },
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
