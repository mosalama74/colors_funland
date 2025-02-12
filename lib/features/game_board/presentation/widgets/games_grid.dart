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
      decoration: BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
          image: AssetImage(AppImages.cardBoard),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 49.w, vertical: 74.5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: _buildGameItems(context),
        ),
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
        onTap: () {},
      ),
      _buildGameItem(
        image: AppImages.matchColors,
        title: AppStrings.matchColors,
        onTap: () {},
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
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            image,
            height: 284.h,
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
