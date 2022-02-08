import 'package:pogo_world/models/move.dart';
import 'package:pogo_world/models/quick_move.dart';
import 'package:pogo_world/provider/move_provider.dart';
import 'package:pogo_world/utils/get_pokemon_type.dart';

class MoveRepository {
  final MoveProvider moveProvider;

  const MoveRepository({required this.moveProvider});

  Future<List<Move>> getMoves() async {
    final List quickMovesData = await moveProvider.fetchQuickMoves();
    final List<QuickMove> quickMoves = quickMovesData
        .map((quickMoveData) => QuickMove.fromJSON(
              {
                MoveField.name: quickMoveData["name"],
                MoveField.type: getPokemonType(quickMoveData["type"]),
                MoveField.power: quickMoveData["power"],
                MoveField.energyDelta: quickMoveData["energy_delta"],
                QuickMoveField.duration: quickMoveData["duration"],
              },
            ))
        .toList();

    return quickMoves;
  }
}
