import 'package:color_funland/core/components/circular_indicator.dart';
import 'package:color_funland/core/components/custom_text_field.dart';
import 'package:color_funland/core/components/elevated_btn.dart';
import 'package:color_funland/core/components/password_text_field.dart';
import 'package:color_funland/core/constants/app_strings.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpSecondBody extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController usernameController;
  final String? Function(String?)? validatorpassword;
  final String? Function(String?)? validateConfirmPassword;
  final void Function() onPressed;

  const SignUpSecondBody({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.usernameController,
    required this.validatorpassword,
    required this.validateConfirmPassword,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  controller: usernameController,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter username' : null,
                  textInputAction: TextInputAction.next,
                ),
              ],
            ),
            SizedBox(height: 21.h),
            Text(
              AppStrings.password,
              style: ts18Purble700,
            ),
            SizedBox(height: 17.h),
            PasswordField(
              controller: passwordController,
              validator: validatorpassword,
            ),
            SizedBox(height: 24.h),
            Text(
              AppStrings.retypePassword,
              style: ts18Purble700,
            ),
            SizedBox(height: 17.h),
            PasswordField(
              controller: confirmPasswordController,
              validator: validateConfirmPassword,
            ),
            SizedBox(height: 32.h),
            state is AuthLoading
                ? const CircularIndicator()
                : ElevatedBtn(
                    text: AppStrings.next,
                    onPressed:onPressed ,
                    width: double.infinity,
                  ),
          ],
        );
      },
    );
  }
}
