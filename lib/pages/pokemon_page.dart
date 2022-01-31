import 'package:flutter/material.dart';

class PokemonPage extends StatefulWidget {
  final int id;
  const PokemonPage({required this.id, Key? key}) : super(key: key);

  @override
  _PokemonPageState createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  @override
  Widget build(BuildContext context) {
    final String imageUrl = 'assets/pokemon/${widget.id}.png';
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Hero(
          tag: "${widget.id}",
          child: Image.asset(imageUrl),
        ),
      ),
    );
  }
}
