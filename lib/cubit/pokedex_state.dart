part of 'pokedex_cubit.dart';

abstract class PokedexState extends Equatable {
  final Map pokemon;
  final Map filteredPokemon;

  const PokedexState({required this.pokemon, required this.filteredPokemon});

  @override
  List<Object> get props => [pokemon];
}

class PokedexInitial extends PokedexState {
  const PokedexInitial({required Map pokemon, required Map filteredPokemon}) : super(pokemon: pokemon, filteredPokemon: filteredPokemon);
}

class PokedexLoading extends PokedexState {
  const PokedexLoading({required Map pokemon, required Map filteredPokemon}) : super(pokemon: pokemon, filteredPokemon: filteredPokemon);
}

class PokedexLoaded extends PokedexState {
  const PokedexLoaded({required Map pokemon, required Map filteredPokemon}) : super(pokemon: pokemon, filteredPokemon: filteredPokemon);
}

class PokedexError extends PokedexState {
  PokedexError() : super(pokemon: {}, filteredPokemon: {});
}
