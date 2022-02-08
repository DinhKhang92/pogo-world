import 'package:equatable/equatable.dart';
import 'package:pogo_world/extensions/pokemon_type.dart';

class MoveField {
  static const String name = "name";
  static const String power = "power";
  static const String type = "type";
  static const String energyDelta = "energy_delta";
}

abstract class Move extends Equatable {
  final String name;
  final int power;
  final PokemonType type;
  final int energyDelta;

  const Move({
    required this.name,
    required this.type,
    required this.power,
    required this.energyDelta,
  });

  @override
  List<Object> get props => [name, power, type, energyDelta];
}
