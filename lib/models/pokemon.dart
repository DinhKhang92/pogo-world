import 'package:equatable/equatable.dart';
import 'package:pogo_world/extensions/pokemon_type.dart';

class Pokemon extends Equatable {
  final int id;
  final String name;
  final String form;
  final List<PokemonType> types;

  const Pokemon({
    required this.id,
    required this.name,
    required this.form,
    required this.types,
  });

  @override
  List<Object?> get props => [id, name, form, types];

  factory Pokemon.fromJSON(Map json) => Pokemon(
        id: json["id"],
        name: json["name"],
        form: json["form"],
        types: json["types"],
      );
}
