import 'package:flutter/material.dart';
import 'package:pogo_world/models/pokemon_page_args.dart';
import 'package:pogo_world/pages/landing_page.dart';
import 'package:pogo_world/pages/pokedex_page.dart';
import 'package:pogo_world/pages/pokemon_page.dart';

class Routes {
  static const String landingPage = '/';
  static const String pokedexPage = '/pokedex';
  static const String pokemonPage = '/pokemon';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.landingPage:
        return MaterialPageRoute(builder: (_) => const LandingPage());
      case Routes.pokedexPage:
        return MaterialPageRoute(builder: (_) => const PokedexPage());
      case Routes.pokemonPage:
        final PokemonPageArgs args = settings.arguments as PokemonPageArgs;
        return MaterialPageRoute(builder: (_) => PokemonPage(pokemon: args.pokemon));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) => const LandingPage());
  }
}
