import 'package:color_funland/core/components/background_sound.dart';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomToggleButton extends StatefulWidget {
  const CustomToggleButton({
    super.key,
  });

  @override
  _CustomToggleButtonState createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  late bool isToggled;

  @override
  void initState() {
    super.initState();
    isToggled = BackgroundAudio.isPlaying();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            setState(() {
              isToggled = !isToggled;

              if (BackgroundAudio.isPlaying()) {
                BackgroundAudio.pauseBackgroundMusic();
              } else {
                BackgroundAudio.resumeBackgroundMusic();
              }
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: 63.w,
            height: 36.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(
                  isToggled ?  AppImages.switchbutton : AppImages.switchbuttonfalse,
                  ),
                  fit: BoxFit.cover,
                )),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: Duration(milliseconds: 300),
                  left: isToggled ? 35.w : 5.w,
                  top: 8.h,
                  child: Container(
                    width: 21.w,
                    height: 21.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff372246),
                          blurRadius: 5,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
