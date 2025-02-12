import 'package:color_funland/core/components/gradient_box_border.dart';
import 'package:color_funland/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';


class GameStyles {
  
  static BoxDecoration gameContainerDecoration = BoxDecoration(
    color: AppColors.cWhiteColor,
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(180),
    border: GradientBoxBorder(
      gradient: LinearGradient(
        colors: [AppColors.borderColor, AppColors.borderColor2],
      ),
      width: 5,
    ),
  );
}
