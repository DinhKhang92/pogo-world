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
    final List pokemonStatsData = await pokemonProvider.fetchPokemonStats();

    final List<Pokemon> releasedPokemon = releasedPokemonData.keys.map(
      (String id) {
        final Map parsedPokemonTypesData = _parsePokemonTypes(pokemonTypesData, id);
        final List<PokemonType> pokemonTypes = parsedPokemonTypesData["types"];
        final String form = parsedPokemonTypesData["form"];

        final Map<String, int> parsedPokemonStatsData = _parsePokemonStats(pokemonStatsData, id, form);

        return Pokemon.fromJSON({
          "id": int.parse(id),
          "name": releasedPokemonData[id]["name"],
          "form": form,
          "types": pokemonTypes,
          "base_attack": parsedPokemonStatsData["base_attack"],
          "base_defense": parsedPokemonStatsData["base_defense"],
          "base_stamina": parsedPokemonStatsData["base_stamina"],
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

  Map _parsePokemonTypes(List pokemonTypesData, String id) {
    final Map<String, dynamic> typeData = pokemonTypesData.lastWhere((pokemonTypesJson) {
      return pokemonTypesJson["pokemon_id"] == int.parse(id) ? true : false;
    });

    if (typeData.isEmpty) {
      throw Error();
    }

    final List types = typeData["type"];
    return {
      "types": types.map((dynamic type) => getPokemonType(type)).toList(),
      "form": typeData["form"],
    };
  }

  Map<String, int> _parsePokemonStats(List pokemonStatsData, String id, String form) {
    final Map<String, dynamic> statsData = pokemonStatsData.lastWhere((pokemonStatsJson) {
      return pokemonStatsJson["pokemon_id"] == int.parse(id) && pokemonStatsJson["form"] == form ? true : false;
    });

    if (statsData.isEmpty) {
      throw Error();
    }

    return {
      "base_attack": statsData["base_attack"],
      "base_defense": statsData["base_defense"],
      "base_stamina": statsData["base_stamina"],
    };
  }
}
