import 'package:pogo_world/extensions/pokemon_type.dart';
import 'package:pogo_world/models/pokemon.dart';
import 'package:pogo_world/provider/pokemon_provider.dart';
import 'package:pogo_world/utils/get_pokemon_type.dart';

class PokemonRepository {
  final PokemonProvider pokemonProvider;

  const PokemonRepository({required this.pokemonProvider});

  Future<List<Pokemon>> getReleasedPokemon() async {
    final Map<String, dynamic> releasedPokemonData = await pokemonProvider.fetchReleasedPokemon();
    final List pokemonTypesData = await pokemonProvider.fetchPokemonTypes();

    final List<Pokemon> releasedPokemon = releasedPokemonData.keys.map(
      (String id) {
        final Map<String, dynamic> typeData = pokemonTypesData.lastWhere((pokemonTypesJson) {
          if (pokemonTypesJson["pokemon_id"] == int.parse(id)) {
            return true;
          }

          return false;
        });

        if (typeData.isEmpty) {
          throw Error();
        }

        final List types = typeData["type"];
        final List<PokemonType> pokemonTypes = types.map((dynamic type) => getPokemonType(type)).toList();

        return Pokemon.fromJSON({
          "id": int.parse(id),
          "name": releasedPokemonData[id]["name"],
          "form": typeData["form"],
          "types": pokemonTypes,
        });
      },
    ).toList();

    return releasedPokemon;
  }

  List<Pokemon> searchPokemon(List<Pokemon> releasedPokemon, String substring) {
    if (substring.isEmpty) {
      return [];
    }

    return releasedPokemon.where((Pokemon pokemon) => pokemon.name.toLowerCase().contains(substring.toLowerCase())).toList();
  }
}
