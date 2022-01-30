import 'package:pogo_world/extensions/generation.dart';

int getUnreleasedPokemonCountToGivenGeneration(Map pokemon, Generation generation) {
  final Map pokemonCopy = {...pokemon};
  pokemonCopy.removeWhere((key, value) => int.parse(key) > generation.start ? true : false);
  return (pokemonCopy.length - generation.start).abs();
}
