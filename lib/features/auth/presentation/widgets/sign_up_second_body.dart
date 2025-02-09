import 'package:color_funland/core/components/circular_indicator.dart';
import 'package:color_funland/core/components/custom_text_field.dart';
import 'package:color_funland/core/components/elevated_btn.dart';
import 'package:color_funland/core/components/password_text_field.dart';
import 'package:color_funland/core/constants/app_strings.dart';
import 'package:color_funland/core/services/message_service.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpSecondBody extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String username;

  const SignUpSecondBody({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
  });

  @override
  State<SignUpSecondBody> createState() => _SignUpSecondBodyState();
}

class _SignUpSecondBodyState extends State<SignUpSecondBody> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();

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
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          context.read<AuthCubit>().messageService.showMessage(
                state.message,
                MessageType.error,
              );
        } else if (state is EmailVerificationSent) {
          context.read<AuthCubit>().messageService.showMessage(
                'Verification email sent to ${state.email}',
                MessageType.info,
              );
          Navigator.pushReplacementNamed(context, '/email-verification');
        } else if (state is AuthSuccess) {
          context.read<AuthCubit>().messageService.showMessage(
                'Account created successfully!',
                MessageType.success,
              );
          Navigator.pushReplacementNamed(context, '/addProfileInfo');
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
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
                    controller: _usernameController,
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
                controller: _passwordController,
                validator: _validatePassword,
              ),
              SizedBox(height: 24.h),
              Text(
                AppStrings.retypePassword,
                style: ts18Purble700,
              ),
              SizedBox(height: 17.h),
              PasswordField(
                controller: _confirmPasswordController,
                validator: _validateConfirmPassword,
              ),
              SizedBox(height: 32.h),
              state is AuthLoading
                  ? const CircularIndicator()
                  : ElevatedBtn(
                      text: AppStrings.next,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().signUp(
                                firstName: widget.firstName,
                                lastName: widget.lastName,
                                email: widget.email,
                                username: widget.username,
                                password: _passwordController.text,
                              );
                        }
                      },
                      width: double.infinity,
                    ),
            ],
          ),
        );
      },
    );
  }
}
