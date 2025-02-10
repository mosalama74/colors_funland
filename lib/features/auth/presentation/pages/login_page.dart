import 'package:color_funland/core/components/circular_indicator.dart';
import 'package:color_funland/core/components/custom_text_field.dart';
import 'package:color_funland/core/components/elevated_btn.dart';
import 'package:color_funland/core/constants/app_common_padding.dart';
import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/constants/app_strings.dart';
import 'package:color_funland/core/services/message_service.dart';
import 'package:color_funland/core/utils/app_colors.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:color_funland/core/components/password_text_field.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            context.read<AuthCubit>().messageService.showMessage(
                  state.message,
                  MessageType.error,
                );
          } else if (state is AuthSuccess) {
            Navigator.pushReplacementNamed(context, '/home');
          }
          // } else if (state is EmailVerificationRequired) {
          //   context.read<AuthCubit>().messageService.showMessage(
          //         'Please verify your email before continuing',
          //         MessageType.warning,
          //       );
          //   Navigator.pushReplacementNamed(context, '/email-verification');
          // } else if (state is EmailVerificationSuccess) {
          //   context.read<AuthCubit>().messageService.showMessage(
          //         'Email verified successfully!',
          //         MessageType.success,
          //       );
          //   Navigator.pushReplacementNamed(context, '/home');
          // }
        },
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.loginBg),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: AppCommonPadding.loginPagePadding,
                  child: SingleChildScrollView(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      color: cWhiteColor,
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 78.w, vertical: 59.h),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Logo
                              logoImage,
                              SizedBox(height: 24.h),

                              // Login Text
                              Text(
                                AppStrings.login,
                                style: ts48Black400,
                              ),
                              SizedBox(height: 24.h),

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
                                    controller: _emailController,
                                    icon: AppIcons.user,
                                    keyboardType: TextInputType.emailAddress,
                                    isSuffixExist: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Username is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 24.h),

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
                                    controller: _passwordController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                              // Forget Password
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, "/forgetPassword");
                                  },
                                  child: Text(
                                    AppStrings.forgetPassword,
                                    style: ts16Grey700,
                                  ),
                                ),
                              ),
                              SizedBox(height: 24.h),
                              // Login Button
                                state is AuthLoading
                                    ?  CircularIndicator()
                                    :   ElevatedBtn(
                                text: AppStrings.login,
                                onPressed: state is AuthLoading
                                    ? () {}
                                    : () {
                                        if (_formKey.currentState!.validate()) {
                                          context.read<AuthCubit>().signIn(
                                                email:
                                                    _emailController.text,
                                                password:
                                                    _passwordController.text,
                                              );
                                           
                                        }
                                      },
                                width: double.infinity,
                              ),

                              SizedBox(height: 24.h),
                              // Sign Up Row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppStrings.notHaveAccount,
                                    style: ts16Grey700,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, "/signup");
                                    },
                                    child: Text(
                                      AppStrings.signUp,
                                      style: ts16Purple700,
                                    ),
                                  ),
                                ],
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
