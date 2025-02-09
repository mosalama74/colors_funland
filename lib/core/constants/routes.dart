import 'package:color_funland/features/addProfileInfo/presentation/pages/addd_profile_info.dart';
import 'package:color_funland/features/addProfileInfo/presentation/pages/change_password_screen.dart';
import 'package:color_funland/features/addProfileInfo/presentation/pages/delete_account_screen.dart';
import 'package:color_funland/features/addProfileInfo/presentation/pages/forget_password_screen.dart';
import 'package:color_funland/features/auth/presentation/pages/landing_page.dart';
import 'package:color_funland/features/auth/presentation/pages/login_page.dart';
import 'package:color_funland/features/auth/presentation/pages/signup_screen.dart';
import 'package:color_funland/features/home_screen.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes =  {
                '/': (context) => const LandingPage(),
                '/login': (context) => const LoginScreen(),
                '/signup': (context) => const SignUpScreen(isFirstPage: true),
                '/addProfileInfo': (context) => const AddProfileInfo(),
                '/forgetPassword': (context) => const ForgetPasswordScreen(),
                '/changePassword': (context) => const ChangePasswordScreen(),
                '/deleteAccount': (context) => const DeleteAccountScreen(),
                '/home': (context) =>
                    const HomeScreen(), 

              };

