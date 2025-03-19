import 'package:color_funland/core/components/animated_container_widget.dart';
import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/utils/app_colors.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:color_funland/features/addProfileInfo/presentation/cubit/profile_info_cubit.dart';
import 'package:color_funland/features/addProfileInfo/presentation/cubit/profile_info_state.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AppBarRow extends StatelessWidget implements PreferredSizeWidget {
  const AppBarRow({
    super.key,
    required this.gameGroup,
    required this.inSideGame,
    this.appBarIcon = "",
    this.containerKey,// Receive the key
    this.gameGroupColor,
    this.dividerColor, 
    this.menu, 
  });

  final String gameGroup;
  final String? menu;
  final Color? gameGroupColor;
  final Color? dividerColor;
  final bool inSideGame;
  final String appBarIcon;
  final GlobalKey<AnimatedContainerState>?
      containerKey; // Accept per-screen key

  @override
  Size get preferredSize => Size.fromHeight(100.h);

  @override
  Widget build(BuildContext context) {
    String childname = '';
    String? imageUrl;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.read<AuthCubit>().signInUseCase;
        }
      },
      builder: (context, state) {
        if (state is AuthSuccess) {
          childname = state.user.childName ?? '';
          imageUrl = state.user.childImageUrl;
        }

        return AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(46.w, 0, 52.w, 0),
              child: BlocConsumer<ProfileInfoCubit, ProfileInfoState>(
                listener: (context, state) {
                  // Fetch child data when profile is saved successfully
                  if (state is SaveChildInfoSuccessState) {
                    context.read<ProfileInfoCubit>().getCurrentChild();
                  }
                },
                builder: (context, state) {
                  if (state is GetChildSuccessState) {
                    childname = state.child['name'] ?? '';
                    imageUrl = state.child['profileImage'];
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      appBarlogoImage,
                      Row(
                        children: [
                          Text(
                            childname,
                            style: bubleStyle,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(width: 16.w),
                          Container(
                            width: 4.w,
                            height: 35.h,
                            color: dividerColor ?? AppColors.cBlackColor,
                          ),
                          SizedBox(width: 16.w),
                          Text(
                            gameGroup,
                            style:
                                ts36minnie400.copyWith(color: gameGroupColor),
                          ),
                          SizedBox(width: 16.w),
                          if (inSideGame)
                            SizedBox(
                              width: 63.w,
                              height: 63.h,
                              child: SvgPicture.asset(appBarIcon),
                            ),
                        ],
                      ),
                      Row(
                        children: [
                          Stack(children: [
                            SvgPicture.asset(
                              AppImages.yellowshadow,
                              width: 126.w,
                              height: 133.h,
                              fit: BoxFit.contain,
                            ),
                            Positioned(
                              bottom: 15.25.h,
                              top: 30.75.h,
                              left: 27.w,
                              right: 21.33.w,
                              child: Container(
                                width: 68.w,
                                height: 68.h,
                                decoration: _buildContainerDecoration2(),
                                child: ClipOval(
                                  child: CircleAvatar(
                                    radius: 36.0.r,
                                    backgroundColor: AppColors.cGreyColor,
                                    backgroundImage:
                                        imageUrl != null && imageUrl!.isNotEmpty
                                            ? NetworkImage(imageUrl!)
                                            : null,
                                    child:
                                        (imageUrl == null || imageUrl!.isEmpty)
                                            ? Icon(Icons.person,
                                                color: AppColors.cWhiteColor,
                                                size: 24.r)
                                            : null,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              containerKey?.currentState?.toggleContainer();
                            },
                            child: SvgPicture.asset(
                              menu ?? AppIcons.menu,
                              width: 49.w,
                              height: 49.h,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

BoxDecoration _buildContainerDecoration2() {
  return BoxDecoration(
    shape: BoxShape.circle, // Make it circular
    gradient: LinearGradient(
      colors: [
        AppColors.borderColor,
        AppColors.borderColor2
      ], // Gradient colors for the border
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    border: Border.all(
      width: 4.0, // Border width (thickness of the gradient border)
      color: Colors
          .transparent, // Making the border transparent to only show the gradient
    ),
  );
}
