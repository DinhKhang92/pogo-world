part of 'pokedex_cubit.dart';

abstract class PokedexState extends Equatable {
  final List<Pokemon> pokemon;
  final List<Pokemon> filteredPokemon;

  const PokedexState({required this.pokemon, required this.filteredPokemon});

  @override
  List<Object> get props => [pokemon, filteredPokemon];
}

class PokedexInitial extends PokedexState {
  const PokedexInitial({required List<Pokemon> pokemon, required List<Pokemon> filteredPokemon}) : super(pokemon: pokemon, filteredPokemon: filteredPokemon);
}

class PokedexLoading extends PokedexState {
  const PokedexLoading({required List<Pokemon> pokemon, required List<Pokemon> filteredPokemon}) : super(pokemon: pokemon, filteredPokemon: filteredPokemon);
}

class PokedexLoaded extends PokedexState {
  const PokedexLoaded({required List<Pokemon> pokemon, required List<Pokemon> filteredPokemon}) : super(pokemon: pokemon, filteredPokemon: filteredPokemon);
}

class PokedexError extends PokedexState {
  PokedexError() : super(pokemon: [], filteredPokemon: []);
}
