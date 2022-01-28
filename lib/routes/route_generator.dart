import 'package:flutter/material.dart';
import 'package:pogo_world/pages/landing_page.dart';
import 'package:pogo_world/pages/pokedex_page.dart';

class Routes {
  static const String landingPage = '/';
  static const String pokedexPage = '/pokedex';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.landingPage:
        return MaterialPageRoute(builder: (_) => const LandingPage());
      case Routes.pokedexPage:
        return MaterialPageRoute(builder: (_) => const PokededxPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) => const LandingPage());
  }
}
