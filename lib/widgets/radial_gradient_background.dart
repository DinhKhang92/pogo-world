import 'package:flutter/material.dart';

class RadialGradientBackground extends StatelessWidget {
  final Alignment center;
  final Color innerColor;
  final Color outerColor;

  const RadialGradientBackground({required this.innerColor, required this.outerColor, this.center = Alignment.center, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: center,
          colors: [innerColor, outerColor],
          radius: 0.6,
        ),
      ),
    );
  }
}
