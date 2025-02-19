import 'package:color_funland/core/components/app_bar_row.dart';
import 'package:color_funland/features/game_board/presentation/widgets/two_items_bottom_navigation.dart';
import 'package:flutter/material.dart';

class ChildProgressScreen extends StatelessWidget {
  const ChildProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRow(
        gameGroup: "Progress",
        inSideGame: true,
      ),
      body: Center(child: Text("dddddddddddddddddd"),),
      bottomNavigationBar: TwoItemsBottomNavigation(insideGame: true),
    );
  }
}
