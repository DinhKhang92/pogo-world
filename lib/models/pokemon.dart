import 'package:equatable/equatable.dart';
import 'package:pogo_world/extensions/pokemon_type.dart';

class PokemonField {
  static const String id = "id";
  static const String name = "name";
  static const String form = "form";
  static const String types = "types";
  static const String baseAttack = "base_attack";
  static const String baseDefense = "base_defense";
  static const String baseStamina = "base_stamina";
  static const String weaknesses = "weaknesses";
  static const String doubleWeaknesses = "double_weaknesses";
  static const String resistances = "resistances";
  static const String doubleResistances = "double_resistances";
  static const String tripleResistances = "triple_resistances";
}

class Pokemon extends Equatable {
  final int id;
  final String name;
  final String form;
  final List<PokemonType> types;
  final int baseAttack;
  final int baseDefense;
  final int baseStamina;
  final List<PokemonType> weaknesses;
  final List<PokemonType> doubleWeaknesses;
  final List<PokemonType> resistances;
  final List<PokemonType> doubleResistances;
  final List<PokemonType> tripleResistances;

  const Pokemon({
    required this.id,
    required this.name,
    required this.form,
    required this.types,
    required this.baseAttack,
    required this.baseDefense,
    required this.baseStamina,
    required this.weaknesses,
    required this.doubleWeaknesses,
    required this.resistances,
    required this.doubleResistances,
    required this.tripleResistances,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        form,
        types,
        baseAttack,
        baseDefense,
        baseStamina,
        weaknesses,
        doubleWeaknesses,
        resistances,
        doubleResistances,
        tripleResistances,
      ];

  factory Pokemon.fromJSON(Map json) => Pokemon(
        id: json[PokemonField.id],
        name: json[PokemonField.name],
        form: json[PokemonField.form],
        types: json[PokemonField.types],
        baseAttack: json[PokemonField.baseAttack],
        baseDefense: json[PokemonField.baseDefense],
        baseStamina: json[PokemonField.baseStamina],
        weaknesses: json[PokemonField.weaknesses],
        doubleWeaknesses: json[PokemonField.doubleWeaknesses],
        resistances: json[PokemonField.resistances],
        doubleResistances: json[PokemonField.doubleResistances],
        tripleResistances: json[PokemonField.tripleResistances],
      );
}
