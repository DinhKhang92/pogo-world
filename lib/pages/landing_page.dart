import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pogo_world/config/colors.dart';
import 'package:pogo_world/config/spacing.dart';
import 'package:pogo_world/config/theme.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pogo_world/cubit/move_cubit.dart';
import 'package:pogo_world/cubit/pokedex_cubit.dart';
import 'package:pogo_world/routes/route_generator.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    fetchPokemon();
    fetchMoves();
    super.initState();
  }

  Future<void> fetchPokemon() async {
    BlocProvider.of<PokedexCubit>(context).getPokemon();
  }

  Future<void> fetchMoves() async {
    BlocProvider.of<MoveCubit>(context).getMoves();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(MdiIcons.text),
          onPressed: () => {},
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        children: [
          InkWell(
            onTap: () => Navigator.of(context).pushNamed(Routes.pokedexPage),
            child: Container(
              height: 90,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kbCardBorderRadius),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    kcPokedexColorGradientOne,
                    kcPokedexColorGradientTwo,
                  ],
                ),
              ),
              child: Center(child: Text(AppLocalizations.of(context)!.landingPageCardLabelPokedex)),
            ),
          ),
          const SizedBox(height: Spacing.m),
          InkWell(
            onTap: () => Navigator.of(context).pushNamed(Routes.movesPage),
            child: Container(
              height: 90,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kbCardBorderRadius),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    kcMovesColorGradientOne,
                    kcMovesColorGradientTwo,
                  ],
                ),
              ),
              child: Center(child: Text(AppLocalizations.of(context)!.landingPageCardLabelMoves)),
            ),
          ),
        ],
      ),
    );
  }
}
