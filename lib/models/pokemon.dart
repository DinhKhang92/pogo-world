import 'package:equatable/equatable.dart';
import 'package:pogo_world/extensions/pokemon_type.dart';

class Pokemon extends Equatable {
  final int id;
  final String name;
  final String form;
  final List<PokemonType> type;

  const Pokemon({
    required this.id,
    required this.name,
    required this.form,
    required this.type,
  });

  @override
  List<Object?> get props => [id, name, form, type];

  factory Pokemon.fromJSON(Map json) => Pokemon(
        id: json["id"],
        name: json["name"],
        form: json["form"],
        type: json["type"],
      );
}
