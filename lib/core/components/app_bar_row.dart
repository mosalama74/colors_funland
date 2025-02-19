import 'package:color_funland/core/components/animated_container_widget.dart';
import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/utils/app_colors.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

final GlobalKey<AnimatedContainerState> containerKey = GlobalKey();

class AppBarRow extends StatelessWidget implements PreferredSizeWidget {
  const AppBarRow({
    super.key,
    required this.gameGroup,
    required this.inSideGame,
    this.appBarIcon = "",
  });

  final String gameGroup;
  final bool inSideGame;
  final String appBarIcon;

  @override
  Size get preferredSize => Size.fromHeight(100.h);

  @override
  Widget build(BuildContext context) {
    return
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(46.w, 0, 52.w, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  appBarlogoImage,
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      // Handle state changes if needed
                    },
                    builder: (context, state) {
                      String username = '';
                      if (state is AuthSuccess) {
                        username = state.user.firstName; 
                         // Or combine firstName + lastName
                      }
                      return Row(
                        children: [
                          Text(
                            username,  // Display the username
                            style: bubleStyle,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(width: 16.w),
                          divider,
                          SizedBox(width: 16.w),
                          Text(
                            gameGroup,
                            style: ts36minnie400,
                          ),
                          SizedBox(width: 16.w),
                          if (inSideGame)
                            SizedBox(
                              width: 63.w,
                              height: 63.h,
                              child: SvgPicture.asset(appBarIcon),
                            ),
                        ],
                      );
                    },
                  ),
                  Row(
                    children: [
                      Stack(children: [
                        SvgPicture.asset(AppImages.yellowshadow,
                            width: 126.w, height: 133.h,fit: BoxFit.contain,),
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
                                    radius:
                                        36.0.r, // Radius of the inner CircleAvatar
                                    backgroundImage:
                                        AssetImage(AppImages.childPhoto,),),
                              ),
                            )),
                      ]),
                      InkWell(
                        onTap: (){
                          containerKey.currentState?.toggleContainer();
                        },
                        child: SvgPicture.asset(
                          AppIcons.menu,
                          width: 49.w,
                          height: 49.h,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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

Widget divider = Container(
  width: 4.w,
  height: 35.h,
  color: AppColors.cBlackColor,
);