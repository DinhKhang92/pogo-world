import 'package:flutter/material.dart';
import 'package:pogo_world/config/spacing.dart';
import 'package:pogo_world/config/theme.dart';
import 'package:pogo_world/extensions/capitalize.dart';
import 'package:pogo_world/extensions/generation.dart';

class GenerationNavigationItem extends StatefulWidget {
  final Generation generation;
  final Function navigateToGeneration;
  final String filterImageUrl;
  const GenerationNavigationItem({required this.generation, required this.navigateToGeneration, required this.filterImageUrl, Key? key}) : super(key: key);

  @override
  _GenerationNavigationItemState createState() => _GenerationNavigationItemState();
}

class _GenerationNavigationItemState extends State<GenerationNavigationItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.navigateToGeneration(widget.generation),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.xxs),
        decoration: BoxDecoration(
          border: Border.all(color: widget.generation.color),
          borderRadius: BorderRadius.circular(kbGridTileBorderRadius),
        ),
        child: Wrap(
          spacing: Spacing.xs,
          children: [
            Image.asset(
              widget.filterImageUrl,
              height: 16,
              color: widget.generation.color,
            ),
            Text(widget.generation.name.capitalize(), style: TextStyle(color: widget.generation.color)),
          ],
        ),
      ),
    );
  }
}
