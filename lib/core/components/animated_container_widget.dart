import 'package:color_funland/core/components/toggle_theme.dart';
import 'package:color_funland/core/components/toggle_sound.dart';
import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/utils/app_colors.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedContainerWidget extends StatefulWidget {
  const AnimatedContainerWidget({super.key, });

  @override
  AnimatedContainerState createState() => AnimatedContainerState();
}

class AnimatedContainerState extends State<AnimatedContainerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  bool _isContainerVisible = false;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Define the animation
    _animation = Tween<Offset>(
      begin: Offset(1.0, 0.0), // Start from the right
      end: Offset(0.0, 0.0), // Move to the left
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  // Method to toggle container visibility
  void toggleContainer() {
    setState(() {
      _isContainerVisible = !_isContainerVisible;
      if (_isContainerVisible) {
        _controller.forward(); // Start animation
      } else {
        _controller.reverse(); // Reverse animation
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _isContainerVisible,
      child: Positioned(
        top: 5.h, // Position below the AppBar
        right: 30.w,
        child: SlideTransition(
          position: _animation,
          child: menuList(context),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

Widget menuList(BuildContext context) =>
    Container(
      width: 400.h,
      padding: EdgeInsets.fromLTRB(24.w, 36.h, 16.w, 36.h),
      decoration: BoxDecoration(
        color: AppColors.cWhiteColor.withOpacity(0.99),
        borderRadius: BorderRadius.all(Radius.circular(
          64.r,
        )),
        border: Border.all(color: AppColors.cBorderColor),
      ),
      child: Column(
        children: [
          rowWithArrowButton(title: 'Progress', onTap: () {}),
          SizedBox(height: 16.h),
          rowWithArrowButton(
              title: 'Edit Profile',
              onTap: () {
                Navigator.pushNamed(context, '/addProfileInfo');
              }),
          SizedBox(height: 16.h),
          toggleItem(
            title: 'Sound',
            widget: ToggleSound(),
          ),
          SizedBox(height: 16.h),
          toggleItem(
            title: 'Theme',
            widget: ToggleTheme(
            ),
          ),
          SizedBox(height: 16.h),
          rowWithArrowButton(
              title: 'Change Password',
              onTap: () {
                Navigator.pushNamed(context, '/changePassword');
              }),
          SizedBox(height: 16.h),
          rowWithArrowButton(
              title: 'Delete Account',
              onTap: () {
                Navigator.pushNamed(context, '/deleteAccount');
              }),
          SizedBox(height: 16.h),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthSignedOut) {
                Navigator.pushNamed(context, '/login');
              }
            },
            builder: (context, state) {
              return rowWithArrowButton(
                  title: 'Logout',
                  onTap: () {
                    context.read<AuthCubit>().signOut();
                  });
            },
          ),
        ],
      ),
    );

Widget rowWithArrowButton(
    {required String title, required void Function() onTap}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.72.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: ts18minnie400,
        ),
        InkWell(
            onTap: onTap,
            child: Image.asset(
              AppIcons.forwardArrow,
              height: 33.45.h,
              width: 39.w,
            )),
      ],
    ),
  );
}

Widget toggleItem({required String title, required Widget widget}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.72.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: ts18minnie400,
        ),
        widget,
      ],
    ),
  );
}
