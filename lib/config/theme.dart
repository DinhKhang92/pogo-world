import 'package:flutter/material.dart';
import 'package:pogo_world/config/colors.dart';
import 'package:pogo_world/config/spacing.dart';

const double kbCardBorderRadius = 15.0;
const double kbGridTileBorderRadius = 10.0;

const TextSelectionThemeData ktTextSelectionTheme = TextSelectionThemeData(
  cursorColor: kcWhiteColor,
  selectionHandleColor: kcWhiteColor,
);

InputDecorationTheme ktInputDecorationTheme = const InputDecorationTheme(
  isDense: true,
  hintStyle: TextStyle(fontSize: 14),
  contentPadding: EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.s),
  border: InputBorder.none,
);
