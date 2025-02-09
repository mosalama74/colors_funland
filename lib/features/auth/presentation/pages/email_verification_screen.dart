import 'package:color_funland/core/components/elevated_btn.dart';
import 'package:color_funland/core/services/message_service.dart';
import 'package:color_funland/core/utils/app_colors.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is EmailVerificationSuccess) {
            context.read<AuthCubit>().messageService.showMessage(
                  'Email verified successfully!',
                  MessageType.success,
                );
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is AuthError) {
            context.read<AuthCubit>().messageService.showMessage(
                  state.message,
                  MessageType.error,
                );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.email_outlined,
                    size: 80.sp,
                    color: cPurpleColor,
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Verify your email',
                    style: ts18Purble700,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'We have sent you an email verification link.\nPlease check your email and verify your account.',
                    style: ts16Grey700,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.h),
                  if (state is EmailVerificationSent)
                    Text(
                      'Verification email sent to ${state.email}',
                      style: ts18Purble700,
                      textAlign: TextAlign.center,
                    ),
                  SizedBox(height: 32.h),
                  state is AuthLoading
                      ? CircularProgressIndicator(color: cPurpleColor)
                      : Column(
                          children: [
                            ElevatedBtn(
                              text: 'Resend Verification Email',
                              onPressed: () {
                                context.read<AuthCubit>().sendEmailVerification();
                              },
                              width: double.infinity,
                            ),
                            SizedBox(height: 16.h),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, '/login');
                              },
                              child: Text(
                                'Back to Login',
                                style: ts16Purple700,
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
