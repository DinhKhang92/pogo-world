import 'package:flutter/material.dart';
import 'package:pogo_world/config/colors.dart';
import 'package:pogo_world/extensions/generation.dart';

Color getColorByIndex(int index) {
  if (index > Generation.galar.start - 1) {
    return kcTypeRockColor;
  } else if (index > Generation.kalos.start - 1) {
    return kcTypePsychicColor;
  } else if (index > Generation.unova.start - 1) {
    return kcTypeSteelColor;
  } else if (index > Generation.sinnoh.start - 1) {
    return kcTypeElectricColor;
  } else if (index > Generation.hoenn.start - 1) {
    return kcTypeGrassColor;
  } else if (index > Generation.johto.start - 1) {
    return kcTypeWaterColor;
  } else {
    return kcTypeFireColor;
  }
}
