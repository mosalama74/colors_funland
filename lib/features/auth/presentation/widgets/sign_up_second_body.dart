import 'package:color_funland/core/components/custom_text_field.dart';
import 'package:color_funland/core/components/elevated_btn.dart';
import 'package:color_funland/core/constants/app_strings.dart';
import 'package:color_funland/core/utils/app_colors.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:color_funland/core/components/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpSecondBody extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onSignUp;
  final bool isLoading;

  const SignUpSecondBody({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onSignUp,
    required this.isLoading,
  });

  @override
  State<SignUpSecondBody> createState() => _SignUpSecondBodyState();
}

class _SignUpSecondBodyState extends State<SignUpSecondBody> {
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm password';
    }
    if (value != widget.passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

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
        // Username Field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.username,
              style: ts18Purble700,
            ),
            SizedBox(height: 17.h),
            CustomTextField(
              controller: widget.usernameController,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter username' : null,
              textInputAction: TextInputAction.next,
            ),
          ],
        ),
        SizedBox(height: 21.h),

        // Password Field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.password,
              style: ts18Purble700,
            ),
            SizedBox(height: 17.h),
            PasswordField(
              controller: widget.passwordController,
              validator: _validatePassword,
            ),
          ],
        ),
        SizedBox(height: 17.h),

        // confirm Password Field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.retypePassword,
              style: ts18Purble700,
            ),
            SizedBox(height: 17.h),
            PasswordField(
              controller: widget.confirmPasswordController,
              validator: _validateConfirmPassword,
            ),
          ],
        ),

        SizedBox(height: 41.h),

        // Next Button
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 90.w),
          child: ElevatedBtn(
            text: AppStrings.next,
            onPressed: widget.isLoading ? () {} : widget.onSignUp,
            width: double.infinity,
            child: widget.isLoading
                ?  CircularProgressIndicator(color: cWhiteColor)
                : null,
          ),
        ),
      ],
    );
  }
}
