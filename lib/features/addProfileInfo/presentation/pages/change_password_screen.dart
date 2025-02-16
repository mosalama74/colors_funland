import 'package:color_funland/core/components/elevated_btn.dart';
import 'package:color_funland/core/components/password_text_field.dart';
import 'package:color_funland/core/constants/app_common_padding.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/constants/app_strings.dart';
import 'package:color_funland/core/utils/app_colors.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({
    super.key,
  });

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    // Check for minimum length
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    // Check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _handleOnPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().changePassword(
          currentPassword: _currentPasswordController.text,
          newPassword: _newPasswordController.text);
    }
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if(state is ChangePasswordSuccess){
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
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
                        child: Form(
                          key: _formKey,
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
                                AppStrings.currentPassword,
                                style: ts18Purble700,
                              ),
                              SizedBox(height: 17.h),
                              PasswordField(
                                controller: _currentPasswordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter your Current Password';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 21.h),

                              Text(
                                AppStrings.newPassword,
                                style: ts18Purble700,
                              ),
                              SizedBox(height: 17.h),
                              PasswordField(
                                controller: _newPasswordController,
                                validator: _validatePassword,
                              ),
                              SizedBox(height: 21.h),

                              Text(
                                AppStrings.retypePassword,
                                style: ts18Purble700,
                              ),
                              SizedBox(height: 17.h),
                              PasswordField(
                                controller: _confirmPasswordController,
                                validator: _validateConfirmPassword,
                              ),
                              SizedBox(height: 86.5.h),

                              // Next Button
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 90.w),
                                child: ElevatedBtn(
                                  text: AppStrings.next,
                                  onPressed: _handleOnPressed,
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
        },
      ),
    );
  }
}
