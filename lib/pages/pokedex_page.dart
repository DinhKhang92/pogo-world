import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pogo_world/config/colors.dart';
import 'package:pogo_world/config/spacing.dart';
import 'package:pogo_world/config/theme.dart';
import 'package:pogo_world/cubit/pokedex_cubit.dart';
import 'package:pogo_world/extensions/generation.dart';
import 'package:pogo_world/models/pokemon_page_args.dart';
import 'package:pogo_world/routes/route_generator.dart';
import 'package:pogo_world/utils/get_unreleased_pokemon_count.dart';
import 'package:pogo_world/widgets/generation_navigation_item.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({Key? key}) : super(key: key);

  @override
  _PokedexPageState createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(AppLocalizations.of(context)!.landingPageCardLabelPokedex),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.s),
      child: Column(
        children: [
          _buildSearchbar(),
          const SizedBox(height: Spacing.m),
          _buildHorizontalNavigationItems(),
          const SizedBox(height: Spacing.m),
          _buildPokemonGrid(),
        ],
      ),
    );
  }

  Widget _buildSearchbar() {
    return Container(
      decoration: BoxDecoration(
        color: kcGrayColor,
        borderRadius: BorderRadius.circular(kbGridTileBorderRadius),
      ),
      child: TextField(
        controller: _searchFieldController,
        onChanged: (String pokemon) => BlocProvider.of<PokedexCubit>(context).searchPokemon(pokemon),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.pokedexPageSearchbarHintText,
        ),
      ),
    );
  }

  Widget _buildHorizontalNavigationItems() {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: Spacing.xs,
        children: Generation.values.map(
          (Generation generation) {
            final String filterImageUrl = 'assets/pokedex/${generation.image}.png';

            return GenerationNavigationItem(
              generation: generation,
              navigateToGeneration: _navigateToGeneration,
              filterImageUrl: filterImageUrl,
            );
          },
        ).toList(),
      ),
    );
  }

  Widget _buildPokemonGrid() {
    return Expanded(
      child: BlocBuilder<PokedexCubit, PokedexState>(
        builder: (context, state) {
          if (state is PokedexLoaded) {
            return GridView.builder(
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: Spacing.xxs,
                mainAxisSpacing: Spacing.xxs,
              ),
              itemCount: state.filteredPokemon.isEmpty ? state.pokemon.length : state.filteredPokemon.length,
              itemBuilder: (context, index) {
                final String id = state.filteredPokemon.isEmpty ? state.pokemon.keys.elementAt(index) : state.filteredPokemon.keys.elementAt(index);
                final String imageUrl = 'assets/pokemon/$id.png';

                return InkWell(
                  onTap: () => Navigator.of(context).pushNamed(Routes.pokemonPage, arguments: PokemonPageArgs(id: int.parse(id))),
                  child: Hero(
                    tag: id,
                    child: Container(
                      padding: const EdgeInsets.all(Spacing.xs),
                      decoration: BoxDecoration(
                        border: Border.all(color: kcHintColor),
                        borderRadius: BorderRadius.circular(kbGridTileBorderRadius),
                      ),
                      child: Center(
                        child: Image.asset(
                          imageUrl,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _navigateToGeneration(Generation generation) {
    const int indexOffset = 1;
    final int unreleasedPokemonCount = getUnreleasedPokemonCountToGivenGeneration(BlocProvider.of<PokedexCubit>(context).state.pokemon, generation);
    final int rowCount = ((generation.start - unreleasedPokemonCount - indexOffset) / 5).floor();

    _scrollController.animateTo(
      MediaQuery.of(context).size.width / 5 * rowCount - Spacing.xxs * rowCount,
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOut,
    );

    _searchFieldController.clear();
    BlocProvider.of<PokedexCubit>(context).searchPokemon('');
  }
}
