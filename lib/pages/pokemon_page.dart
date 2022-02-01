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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    mapPokemonTypeToColor(widget.pokemon.type.first).withOpacity(0.5),
                    kcBackgroundColor.withOpacity(0.2),
                  ],
                  radius: 0.6,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: "${widget.pokemon.id}",
                    child: Image.asset(imageUrl),
                  ),
                  const SizedBox(height: Spacing.l),
                  Text(
                    widget.pokemon.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: Spacing.m),
                  Wrap(
                    spacing: Spacing.xs,
                    children: widget.pokemon.type.map((PokemonType type) {
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
                            Image.asset(
                              typeImageUrl,
                              height: 14,
                            ),
                            Text(type.name.capitalize(), style: TextStyle(color: mapPokemonTypeToColor(type))),
                          ],
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
