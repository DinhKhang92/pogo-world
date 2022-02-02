import 'package:pogo_world/extensions/generation.dart';
import 'package:pogo_world/models/pokemon.dart';

int getUnreleasedPokemonCountToGivenGeneration(List<Pokemon> releasedPokemon, Generation generation) {
  final List<Pokemon> releasedPokemonForGivenGeneration = releasedPokemon.where((Pokemon pokemon) => pokemon.id <= generation.start).toList();
  final int unreleasedPokemonCountForGivenGeneration = (releasedPokemonForGivenGeneration.length - generation.start).abs();

  return unreleasedPokemonCountForGivenGeneration;
}
