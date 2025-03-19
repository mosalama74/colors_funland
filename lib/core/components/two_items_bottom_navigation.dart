import 'package:color_funland/core/components/background_sound.dart';
import 'package:color_funland/core/constants/app_icons.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:color_funland/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TwoItemsBottomNavigation extends StatefulWidget {
  const TwoItemsBottomNavigation({
    super.key,
    required this.insideGame,
    this.onBackPressed,
  });

  final bool insideGame;
  final VoidCallback? onBackPressed;

  @override
  _TwoItemsBottomNavigationState createState() => _TwoItemsBottomNavigationState();
}

class _TwoItemsBottomNavigationState extends State<TwoItemsBottomNavigation> {
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    isPlaying = BackgroundAudio.isPlaying();
  }

  void _toggleMusic() async {
    setState(() {
      isPlaying = !isPlaying;
    });

    if (isPlaying) {
      await BackgroundAudio.resumeAllSounds();
    } else {
      await BackgroundAudio.pauseAllSounds();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 34.51.w),
      child: SizedBox(
        height: 81.07.h,
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSignedOut) {
              Navigator.pushNamed(context, '/login');
            }
          },
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: widget.onBackPressed,
                  child: widget.insideGame == true
                      ? SvgPicture.asset(
                          AppIcons.backButton,
                          height: 81.07.h,
                          width: 79.08.w,
                        )
                      : InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            context.read<AuthCubit>().signOut();
                          },
                          child: SvgPicture.asset(
                            AppIcons.logoutButton,
                            height: 90.82.h,
                            width: 227.w,
                          ),
                        ),
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: _toggleMusic, // ✅ Toggle sound correctly
                  child: SvgPicture.asset(
                   AppIcons.soundButton,
                    width: 79.08.w,
                    height: 81.07.h,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
