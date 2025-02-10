import 'package:color_funland/core/constants/app_common_padding.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/utils/app_colors.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_state.dart';
import 'package:color_funland/features/auth/presentation/widgets/sign_up_first_body.dart';
import 'package:color_funland/features/auth/presentation/widgets/sign_up_second_body.dart';
import 'package:color_funland/core/services/message_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, required this.isFirstPage});
  final bool isFirstPage;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isFirstStep = true;

  void _moveToNextStep() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isFirstStep = false;
      });
    }
  }

  void _handleOnPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().signUp(
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            email: _emailController.text,
            username: _usernameController.text,
            password: _passwordController.text,
          );
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    // Regular expression for email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

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
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.gradientBg),
          fit: BoxFit.cover,
        ),
      ),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            context.read<AuthCubit>().messageService.showMessage(
                  state.message,
                  MessageType.error,
                );
          } else if (state is EmailVerificationRequired) {
            context.read<AuthCubit>().messageService.showMessage(
                  'Please verify your email before continuing',
                  MessageType.info,
                );
            Navigator.pushReplacementNamed(context, '/email-verification');
          } else if (state is EmailVerificationSent) {
            context.read<AuthCubit>().messageService.showMessage(
                  'Verification email sent to ${state.email}',
                  MessageType.info,
                );
            Navigator.pushReplacementNamed(context, '/email-verification');
          } else if (state is EmailVerificationSuccess) {
            context.read<AuthCubit>().messageService.showMessage(
                  'Email verified successfully!',
                  MessageType.success,
                );
            Navigator.pushReplacementNamed(context, '/addProfileInfo');
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: AppCommonPadding.screenOuterPadding,
                  child: SingleChildScrollView(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.r),
                      ),
                      color: cWhiteColor,
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 61.w,
                            vertical: _isFirstStep ? 15.62.h : 41.62.h),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Logo
                              logoImage,
                              SizedBox(height: 20.h),

                              _isFirstStep
                                  ? SignUpFirstBody(
                                      firstNameController: _firstNameController,
                                      lastNameController: _lastNameController,
                                      emailController: _emailController,
                                      emailValidator: _validateEmail,
                                      onNext: _moveToNextStep,
                                    )
                                  : SignUpSecondBody(
                                      confirmPasswordController:
                                          _confirmPasswordController,
                                      passwordController: _passwordController,
                                      usernameController: _usernameController,
                                      validatorpassword: _validatePassword,
                                      validateConfirmPassword:
                                          _validateConfirmPassword,
                                      onPressed: _handleOnPressed,
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
