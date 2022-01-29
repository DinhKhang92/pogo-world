import 'package:pogo_world/provider/pokemon_provider.dart';

class PokemonRepository {
  final PokemonProvider pokemonProvider;

  const PokemonRepository({required this.pokemonProvider});

  Future<Map> getReleasedPokemon() async => pokemonProvider.fetchReleasedPokemon();
}
