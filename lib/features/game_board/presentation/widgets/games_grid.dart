import 'package:color_funland/core/constants/app_images.dart';
import 'package:color_funland/core/constants/app_strings.dart';
import 'package:color_funland/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Games extends StatelessWidget {
  const Games({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 440.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
          image: AssetImage(AppImages.cardBoard),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: _buildGameItems(context),
      ),
    );
  }

  List<Widget> _buildGameItems(BuildContext context) {
    return [
      _buildGameItem(
        image: AppImages.myPainting,
        title: AppStrings.myPainting,
        onTap: () => Navigator.pushNamed(
          context,
          '/mypaintingScreen',
        ),
      ),
      _buildGameItem(
        image: AppImages.colorMixing,
        title: AppStrings.colorMixing,
        onTap: () => Navigator.pushNamed(
          context,
          '/colorMixingScreen',
        ),
      ),
      _buildGameItem(
        image: AppImages.matchColors,
        title: AppStrings.matchColors,
        onTap: () => Navigator.pushNamed(context, "/colorMatchScreen"),
      ),
      _buildGameItem(
        image: AppImages.learningColors,
        title: AppStrings.learningColors,
        onTap: () {},
      ),
    ];
  }

  Widget _buildGameItem({
    required String image,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            image,
            width: 233.w,
          ),
          Text(
            title,
            style: ts24minnie400,
          ),
        ],
      ),
    );
  }
}
