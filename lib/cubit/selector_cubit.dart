import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'selector_state.dart';

class SelectorCubit extends Cubit<SelectorState> {
  SelectorCubit() : super(const SelectorState(pokemonDataSelectorIndex: 0));

  void setPokemonDataSelector(int index) => emit(SelectorState(pokemonDataSelectorIndex: index));

  void clearSelectors() => emit(const SelectorState(pokemonDataSelectorIndex: 0));
}
