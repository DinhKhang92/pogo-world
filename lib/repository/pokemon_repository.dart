import 'package:pogo_world/extensions/pokemon_type.dart';
import 'package:pogo_world/models/pokemon.dart';
import 'package:pogo_world/provider/pokemon_provider.dart';
import 'package:pogo_world/utils/get_pokemon_type.dart';

import 'package:pogo_world/extensions/capitalize.dart';
import 'package:pogo_world/extensions/get_duplicates.dart';

class PokemonRepository {
  final PokemonProvider pokemonProvider;

  const PokemonRepository({required this.pokemonProvider});

  Future<List<Pokemon>> getReleasedPokemon() async {
    final Map<String, dynamic> releasedPokemonData = await pokemonProvider.fetchReleasedPokemon();
    final List pokemonTypesData = await pokemonProvider.fetchPokemonTypes();
    final List pokemonStatsData = await pokemonProvider.fetchPokemonStats();
    final Map pokemonTypeEffectivenessData = await pokemonProvider.fetchTypeEffectiveness();

    final List<Pokemon> releasedPokemon = releasedPokemonData.keys.map(
      (String id) {
        final Map parsedPokemonTypesData = _parsePokemonTypes(pokemonTypesData, id);
        final List<PokemonType> pokemonTypes = parsedPokemonTypesData[PokemonField.types];
        final String form = parsedPokemonTypesData[PokemonField.form];

        final Map<String, int> parsedPokemonStatsData = _parsePokemonStats(pokemonStatsData, id, form);

        final Map<String, List<PokemonType>> parsedPokemonWeaknesses = _parsePokemonWeaknesses(pokemonTypeEffectivenessData, pokemonTypes);
        final Map<String, List<PokemonType>> parsedPokemonResistances = _parsePokemonResistances(pokemonTypeEffectivenessData, pokemonTypes);
        final Map<String, List<PokemonType>> filteredEffectiveness = _filterEffectiveness(parsedPokemonWeaknesses, parsedPokemonResistances);

        return Pokemon.fromJSON({
          PokemonField.id: int.parse(id),
          PokemonField.name: releasedPokemonData[id][PokemonField.name],
          PokemonField.form: form,
          PokemonField.types: pokemonTypes,
          PokemonField.baseAttack: parsedPokemonStatsData[PokemonField.baseAttack],
          PokemonField.baseDefense: parsedPokemonStatsData[PokemonField.baseDefense],
          PokemonField.baseStamina: parsedPokemonStatsData[PokemonField.baseStamina],
          PokemonField.weaknesses: filteredEffectiveness[PokemonField.weaknesses],
          PokemonField.doubleWeaknesses: parsedPokemonWeaknesses[PokemonField.doubleWeaknesses],
          PokemonField.resistances: filteredEffectiveness[PokemonField.resistances],
          PokemonField.doubleResistances: filteredEffectiveness[PokemonField.doubleResistances],
          PokemonField.tripleResistances: parsedPokemonResistances[PokemonField.tripleResistances],
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
    final List<PokemonType> mappedPokemonTypes = types.map((dynamic type) => getPokemonType(type)).toList();
    return {
      PokemonField.types: mappedPokemonTypes,
      PokemonField.form: typeData["form"],
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
      PokemonField.baseAttack: statsData["base_attack"],
      PokemonField.baseDefense: statsData["base_defense"],
      PokemonField.baseStamina: statsData["base_stamina"],
    };
  }

  Map<String, List<PokemonType>> _parsePokemonWeaknesses(Map pokemonTypeEffectivenessData, List<PokemonType> pokemonTypes) {
    final List<PokemonType> weaknesses = [];
    final List<PokemonType> doubleWeaknesses = [];

    for (PokemonType type in pokemonTypes) {
      final Map weaknessEntries = {...pokemonTypeEffectivenessData}..removeWhere((key, value) => value[type.name.capitalize()] <= 1);
      List weaknessKeys = weaknessEntries.keys.toList();
      List<PokemonType> mappedWeaknesses = weaknessKeys.map((type) => getPokemonType(type)).toList();
      weaknesses.addAll(mappedWeaknesses);
    }

    doubleWeaknesses.addAll(weaknesses.getDuplicates());

    for (PokemonType doubleWeakness in doubleWeaknesses) {
      weaknesses.removeWhere((weakness) => weakness == doubleWeakness);
    }

    return {
      PokemonField.weaknesses: weaknesses,
      PokemonField.doubleWeaknesses: doubleWeaknesses,
    };
  }

  Map<String, List<PokemonType>> _parsePokemonResistances(Map pokemonTypeEffectivenessData, List<PokemonType> pokemonTypes) {
    final List<PokemonType> resistances = [];
    final List<PokemonType> doubleResistances = [];
    final List<PokemonType> tripleResistances = [];

    for (PokemonType type in pokemonTypes) {
      final Map doubleResistanceEntries = {...pokemonTypeEffectivenessData}..removeWhere((key, value) => value[type.name.capitalize()] >= 0.4);
      final Map resistanceEntries = {...pokemonTypeEffectivenessData}..removeWhere((key, value) => value[type.name.capitalize()] <= 0.4 || value[type.name.capitalize()] >= 1);
      final List doubleResistanceKeys = doubleResistanceEntries.keys.toList();
      final List resistanceKeys = resistanceEntries.keys.toList();

      final List<PokemonType> mappedDoubleResistances = doubleResistanceKeys.map((type) => getPokemonType(type)).toList();
      final List<PokemonType> mappedResistances = resistanceKeys.map((type) => getPokemonType(type)).toList();
      resistances.addAll(mappedResistances);
      doubleResistances.addAll(mappedDoubleResistances);
    }

    doubleResistances.addAll(resistances.getDuplicates());

    for (PokemonType doubleResistance in doubleResistances) {
      resistances.removeWhere((PokemonType resistance) => resistance == doubleResistance);
    }

    return {
      PokemonField.resistances: resistances,
      PokemonField.doubleResistances: doubleResistances,
      PokemonField.tripleResistances: tripleResistances,
    };
  }

  Map<String, List<PokemonType>> _filterEffectiveness(Map parsedPokemonWeaknesses, Map parsedPokemonResistances) {
    List<PokemonType> weaknesses = [...parsedPokemonWeaknesses[PokemonField.weaknesses]];
    List<PokemonType> doubleResistances = [...parsedPokemonResistances[PokemonField.doubleResistances]];
    List<PokemonType> resistances = [...parsedPokemonResistances[PokemonField.resistances]];

    List<PokemonType> addResistanceFields = [];
    List<PokemonType> deleteWeaknessFields = [];
    List<PokemonType> deleteDoubleResistanceFields = [];

    for (PokemonType weakness in weaknesses) {
      resistances.removeWhere((PokemonType resistance) {
        if (resistance == weakness) {
          deleteWeaknessFields.add(weakness);
          return true;
        }
        return false;
      });

      doubleResistances.removeWhere((PokemonType doubleResistance) {
        if (weaknesses.contains(doubleResistance)) {
          deleteWeaknessFields.add(doubleResistance);
          deleteDoubleResistanceFields.add(doubleResistance);
          addResistanceFields.add(doubleResistance);
          return true;
        }
        return false;
      });
    }
    resistances.addAll(addResistanceFields);
    weaknesses.removeAll(deleteWeaknessFields);
    doubleResistances.removeAll(deleteDoubleResistanceFields);

    return {
      PokemonField.weaknesses: weaknesses,
      PokemonField.resistances: resistances,
      PokemonField.doubleResistances: doubleResistances,
    };
  }
}
