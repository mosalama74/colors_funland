
import 'package:color_funland/features/my_painting/model.dart';
import 'package:color_funland/features/my_painting/widgets/shared_samples_screen.dart';
import 'package:flutter/material.dart';


class AnimalsSamplesScreen extends StatelessWidget {
  const AnimalsSamplesScreen({super.key});

 @override
  Widget build(BuildContext context) {
    return SharedSamplesScreen( frames: animalsFram,paintingImages:animalsPaintingScreen ,title: 'Animals',);
  }
}