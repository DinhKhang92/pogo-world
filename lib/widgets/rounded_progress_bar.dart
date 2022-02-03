import 'package:flutter/material.dart';
import 'package:pogo_world/config/colors.dart';
import 'package:pogo_world/config/theme.dart';

class RoundedProgressBar extends StatelessWidget {
  final double percent;
  final Color color;
  final Color backgroundColor;
  final double height;
  final double borderRadius;

  const RoundedProgressBar({
    required this.percent,
    required this.color,
    this.backgroundColor = kcProgressBarBackgroundColor,
    this.borderRadius = kbPokemonInfoBorderRadius,
    this.height = 12,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, boxConstraints) {
        return Stack(
          children: [
            Container(
              width: boxConstraints.maxWidth,
              height: height,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
            Container(
              width: percent * boxConstraints.maxWidth,
              height: height,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
          ],
        );
      },
    );
  }
}
