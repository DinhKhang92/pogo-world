import 'package:flutter/material.dart';
import 'package:pogo_world/config/colors.dart';

enum Generation {
  kanto,
  johto,
  hoenn,
  sinnoh,
  unova,
  kalos,
  galar,
}

extension GenerationExtension on Generation {
  int get start {
    switch (this) {
      case Generation.kanto:
        return 1;
      case Generation.johto:
        return 152;
      case Generation.hoenn:
        return 252;
      case Generation.sinnoh:
        return 387;
      case Generation.unova:
        return 494;
      case Generation.kalos:
        return 650;
      case Generation.galar:
        return 722;
    }
  }

  String get image {
    switch (this) {
      case Generation.kanto:
        return 'ic_pokedex';
      case Generation.johto:
        return 'ic_johto';
      case Generation.hoenn:
        return 'ic_hoenn';
      case Generation.sinnoh:
        return 'ic_sinnoh';
      case Generation.unova:
        return 'ic_unova';
      case Generation.kalos:
        return 'ic_kalos';
      case Generation.galar:
        return 'ic_galar';
    }
  }

  Color get color {
    switch (this) {
      case Generation.kanto:
        return kcTypeFireColor;
      case Generation.johto:
        return kcTypeWaterColor;
      case Generation.hoenn:
        return kcTypeGrassColor;
      case Generation.sinnoh:
        return kcTypeElectricColor;
      case Generation.unova:
        return kcTypeSteelColor;
      case Generation.kalos:
        return kcTypePsychicColor;
      case Generation.galar:
        return kcTypeRockColor;
    }
  }
}
