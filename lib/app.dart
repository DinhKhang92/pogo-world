import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pogo_world/config/colors.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pogo_world/cubit/pokedex_cubit.dart';
import 'package:pogo_world/provider/pokemon_provider.dart';
import 'package:pogo_world/repository/pokemon_repository.dart';
import 'package:pogo_world/routes/route_generator.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final PokemonProvider _pokemonProvider = PokemonProvider();

  late final PokemonRepository _pokemonRepository = PokemonRepository(pokemonProvider: _pokemonProvider);

  late final PokedexCubit _pokedexCubit = PokedexCubit(pokemonRepository: _pokemonRepository);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PokedexCubit>(create: (_) => _pokedexCubit),
      ],
      child: MaterialApp(
        title: 'PoGo World',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: kcBackgroundColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: kcTransparentColor,
            elevation: 0.0,
          ),
        ),
        initialRoute: Routes.landingPage,
        onGenerateRoute: RouteGenerator.generateRoute,
        supportedLocales: const [
          Locale('en', ''),
        ],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}
