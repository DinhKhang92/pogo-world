import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pogo_world/config/colors.dart';
import 'package:pogo_world/config/spacing.dart';
import 'package:pogo_world/config/theme.dart';
import 'package:pogo_world/cubit/pokedex_cubit.dart';
import 'package:pogo_world/extensions/pokemon_type.dart';
import 'package:pogo_world/models/pokemon.dart';
import 'package:pogo_world/utils/get_max_stats.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pogo_world/utils/map_pokemon_type_to_color.dart';
import 'package:pogo_world/widgets/rounded_progress_bar.dart';

class PokemonSectionStats extends StatefulWidget {
  final Pokemon pokemon;
  const PokemonSectionStats({required this.pokemon, Key? key}) : super(key: key);

  @override
  _PokemonSectionStatsState createState() => _PokemonSectionStatsState();
}

class _PokemonSectionStatsState extends State<PokemonSectionStats> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokedexCubit, PokedexState>(
      builder: (context, state) {
        final int maxAttack = getMaxBaseAttack(state.pokemon);
        final int maxDefense = getMaxBaseDefense(state.pokemon);
        final int maxStamina = getMaxBaseStamina(state.pokemon);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsBar(
              AppLocalizations.of(context)!.pokemonPageDataAttackLabel,
              widget.pokemon.baseAttack,
              widget.pokemon.baseAttack / maxAttack,
            ),
            const SizedBox(height: Spacing.s),
            _buildStatsBar(
              AppLocalizations.of(context)!.pokemonPageDataDefenseLabel,
              widget.pokemon.baseDefense,
              widget.pokemon.baseDefense / maxDefense,
            ),
            const SizedBox(height: Spacing.s),
            _buildStatsBar(
              AppLocalizations.of(context)!.pokemonPageDataStaminaLabel,
              widget.pokemon.baseStamina,
              widget.pokemon.baseStamina / maxStamina,
            ),
            const SizedBox(height: Spacing.xl),
            _buildEffectivenessSection(),
          ],
        );
      },
    );
  }

  Widget _buildEffectivenessSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.pokemonPageDataWeaknessesLabel,
          style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.red),
        ),
        const SizedBox(height: Spacing.xxxs),
        Wrap(
          spacing: Spacing.xxxs,
          runSpacing: Spacing.xxxs,
          children: [
            ..._buildPokemonEffectiveness(widget.pokemon.doubleWeaknesses, multiplier: AppLocalizations.of(context)!.pokemonPageDataEffectivenessMultiplierLabel2x),
            ..._buildPokemonEffectiveness(widget.pokemon.weaknesses),
          ],
        ),
        const SizedBox(height: Spacing.l),
        Text(
          AppLocalizations.of(context)!.pokemonPageDataResistancesLabel,
          style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.green),
        ),
        const SizedBox(height: Spacing.xxxs),
        Wrap(
          spacing: Spacing.xxxs,
          runSpacing: Spacing.xxxs,
          children: [
            ..._buildPokemonEffectiveness(widget.pokemon.tripleResistances, multiplier: AppLocalizations.of(context)!.pokemonPageDataEffectivenessMultiplierLabel3x),
            ..._buildPokemonEffectiveness(widget.pokemon.doubleResistances, multiplier: AppLocalizations.of(context)!.pokemonPageDataEffectivenessMultiplierLabel2x),
            ..._buildPokemonEffectiveness(widget.pokemon.resistances),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsBar(String label, int statsValue, double percent) {
    return Row(
      children: [
        Container(
          constraints: const BoxConstraints(minWidth: 30),
          child: Text(
            label,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        const SizedBox(width: Spacing.xl),
        Container(
          constraints: const BoxConstraints(minWidth: 30),
          child: Text(
            "$statsValue",
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        const SizedBox(width: Spacing.xl),
        Expanded(
          child: RoundedProgressBar(
            percent: percent,
            color: mapPokemonTypeToColor(widget.pokemon.types.first),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildPokemonEffectiveness(List<PokemonType> effectivenessList, {String? multiplier}) {
    return effectivenessList
        .map(
          (PokemonType type) => Stack(
            alignment: Alignment.topRight,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(Spacing.xxs),
                    child: Image.asset(
                      'assets/types/${type.name}.png',
                      height: 32,
                    ),
                  ),
                  multiplier != null
                      ? Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: kcBackgroundColor,
                            borderRadius: BorderRadius.circular(kbPokemonInfoEffectivenessMultiplierBorderRadius),
                          ),
                          child: Text(
                            multiplier,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ],
          ),
        )
        .toList();
  }
}
