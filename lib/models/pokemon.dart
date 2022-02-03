import 'package:equatable/equatable.dart';
import 'package:pogo_world/extensions/pokemon_type.dart';

class Pokemon extends Equatable {
  final int id;
  final String name;
  final String form;
  final List<PokemonType> types;
  final int baseAttack;
  final int baseDefense;
  final int baseStamina;

  const Pokemon({
    required this.id,
    required this.name,
    required this.form,
    required this.types,
    required this.baseAttack,
    required this.baseDefense,
    required this.baseStamina,
  });

  @override
  List<Object?> get props => [id, name, form, types, baseAttack, baseDefense, baseStamina];

  factory Pokemon.fromJSON(Map json) => Pokemon(
        id: json["id"],
        name: json["name"],
        form: json["form"],
        types: json["types"],
        baseAttack: json["base_attack"],
        baseDefense: json["base_defense"],
        baseStamina: json["base_stamina"],
      );
}
