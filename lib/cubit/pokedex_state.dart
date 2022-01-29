part of 'pokedex_cubit.dart';

abstract class PokedexState extends Equatable {
  final Map pokedex;

  const PokedexState({required this.pokedex});

  @override
  List<Object> get props => [pokedex];
}

class PokedexInitial extends PokedexState {
  const PokedexInitial({required Map pokedex}) : super(pokedex: pokedex);
}

class PokedexLoading extends PokedexState {
  const PokedexLoading({required Map pokedex}) : super(pokedex: pokedex);
}

class PokedexLoaded extends PokedexState {
  const PokedexLoaded({required Map pokedex}) : super(pokedex: pokedex);
}

class PokedexError extends PokedexState {
  PokedexError() : super(pokedex: {});
}
