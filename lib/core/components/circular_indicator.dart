import 'package:color_funland/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CircularIndicator extends StatelessWidget {
  const CircularIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:CircularProgressIndicator(color:AppColors.cPurpleColor) ,
    );
  }
}