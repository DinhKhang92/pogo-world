part of 'selector_cubit.dart';

class SelectorState extends Equatable {
  final int pokemonDataSelectorIndex;
  const SelectorState({required this.pokemonDataSelectorIndex});

  @override
  List<Object> get props => [pokemonDataSelectorIndex];
}
