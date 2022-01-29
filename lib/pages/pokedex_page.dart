import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pogo_world/config/colors.dart';
import 'package:pogo_world/config/spacing.dart';
import 'package:pogo_world/config/theme.dart';
import 'package:pogo_world/cubit/pokedex_cubit.dart';

class PokededxPage extends StatefulWidget {
  const PokededxPage({Key? key}) : super(key: key);

  @override
  _PokededxPageState createState() => _PokededxPageState();
}

class _PokededxPageState extends State<PokededxPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
      child: BlocBuilder<PokedexCubit, PokedexState>(
        builder: (context, state) {
          if (state is PokedexLoaded) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: Spacing.xxs,
                mainAxisSpacing: Spacing.xxs,
              ),
              itemCount: state.pokedex.length,
              itemBuilder: (context, index) {
                final String id = state.pokedex.keys.elementAt(index);
                final String imageUrl = 'assets/pokemon/$id.png';
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: kcHintColor),
                    borderRadius: BorderRadius.circular(kbGridTileBorderRadius),
                  ),
                  child: Center(
                    child: Image.asset(imageUrl),
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
}
