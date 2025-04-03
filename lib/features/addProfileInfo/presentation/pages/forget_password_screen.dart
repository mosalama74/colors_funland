import 'package:color_funland/core/components/custom_text_field.dart';
import 'package:color_funland/core/components/elevated_btn.dart';
import 'package:color_funland/core/constants/app_common_padding.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/constants/app_strings.dart';
import 'package:color_funland/core/services/message_service.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({
    super.key,
  });

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ForgetPasswordSuccess) {
          context.read<AuthCubit>().messageService.showMessage(
                state.message,
                MessageType.success,
              );
              Navigator.pushNamed(context, '/login');
        } else if (state is ForgetPasswordError) {
          context.read<AuthCubit>().messageService.showMessage(
                state.message,
                MessageType.error,
              );
        }
      },
      child: Container(
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
                          CustomTextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,

                          ),
                          SizedBox(height: 32.h),

                          // Next Button
                          Padding(
                            padding: EdgeInsets.only(right: 90.w, left: 90.w),
                            child: ElevatedBtn(
                              text: AppStrings.send,
                              onPressed: () {
                                String email = emailController.text.trim();
                                if (email.isNotEmpty) {
                                  context
                                      .read<AuthCubit>()
                                      .resetPassword(email);
                                } else {
                                  context
                                      .read<AuthCubit>()
                                      .messageService
                                      .showMessage(
                                        "Please enter your email",
                                        MessageType.error,
                                      );
                                }
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
      ),
    );
  }
}
