import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pogo_world/config/colors.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pogo_world/config/theme.dart';
import 'package:pogo_world/cubit/move_cubit.dart';
import 'package:pogo_world/cubit/pokedex_cubit.dart';
import 'package:pogo_world/cubit/selector_cubit.dart';
import 'package:pogo_world/provider/move_provider.dart';
import 'package:pogo_world/provider/pokemon_provider.dart';
import 'package:pogo_world/repository/move_repository.dart';
import 'package:pogo_world/repository/pokemon_repository.dart';
import 'package:pogo_world/routes/route_generator.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final PokemonProvider _pokemonProvider = PokemonProvider();
  final MoveProvider _moveProvider = MoveProvider();

  late final PokemonRepository _pokemonRepository = PokemonRepository(pokemonProvider: _pokemonProvider);
  late final MoveRepository _moveRepository = MoveRepository(moveProvider: _moveProvider);

  late final PokedexCubit _pokedexCubit = PokedexCubit(pokemonRepository: _pokemonRepository);
  late final MoveCubit _moveCubit = MoveCubit(moveRepository: _moveRepository);
  final SelectorCubit _selectorCubit = SelectorCubit();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PokedexCubit>(create: (_) => _pokedexCubit),
        BlocProvider<MoveCubit>(create: (_) => _moveCubit),
        BlocProvider<SelectorCubit>(create: (_) => _selectorCubit),
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
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: kcWhiteColor,
            ),
          ),
          inputDecorationTheme: ktInputDecorationTheme,
          textSelectionTheme: ktTextSelectionTheme,
          textTheme: const TextTheme(
            caption: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w500,
              color: kcWhiteColor,
            ),
            subtitle2: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: kcWhiteColor,
            ),
            headline6: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: kcLightGrayColor,
            ),
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
