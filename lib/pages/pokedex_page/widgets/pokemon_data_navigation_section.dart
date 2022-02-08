import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pogo_world/config/colors.dart';
import 'package:pogo_world/config/spacing.dart';
import 'package:pogo_world/config/theme.dart';
import 'package:pogo_world/cubit/selector_cubit.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PokemonDataNavigationSection extends StatefulWidget {
  final List<String> labels;
  const PokemonDataNavigationSection({required this.labels, Key? key}) : super(key: key);

  @override
  _PokemonDataNavigationSectionState createState() => _PokemonDataNavigationSectionState();
}

class _PokemonDataNavigationSectionState extends State<PokemonDataNavigationSection> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Spacing.m),
        child: Wrap(
          spacing: Spacing.xs,
          children: _buildPokemonDataNavigationItems(),
        ),
      ),
    );
  }

  List<Widget> _buildPokemonDataNavigationItems() {
    final List<String> pokemonDataNavigationItemLabels = [
      AppLocalizations.of(context)!.pokemonPageDataNavigationLabelAbout,
      AppLocalizations.of(context)!.pokemonPageDataNavigationLabelStats,
      AppLocalizations.of(context)!.pokemonPageDataNavigationLabelMoves,
      AppLocalizations.of(context)!.pokemonPageDataNavigationLabelEvolutions,
      AppLocalizations.of(context)!.pokemonPageDataNavigationLabelLocation
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
                                height: 3,
                                width: 20,
                                decoration: BoxDecoration(
                                  color: kcWhiteColor,
                                  borderRadius: BorderRadius.circular(kbPokemonInfoNavigationBorderRadius),
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
