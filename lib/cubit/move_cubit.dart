import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pogo_world/models/move.dart';
import 'package:pogo_world/repository/move_repository.dart';

part 'move_state.dart';

class MoveCubit extends Cubit<MoveState> {
  final MoveRepository moveRepository;
  MoveCubit({required this.moveRepository}) : super(const MoveInitial(quickMoves: []));

  Future<void> getMoves() async {
    emit(MoveLoading(quickMoves: state.quickMoves));
    List<Move> quickMoves = await moveRepository.getMoves();
    emit(MoveLoaded(quickMoves: quickMoves));
  }
}
