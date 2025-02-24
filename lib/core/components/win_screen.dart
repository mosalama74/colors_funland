import 'dart:math';
import 'package:color_funland/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WinScreen extends StatefulWidget {
  const WinScreen({Key? key}) : super(key: key);

  @override
  _WinScreenState createState() => _WinScreenState();
}

class _WinScreenState extends State<WinScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Confetti> confetti;
  final Random random = Random();
  late Size screenSize;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // We'll set the screen size in build
    screenSize = Size.zero;
    confetti = [];

    // Start the animation loop
    _startAnimation();
  }

  void _initializeConfetti() {
    if (screenSize == Size.zero) return;

    // Create confetti with different starting positions
    confetti = [
      // Top confetti
      ...List.generate(100, (index) => Confetti.fromTop(random, screenSize)),
      // Bottom confetti
      ...List.generate(100, (index) => Confetti.fromBottom(random, screenSize)),
      // Left confetti
      ...List.generate(100, (index) => Confetti.fromLeft(random, screenSize)),
      // Right confetti
      ...List.generate(100, (index) => Confetti.fromRight(random, screenSize)),
      // Corner confetti
      ...List.generate(100, (index) => Confetti.fromTopLeft(random, screenSize)),
      ...List.generate(100, (index) => Confetti.fromTopRight(random, screenSize)),
      ...List.generate(100, (index) => Confetti.fromBottomLeft(random, screenSize)),
      ...List.generate(100, (index) => Confetti.fromBottomRight(random, screenSize)),
    ];
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 5), () {
      if (mounted) {
        setState(() {
          for (var particle in confetti) {
            particle.update(screenSize);
          }
        });
        _startAnimation();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    screenSize = MediaQuery.of(context).size;
    
    // Initialize confetti if not already done
    if (confetti.isEmpty) {
      _initializeConfetti();
    }

    return Material(
      color: Color(0xff2C005E).withOpacity(.20),
      child: Stack(
        children: [
          // Confetti particles
          ...confetti.map((particle) {
            return Positioned(
              left: particle.x,
              top: particle.y,
              child: Transform.rotate(
                angle: particle.angle,
                child: ConfettiPiece(
                  size: particle.size,
                  color: particle.color,
                ),
              ),
            );
          }).toList(),

          // Win message
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
                        'Awesome',
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
                          width: 222,
                          height: 86,
                          child: Image.asset(AppImages.nextbutton,fit:BoxFit.cover),
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

class Confetti {
  double x;
  double y;
  double velocityX;
  double velocityY;
  double angle;
  double angularVelocity;
  double size;
  Color color;
  final Random random;

  Confetti(this.random)
      : x = 0,
        y = 0,
        velocityX = 0,
        velocityY = 0,
        angle = 0,
        angularVelocity = 0,
        size = 0,
        color = Colors.white {
    _initialize();
  }

  // Factory constructors for different starting positions
  factory Confetti.fromTop(Random random, Size screenSize) {
    return Confetti(random)
      .._setPosition(
        x: random.nextDouble() * screenSize.width,
        y: -20,
        velocityX: (random.nextDouble() - 0.5) * 8,
        velocityY: random.nextDouble() * 4 + 2,
      );
  }

  factory Confetti.fromBottom(Random random, Size screenSize) {
    return Confetti(random)
      .._setPosition(
        x: random.nextDouble() * screenSize.width,
        y: screenSize.height + 20,
        velocityX: (random.nextDouble() - 0.5) * 8,
        velocityY: -(random.nextDouble() * 4 + 2),
      );
  }

  factory Confetti.fromLeft(Random random, Size screenSize) {
    return Confetti(random)
      .._setPosition(
        x: -20,
        y: random.nextDouble() * screenSize.height,
        velocityX: random.nextDouble() * 4 + 2,
        velocityY: (random.nextDouble() - 0.5) * 8,
      );
  }

  factory Confetti.fromRight(Random random, Size screenSize) {
    return Confetti(random)
      .._setPosition(
        x: screenSize.width + 20,
        y: random.nextDouble() * screenSize.height,
        velocityX: -(random.nextDouble() * 4 + 2),
        velocityY: (random.nextDouble() - 0.5) * 8,
      );
  }

  factory Confetti.fromTopLeft(Random random, Size screenSize) {
    return Confetti(random)
      .._setPosition(
        x: -20,
        y: -20,
        velocityX: random.nextDouble() * 4 + 2,
        velocityY: random.nextDouble() * 4 + 2,
      );
  }

  factory Confetti.fromTopRight(Random random, Size screenSize) {
    return Confetti(random)
      .._setPosition(
        x: screenSize.width + 20,
        y: -20,
        velocityX: -(random.nextDouble() * 4 + 2),
        velocityY: random.nextDouble() * 4 + 2,
      );
  }

  factory Confetti.fromBottomLeft(Random random, Size screenSize) {
    return Confetti(random)
      .._setPosition(
        x: -20,
        y: screenSize.height + 20,
        velocityX: random.nextDouble() * 4 + 2,
        velocityY: -(random.nextDouble() * 4 + 2),
      );
  }

  factory Confetti.fromBottomRight(Random random, Size screenSize) {
    return Confetti(random)
      .._setPosition(
        x: screenSize.width + 20,
        y: screenSize.height + 20,
        velocityX: -(random.nextDouble() * 4 + 2),
        velocityY: -(random.nextDouble() * 4 + 2),
      );
  }

  void _initialize() {
    angle = random.nextDouble() * pi * 2;
    angularVelocity = (random.nextDouble() - 0.5) * 0.3;
    size = random.nextDouble() * 12 + 5;
    color = Colors.primaries[random.nextInt(Colors.primaries.length)];
  }

  void _setPosition({
    required double x,
    required double y,
    required double velocityX,
    required double velocityY,
  }) {
    this.x = x;
    this.y = y;
    this.velocityX = velocityX;
    this.velocityY = velocityY;
  }

  void update(Size screenSize) {
    x += velocityX;
    y += velocityY;
    angle += angularVelocity;

    // Reset if particle goes off screen
    if (x < -50 || x > screenSize.width + 50 ||
        y < -50 || y > screenSize.height + 50) {
      // Randomly choose a new starting position
      final position = random.nextInt(8);
      switch (position) {
        case 0:
          _setPosition(
            x: random.nextDouble() * screenSize.width,
            y: -20,
            velocityX: (random.nextDouble() - 0.5) * 8,
            velocityY: random.nextDouble() * 4 + 2,
          );
          break;
        case 1:
          _setPosition(
            x: random.nextDouble() * screenSize.width,
            y: screenSize.height + 20,
            velocityX: (random.nextDouble() - 0.5) * 8,
            velocityY: -(random.nextDouble() * 4 + 2),
          );
          break;
        case 2:
          _setPosition(
            x: -20,
            y: random.nextDouble() * screenSize.height,
            velocityX: random.nextDouble() * 4 + 2,
            velocityY: (random.nextDouble() - 0.5) * 8,
          );
          break;
        case 3:
          _setPosition(
            x: screenSize.width + 20,
            y: random.nextDouble() * screenSize.height,
            velocityX: -(random.nextDouble() * 4 + 2),
            velocityY: (random.nextDouble() - 0.5) * 8,
          );
          break;
        case 4:
          _setPosition(
            x: -20,
            y: -20,
            velocityX: random.nextDouble() * 4 + 2,
            velocityY: random.nextDouble() * 4 + 2,
          );
          break;
        case 5:
          _setPosition(
            x: screenSize.width + 20,
            y: -20,
            velocityX: -(random.nextDouble() * 4 + 2),
            velocityY: random.nextDouble() * 4 + 2,
          );
          break;
        case 6:
          _setPosition(
            x: -20,
            y: screenSize.height + 20,
            velocityX: random.nextDouble() * 4 + 2,
            velocityY: -(random.nextDouble() * 4 + 2),
          );
          break;
        case 7:
          _setPosition(
            x: screenSize.width + 20,
            y: screenSize.height + 20,
            velocityX: -(random.nextDouble() * 4 + 2),
            velocityY: -(random.nextDouble() * 4 + 2),
          );
          break;
      }
    }
  }
}

class ConfettiPiece extends StatelessWidget {
  final double size;
  final Color color;

  const ConfettiPiece({
    Key? key,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size * 0.6,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

// Function to show the win screen
void showWinScreen(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const WinScreen(),
  );
}