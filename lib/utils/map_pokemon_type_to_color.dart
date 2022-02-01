import 'package:flutter/material.dart';
import 'package:pogo_world/config/colors.dart';
import 'package:pogo_world/extensions/pokemon_type.dart';

Color mapPokemonTypeToColor(PokemonType type) {
  switch (type) {
    case PokemonType.bug:
      return kcTypeBugColor;
    case PokemonType.dark:
      return kcTypeDarkColor;
    case PokemonType.electric:
      return kcTypeElectricColor;
    case PokemonType.fairy:
      return kcTypeFairyColor;
    case PokemonType.fighting:
      return kcTypeFightingColor;
    case PokemonType.fire:
      return kcTypeFireColor;
    case PokemonType.flying:
      return kcTypeFlyingColor;
    case PokemonType.ghost:
      return kcTypeGhostColor;
    case PokemonType.grass:
      return kcTypeGrassColor;
    case PokemonType.ground:
      return kcTypeGroundColor;
    case PokemonType.ice:
      return kcTypeIceColor;
    case PokemonType.normal:
      return kcTypeNormalColor;
    case PokemonType.poison:
      return kcTypePoisonColor;
    case PokemonType.psychic:
      return kcTypePsychicColor;
    case PokemonType.rock:
      return kcTypeRockColor;
    case PokemonType.steel:
      return kcTypeSteelColor;
    case PokemonType.water:
      return kcTypeWaterColor;
    default:
      return kcTypeNormalColor;
  }
}
