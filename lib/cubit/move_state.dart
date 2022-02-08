part of 'move_cubit.dart';

abstract class MoveState extends Equatable {
  final List<Move> quickMoves;
  const MoveState({required this.quickMoves});

  @override
  List<Object> get props => [quickMoves];
}

class MoveInitial extends MoveState {
  const MoveInitial({required List<Move> quickMoves}) : super(quickMoves: quickMoves);
}

class MoveLoading extends MoveState {
  const MoveLoading({required List<Move> quickMoves}) : super(quickMoves: quickMoves);
}

class MoveLoaded extends MoveState {
  const MoveLoaded({required List<Move> quickMoves}) : super(quickMoves: quickMoves);
}

class MoveError extends MoveState {
  MoveError() : super(quickMoves: []);
}
