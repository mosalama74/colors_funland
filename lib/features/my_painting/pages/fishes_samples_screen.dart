

import 'package:color_funland/features/my_painting/model.dart';
import 'package:color_funland/features/my_painting/widgets/shared_samples_screen.dart';
import 'package:flutter/material.dart';


class FishesSamplesScreen extends StatefulWidget {
  const FishesSamplesScreen({super.key});

  @override
  State<FishesSamplesScreen> createState() => _FishesSamplesScreenState();
}

class _FishesSamplesScreenState extends State<FishesSamplesScreen> {

 @override
  Widget build(BuildContext context) {
        return SharedSamplesScreen( frames: fishesFram,paintingImages:fishesPaintingScreen ,title: 'Fishes',);

  }
}