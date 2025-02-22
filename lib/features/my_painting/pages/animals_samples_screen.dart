
import 'package:color_funland/features/my_painting/model.dart';
import 'package:color_funland/features/my_painting/widgets/shared_samples_screen.dart';
import 'package:flutter/material.dart';


class AnimalsSamplesScreen extends StatefulWidget {
  const AnimalsSamplesScreen({super.key});

  @override
  State<AnimalsSamplesScreen> createState() => _AnimalsSamplesScreenState();
}

class _AnimalsSamplesScreenState extends State<AnimalsSamplesScreen> {

 @override
  Widget build(BuildContext context) {
    return SharedSamplesScreen( frames: animalsFram,paintingImages:animalsPaintingScreen ,title: 'Animals',);
  }
}