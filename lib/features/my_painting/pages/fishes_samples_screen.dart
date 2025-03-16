

import 'package:color_funland/features/my_painting/model.dart';
import 'package:color_funland/features/my_painting/widgets/shared_samples_screen.dart';
import 'package:flutter/material.dart';


class FishesSamplesScreen extends StatelessWidget {
  const FishesSamplesScreen({super.key});

 @override
  Widget build(BuildContext context) {
        return SharedSamplesScreen( frames: fishesFram,paintingImages:fishesPaintingScreen ,title: 'Fishes',);

  }
}