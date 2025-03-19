import 'package:color_funland/core/constants/app_strings.dart';
import 'package:color_funland/core/constants/app_theme.dart';
import 'package:color_funland/core/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorFunLandApp extends StatefulWidget {

  const ColorFunLandApp({
    Key? key,
  }) ;

  @override
  State<ColorFunLandApp> createState() => _ColorFunLandAppState();
}

class _ColorFunLandAppState extends State<ColorFunLandApp> {
  @override
  void initState() {
    super.initState();
  }



 

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1280, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        theme: lightTheme,
        routes: routes,
      ),
    );
  }
}
