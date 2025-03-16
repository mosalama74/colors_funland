import 'package:color_funland/core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FailureScreen extends StatefulWidget {
  const FailureScreen({super.key});

  @override
  _WinScreenState createState() => _WinScreenState();
}

class _WinScreenState extends State<FailureScreen> with SingleTickerProviderStateMixin {


  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xff2C005E).withOpacity(.20),
      child: Stack(
        children: [
          Padding(
            padding:  EdgeInsets.only(top: 250.h),
            child: Center(
              child: Container(
                height: 210.h,
                width: 800.w,
                decoration: BoxDecoration(
                    color: Color(0xff9C008D).withOpacity(.9),
                    borderRadius: BorderRadius.all(Radius.circular(82.r)),
                    boxShadow: [
                      BoxShadow(
                          blurStyle: BlurStyle.inner
                      )
                    ]
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 135.h),
                  child: Row(
                    children: [
                      const Text(
                        'OOPs',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 10,
                              color: Colors.black38,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 64),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          width: 315.86,
                          height: 86,
                          child: Image.asset(AppIcons.tryAgainButton,fit:BoxFit.cover),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



// Function to show the win screen
void showFailureScreen(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const FailureScreen(),
  );
}