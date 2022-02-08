import 'package:pogo_world/extensions/pokemon_type.dart';
import 'package:pogo_world/models/move.dart';

class QuickMoveField {
  static const String duration = "duration";
}

class QuickMove extends Move {
  final int duration;

  const QuickMove({
    required this.duration,
    required String name,
    required PokemonType type,
    required int power,
    required int energyDelta,
  }) : super(
          name: name,
          type: type,
          power: power,
          energyDelta: energyDelta,
        );

  factory QuickMove.fromJSON(Map json) => QuickMove(
        duration: json[QuickMoveField.duration],
        name: json[MoveField.name],
        type: json[MoveField.type],
        power: json[MoveField.power],
        energyDelta: json[MoveField.energyDelta],
      );

  @override
  List<Object> get props => [...super.props, duration];
}
