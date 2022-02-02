import 'package:flutter/material.dart';
import 'package:pogo_world/config/colors.dart';
import 'package:pogo_world/config/spacing.dart';
import 'package:pogo_world/config/theme.dart';
import 'package:pogo_world/extensions/capitalize.dart';
import 'package:pogo_world/extensions/pokemon_type.dart';
import 'package:pogo_world/models/pokemon.dart';
import 'package:pogo_world/utils/map_pokemon_type_to_color.dart';

class PokemonPage extends StatefulWidget {
  final Pokemon pokemon;
  const PokemonPage({required this.pokemon, Key? key}) : super(key: key);

  @override
  _PokemonPageState createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
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
                // child: Container(
                //   color: Colors.red,
                // ),
                child: Align(alignment: const Alignment(0.0, 0.6), child: _buildPokemonBanner(imageUrl)),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: DraggableScrollableSheet(
                  initialChildSize: 1.0,
                  maxChildSize: 1.0,
                  minChildSize: 1.0,
                  builder: (context, scrollController) {
                    return SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      controller: scrollController,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        // color: Colors.red,
                        // decoration: BoxDecoration(
                        //   gradient: LinearGradient(
                        //     colors: [
                        //       kcBackgroundColor.withOpacity(0.01),
                        //       Colors.grey.withOpacity(0.1),
                        //     ],
                        //     begin: Alignment.bottomCenter,
                        //     end: Alignment.topCenter,
                        //   ),
                        //   borderRadius: const BorderRadius.all(
                        //     Radius.circular(40),
                        //   ),
                        // ),
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                color: Colors.red,
                                child: Wrap(
                                  runAlignment: WrapAlignment.spaceBetween,
                                  spacing: Spacing.xxl,
                                  children: const [
                                    Text("About"),
                                    Text("Stats"),
                                    Text("Moves"),
                                    Text("Evolution"),
                                  ],
                                ),
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
        Column(
          children: [
            _buildPokemonImage(imageUrl),
            const SizedBox(height: Spacing.l),
            _buildPokemonName(),
            const SizedBox(height: Spacing.m),
            _buildPokemonType(),
          ],
        ),
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
}
