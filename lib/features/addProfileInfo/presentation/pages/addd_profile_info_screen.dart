import 'package:color_funland/core/components/elevated_btn.dart';
import 'package:color_funland/core/constants/app_common_padding.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/constants/app_strings.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:color_funland/features/addProfileInfo/presentation/widgets/add_photo_widget.dart';
import 'package:color_funland/features/addProfileInfo/presentation/widgets/input_child_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddProfileInfoScreen extends StatefulWidget {
  const AddProfileInfoScreen({
    super.key,
  });

  @override
  State<AddProfileInfoScreen> createState() => _AddProfileInfoScreenState();
}

class _AddProfileInfoScreenState extends State<AddProfileInfoScreen> {
  bool _isFirstPage = true;

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
              padding: AppCommonPadding.screenOuterPadding,
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        _isFirstPage
                            ? AppImages.curvedBtmCardBg
                            : AppImages.cardBg,
                      ),
                    ),
                  ),
                  child: Padding(
                        padding: EdgeInsets.only(left: 58.w,right: 57.w,top: 46.h,bottom: 46.23.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Logo
                        Padding(
                          padding: EdgeInsets.only(left: 10.w,top: 10.h),
                          child: logoImage,
                        ),
                        SizedBox(height: 10.h),
                    
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(AppStrings.welcome, style: ts32Black400),
                              Text("Sarah", style: ts64Purple400),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                    
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: const AddPhotoWidget(),
                        ),
                        SizedBox(height: 32.h),
                    
                        const InputChildInfoWidget(),
                        SizedBox(height: 32.h),
                    
                        // Next Button
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 93.5.w),
                          child: ElevatedBtn(
                            
                            text: _isFirstPage
                                ? "Let’s Start"
                                : "Save  and Login in",
                            onPressed: () {
                              _isFirstPage
                                  ? setState(() {
                                      _isFirstPage = false;
                                    })
                                  : setState(() {
                                      Navigator.pushReplacementNamed(context, "/home");
                                    });
                            },
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
