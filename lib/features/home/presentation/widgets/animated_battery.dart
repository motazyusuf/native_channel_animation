import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimatedBattery extends StatelessWidget {
  const AnimatedBattery({super.key, required this.sizeTween});

  final Animation<double> sizeTween;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: sizeTween,
      child: SizedBox(
        height: 400,
        child: LottieBuilder.asset("assets/batteryAnimation.json"),
      ),
    );
  }
}
