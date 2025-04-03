// import 'package:color_funland/core/components/animated_container_widget.dart';
// import 'package:color_funland/core/components/app_bar_row.dart';
// import 'package:color_funland/core/components/three_items_bottom_navigation.dart';
// import 'package:color_funland/core/constants/app_icons.dart';
// import 'package:color_funland/core/constants/model.dart';
// import 'package:color_funland/features/my_painting/widgets/sample_screen_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';


// class FishesSamplesScreen extends StatefulWidget {
//   const FishesSamplesScreen({super.key});

//   @override
//   State<FishesSamplesScreen> createState() => _FishesSamplesScreenState();
// }

// class _FishesSamplesScreenState extends State<FishesSamplesScreen> {
//     final GlobalKey<AnimatedContainerState> _containerKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: SystemUiOverlayStyle.light.copyWith(
//         statusBarColor: Colors.white,
//         statusBarIconBrightness: Brightness.dark,
//       ),
//       child: Scaffold(
//         extendBodyBehindAppBar: true,
//         appBar: AppBarRow(
//           gameGroup: "Paintings",
//           inSideGame: true,
//           appBarIcon: AppIcons.paintingsIcon,
//           containerKey: _containerKey,
//         ),
//         body: SafeArea(
//           child: Stack(
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(left: 46.w, right: 52.w),
//                 child: SampleScreenWidget(
//                   title:'Fishes',
//                   gridHeight: MediaQuery.of(context).size.height * .56,
//                   items: fishesFram,
//                   crossAxisCount: 5,
//                   pageGroup:fishesPaintingScreen,
//                   insidecategory: false,
//                   insideanimals: true,
//                   childAspectRatio: 1 / .90,
//                 ),
//               ),
//               AnimatedContainerWidget(key: _containerKey),
//             ],
//           ),
//         ),
//         bottomNavigationBar: ThreeItemsBottomNavigation(
//           insideGame: true,
//           onBackPressed: () => Navigator.pop(context),
//         ),
//       ),
//     );
//   }
// }