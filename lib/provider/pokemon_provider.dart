import 'dart:convert';

import 'package:flutter/services.dart';

class PokemonProvider {
  Future<Map> fetchReleasedPokemon() async {
    final String response = await rootBundle.loadString('assets/mocks/released_pokemon.json');
    final dynamic data = await json.decode(response);
    return data as Map;
  }
}
