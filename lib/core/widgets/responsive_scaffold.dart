import 'package:flutter/material.dart';
import 'package:color_funland/core/utils/screen_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponsiveScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final bool resizeToAvoidBottomInset;
  final EdgeInsets? padding;
  final bool centerContent;
  final bool scrollable;

  const ResponsiveScaffold({
    Key? key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.resizeToAvoidBottomInset = true,
    this.padding,
    this.centerContent = true,
    this.scrollable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(
      padding: padding ?? ScreenUtils.getScreenPadding(context),
      child: body,
    );

    if (scrollable) {
      content = SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: content,
      );
    }

    if (centerContent) {
      content = Center(child: content);
    }

    if (ScreenUtils.isTablet(context)) {
      content = Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ScreenUtils.tabletDesignSize.width.w,
          ),
          child: content,
        ),
      );
    }

    return Scaffold(
      appBar: appBar,
      body: SafeArea(child: content),
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: backgroundColor,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}
