import 'package:pogo_world/models/pokemon.dart';

int getMaxBaseAttack(List<Pokemon> pokemon) {
  Pokemon pokemonMaxAttack = pokemon.reduce((pokemon1, pokemon2) => pokemon1.baseAttack > pokemon2.baseAttack ? pokemon1 : pokemon2);
  return pokemonMaxAttack.baseAttack;
}

int getMaxBaseDefense(List<Pokemon> pokemon) {
  Pokemon pokemonMaxDefense = pokemon.reduce((pokemon1, pokemon2) => pokemon1.baseDefense > pokemon2.baseDefense ? pokemon1 : pokemon2);
  return pokemonMaxDefense.baseDefense;
}

int getMaxBaseStamina(List<Pokemon> pokemon) {
  Pokemon pokemonMaxStamina = pokemon.reduce((pokemon1, pokemon2) => pokemon1.baseStamina > pokemon2.baseStamina ? pokemon1 : pokemon2);
  return pokemonMaxStamina.baseStamina;
}
