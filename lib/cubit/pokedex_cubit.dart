import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pogo_world/repository/pokemon_repository.dart';

part 'pokedex_state.dart';

class PokedexCubit extends Cubit<PokedexState> {
  final PokemonRepository pokemonRepository;
  PokedexCubit({required this.pokemonRepository}) : super(const PokedexInitial(pokedex: {}));

  Future<void> getPokemon() async {
    emit(PokedexLoading(pokedex: state.pokedex));
    final Map pokemon = await pokemonRepository.getReleasedPokemon();
    emit(PokedexLoaded(pokedex: pokemon));
  }
}
