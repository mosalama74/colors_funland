import 'package:color_funland/core/constants/app_strings.dart';
import 'package:color_funland/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData? lightTheme = ThemeData(
            fontFamily:AppStrings.primaryFontFamily,
            useMaterial3: true,
            scaffoldBackgroundColor:AppColors. cWhiteColor,
          
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.cWhiteColor,
              elevation: 0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
                 systemNavigationBarColor: Colors.transparent,  
                systemNavigationBarIconBrightness: Brightness.dark, 
              )
            )
          );