import 'dart:convert';

import 'package:flutter/services.dart';

class PokemonProvider {
  Future<Map<String, dynamic>> fetchReleasedPokemon() async {
    final String response = await rootBundle.loadString('assets/mocks/released_pokemon.json');
    final Map<String, dynamic> data = await json.decode(response);
    return data;
  }

  Future<List> fetchPokemonTypes() async {
    final String response = await rootBundle.loadString('assets/mocks/pokemon_types.json');
    final List data = await json.decode(response);
    return data;
  }

  Future<List> fetchPokemonStats() async {
    final String response = await rootBundle.loadString('assets/mocks/pokemon_stats.json');
    final List data = await json.decode(response);
    return data;
  }
}
