import 'package:pogo_world/provider/pokemon_provider.dart';

class PokemonRepository {
  final PokemonProvider pokemonProvider;

  const PokemonRepository({required this.pokemonProvider});

  Future<Map> getReleasedPokemon() async => await pokemonProvider.fetchReleasedPokemon();

  Map searchPokemon(Map pokemon, String substring) {
    if (substring.isEmpty) {
      return {};
    }

    pokemon.removeWhere((key, value) {
      final String pokemonName = value["name"];
      return pokemonName.toLowerCase().contains(substring.toLowerCase()) ? false : true;
    });

    return pokemon;
  }
}
