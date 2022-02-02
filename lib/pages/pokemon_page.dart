import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pogo_world/config/colors.dart';
import 'package:pogo_world/config/spacing.dart';
import 'package:pogo_world/config/theme.dart';
import 'package:pogo_world/cubit/selector_cubit.dart';
import 'package:pogo_world/extensions/capitalize.dart';
import 'package:pogo_world/extensions/pokemon_type.dart';
import 'package:pogo_world/models/pokemon.dart';
import 'package:pogo_world/utils/map_pokemon_type_to_color.dart';

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
    final String imageUrl = 'assets/pokemon/${widget.pokemon.id}.png';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Stack(
        children: [
          _buildRadialGradientBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Align(
                  alignment: const Alignment(0.0, 0.6),
                  child: Container(
                    child: _buildPokemonBanner(imageUrl),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: DraggableScrollableSheet(
                  initialChildSize: 0.8,
                  maxChildSize: 1.0,
                  minChildSize: 0.8,
                  builder: (context, scrollController) {
                    return SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      controller: scrollController,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        // decoration: BoxDecoration(
                        //   gradient: LinearGradient(
                        //     colors: [
                        //       kcBackgroundColor.withOpacity(0.01),
                        //       Colors.grey.withOpacity(0.1),
                        //     ],
                        //     begin: Alignment.bottomCenter,
                        //     end: Alignment.topCenter,
                        //   ),
                        //   borderRadius: const BorderRadius.all(Radius.circular(40)),
                        // ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.l),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: _buildPokemonDataNavigationItems(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPokemonBanner(String imageUrl) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildPokemonImage(imageUrl),
        const SizedBox(height: Spacing.l),
        _buildPokemonName(),
        const SizedBox(height: Spacing.m),
        _buildPokemonType(),
      ],
    );
  }

  Widget _buildRadialGradientBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0.0, -0.4),
          colors: [
            mapPokemonTypeToColor(widget.pokemon.types.first).withOpacity(0.5),
            kcBackgroundColor.withOpacity(0.2),
          ],
          radius: 0.6,
        ),
      ),
    );
  }

  Widget _buildPokemonType() {
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

  Widget _buildPokemonName() {
    return Text(
      widget.pokemon.name,
      style: Theme.of(context).textTheme.caption,
    );
  }

  Widget _buildPokemonImage(String imageUrl) {
    return Hero(
      tag: "${widget.pokemon.id}",
      child: Image.asset(imageUrl),
    );
  }

  List<Widget> _buildPokemonDataNavigationItems() {
    final List<String> pokemonDataNavigationItemLabels = [
      AppLocalizations.of(context)!.pokemonPageDataNavigationLabelAbout,
      AppLocalizations.of(context)!.pokemonPageDataNavigationLabelStats,
      AppLocalizations.of(context)!.pokemonPageDataNavigationLabelMoves,
      AppLocalizations.of(context)!.pokemonPageDataNavigationLabelEvolutions
    ];
    final Map<int, String> pokemonDataNavigationItemLabelsMap = pokemonDataNavigationItemLabels.asMap();

    return pokemonDataNavigationItemLabelsMap
        .map((index, label) {
          return MapEntry(
            index,
            GestureDetector(
              onTap: () => BlocProvider.of<SelectorCubit>(context).setPokemonDataSelector(index),
              child: Container(
                color: kcTransparentColor,
                padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.xxs),
                child: BlocBuilder<SelectorCubit, SelectorState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: Spacing.xxxs),
                          child: Text(
                            label,
                            style: index == state.pokemonDataSelectorIndex ? Theme.of(context).textTheme.subtitle2 : Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        index == state.pokemonDataSelectorIndex
                            ? Container(
                                width: 20,
                                height: 5,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 3,
                                      color: kcWhiteColor,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        })
        .values
        .toList();
  }
}
