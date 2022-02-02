import 'package:pogo_world/extensions/pokemon_type.dart';

PokemonType getPokemonType(String type) {
  switch (type) {
    case "Bug":
      return PokemonType.bug;
    case "Dark":
      return PokemonType.dark;
    case "Dragon":
      return PokemonType.dragon;
    case "Electric":
      return PokemonType.electric;
    case "Fairy":
      return PokemonType.fairy;
    case "Fighting":
      return PokemonType.fighting;
    case "Fire":
      return PokemonType.fire;
    case "Flying":
      return PokemonType.flying;
    case "Ghost":
      return PokemonType.ghost;
    case "Grass":
      return PokemonType.grass;
    case "Ground":
      return PokemonType.ground;
    case "Ice":
      return PokemonType.ice;
    case "Normal":
      return PokemonType.normal;
    case "Poison":
      return PokemonType.poison;
    case "Psychic":
      return PokemonType.psychic;
    case "Rock":
      return PokemonType.rock;
    case "Steel":
      return PokemonType.steel;
    case "Water":
      return PokemonType.water;
    default:
      return PokemonType.normal;
  }
}
