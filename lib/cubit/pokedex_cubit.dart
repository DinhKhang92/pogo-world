import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pogo_world/models/pokemon.dart';
import 'package:pogo_world/repository/pokemon_repository.dart';

part 'pokedex_state.dart';

class PokedexCubit extends Cubit<PokedexState> {
  final PokemonRepository pokemonRepository;
  PokedexCubit({required this.pokemonRepository}) : super(const PokedexInitial(pokemon: [], filteredPokemon: []));

  Future<void> getPokemon() async {
    emit(PokedexLoading(pokemon: state.pokemon, filteredPokemon: state.filteredPokemon));
    final List<Pokemon> pokemon = await pokemonRepository.getReleasedPokemon();
    emit(PokedexLoaded(pokemon: pokemon, filteredPokemon: state.filteredPokemon));
  }

  void searchPokemon(String substring) {
    emit(PokedexLoading(pokemon: state.pokemon, filteredPokemon: state.filteredPokemon));
    final List<Pokemon> filteredPokemon = pokemonRepository.searchPokemon(state.pokemon, substring);
    emit(PokedexLoaded(pokemon: state.pokemon, filteredPokemon: filteredPokemon));
  }

  void clearFilteredPokemon() => emit(PokedexLoaded(pokemon: state.pokemon, filteredPokemon: const []));
}
