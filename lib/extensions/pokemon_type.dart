enum PokemonType {
  bug,
  dark,
  dragon,
  electric,
  fairy,
  fighting,
  fire,
  flying,
  ghost,
  grass,
  ground,
  ice,
  normal,
  poison,
  psychic,
  rock,
  steel,
  water,
}

extension PokemonTypeExtension on PokemonType {
  String get label {
    switch (this) {
      case PokemonType.bug:
        return "Bug";
      case PokemonType.dark:
        return "Dark";
      case PokemonType.dragon:
        return "Dragon";
      case PokemonType.electric:
        return "Electric";
      case PokemonType.fairy:
        return "Fairy";
      case PokemonType.fighting:
        return "Fighting";
      case PokemonType.fire:
        return "Fire";
      case PokemonType.flying:
        return "Flying";
      case PokemonType.ghost:
        return "Ghost";
      case PokemonType.grass:
        return "Grass";
      case PokemonType.ground:
        return "Ground";
      case PokemonType.ice:
        return "Ice";
      case PokemonType.normal:
        return "Normal";
      case PokemonType.poison:
        return "Poison";
      case PokemonType.psychic:
        return "Psychic";
      case PokemonType.rock:
        return "Rock";
      case PokemonType.steel:
        return "Steel";
      case PokemonType.water:
        return "Water";
    }
  }
}
