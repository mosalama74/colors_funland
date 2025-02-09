import 'package:color_funland/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ElevatedBtn extends StatelessWidget {
  const ElevatedBtn({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.isDelete,
    this.child,
  });


  final String text;
  final double? width;
  final bool? isDelete;
  final Widget? child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 48.h,
     
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0.r),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(isDelete == null || isDelete == false
                  ? "assets/images/Button.png"
                  : "assets/images/deleteBtn.png"),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10.0.r),
          ),
          child: FractionallySizedBox(
            widthFactor: 1.0,
            heightFactor: 1.0,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                  color: cWhite2Color,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
