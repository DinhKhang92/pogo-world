import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pogo_world/config/colors.dart';
import 'package:pogo_world/config/spacing.dart';
import 'package:pogo_world/config/theme.dart';
import 'package:pogo_world/cubit/selector_cubit.dart';
import 'package:pogo_world/extensions/capitalize.dart';
import 'package:pogo_world/extensions/pokemon_type.dart';
import 'package:pogo_world/models/pokemon.dart';
import 'package:pogo_world/pages/pokemon_page/widgets/pokemon_data_navigation_section.dart';
import 'package:pogo_world/pages/pokemon_page/widgets/pokemon_section_stats.dart';
import 'package:pogo_world/utils/map_pokemon_type_to_color.dart';
import 'package:pogo_world/widgets/radial_gradient_background.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PokemonPage extends StatefulWidget {
  final Pokemon pokemon;
  const PokemonPage({required this.pokemon, Key? key}) : super(key: key);

  @override
  _PokemonPageState createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  @override
  void initState() {
    _clearSelectors();
    super.initState();
  }

  void _clearSelectors() => BlocProvider.of<SelectorCubit>(context).clearSelectors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final String pokemonId = ("${widget.pokemon.id}").padLeft(3, '0');
    final String imageUrl = 'assets/pokemon/${widget.pokemon.id}.png';
    final List<String> pokemonDataNavigationItemLabels = [
      AppLocalizations.of(context)!.pokemonPageDataNavigationLabelAbout,
      AppLocalizations.of(context)!.pokemonPageDataNavigationLabelStats,
      AppLocalizations.of(context)!.pokemonPageDataNavigationLabelMoves,
      AppLocalizations.of(context)!.pokemonPageDataNavigationLabelEvolutions,
      AppLocalizations.of(context)!.pokemonPageDataNavigationLabelLocation
    ];

    return Stack(
      children: [
        RadialGradientBackground(
          innerColor: mapPokemonTypeToColor(widget.pokemon.types.first).withOpacity(0.5),
          outerColor: kcBackgroundColor.withOpacity(0.2),
          center: const Alignment(0.0, -0.4),
        ),
        _buildPokemonIdBackground(pokemonId),
        _buildPokemonPageContent(imageUrl, pokemonDataNavigationItemLabels),
      ],
    );
  }

  Widget _buildPokemonIdBackground(String pokemonId) {
    return Align(
      alignment: const Alignment(0.8, -0.8),
      child: Text(
        "#$pokemonId",
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width / 7,
          color: kcLightGrayColor.withOpacity(0.2),
        ),
      ),
    );
  }

  Widget _buildPokemonPageContent(String imageUrl, List<String> pokemonDataNavigationItemLabels) {
    return Column(
      children: [
        _buildPokemonBanner(imageUrl),
        _buildPokemonData(pokemonDataNavigationItemLabels),
      ],
    );
  }

  Widget _buildPokemonBanner(String imageUrl) {
    return Expanded(
      child: Align(
        alignment: const Alignment(0.0, 0.6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPokemonImage(imageUrl),
            const SizedBox(height: Spacing.l),
            _buildPokemonName(),
            const SizedBox(height: Spacing.m),
            _buildPokemonTypes(),
          ],
        ),
      ),
    );
  }

  Widget _buildPokemonData(List<String> pokemonDataNavigationItemLabels) {
    return Expanded(
      child: Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [
        //       kcBackgroundColor.withOpacity(0.01),
        //       kcLightGrayColor.withOpacity(0.1),
        //     ],
        //     begin: Alignment.bottomCenter,
        //     end: Alignment.topCenter,
        //   ),
        //   borderRadius: const BorderRadius.all(Radius.circular(kbPokemonInfoBorderRadius)),
        // ),
        child: Column(
          children: [
            PokemonDataNavigationSection(labels: pokemonDataNavigationItemLabels),
            const SizedBox(height: Spacing.s),
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
                  child: BlocBuilder<SelectorCubit, SelectorState>(
                    builder: (context, state) {
                      if (state.pokemonDataSelectorIndex == 1) {
                        return PokemonSectionStats(pokemon: widget.pokemon);
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPokemonImage(String imageUrl) {
    return Hero(
      tag: "${widget.pokemon.id}",
      child: Image.asset(imageUrl),
    );
  }

  Widget _buildPokemonName() {
    return Text(
      widget.pokemon.name,
      style: Theme.of(context).textTheme.caption,
    );
  }

  Widget _buildPokemonTypes() {
    return Wrap(
      spacing: Spacing.xs,
      children: widget.pokemon.types.map((PokemonType type) {
        final String typeImageUrl = 'assets/types/${type.name}.png';

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.xxs),
          decoration: BoxDecoration(
            border: Border.all(color: mapPokemonTypeToColor(type)),
            borderRadius: BorderRadius.circular(kbGridTileBorderRadius),
          ),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: Spacing.xs,
            children: [
              Image.asset(typeImageUrl, height: 14),
              Text(type.name.capitalize(), style: TextStyle(color: mapPokemonTypeToColor(type))),
            ],
          ),
        );
      }).toList(),
    );
  }
}
