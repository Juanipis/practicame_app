import 'package:bloc/bloc.dart';
import 'package:practicame_app/game/model/game_input.dart';

class GameSessionCubit extends Cubit<GameSessionState> {
  GameSessionCubit(List<GameInput> games)
      : super(
          GameSessionState(
            games: games,
            currentGameIndex: 0,
            totalStars: 0,
            totalGoldStars: 0,
            totalGreenStars: 0,
          ),
        );

  void completeGame(int goldStars, int greenStars) {
    final newTotalGoldStars = state.totalGoldStars + goldStars;
    final newTotalGreenStars = state.totalGreenStars + greenStars;
    final nextGameIndex = state.currentGameIndex + 1;

    if (nextGameIndex < state.games.length) {
      emit(
        state.copyWith(
          currentGameIndex: nextGameIndex,
          totalGoldStars: newTotalGoldStars,
          totalGreenStars: newTotalGreenStars,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isCompleted: true,
          totalGoldStars: newTotalGoldStars,
          totalGreenStars: newTotalGreenStars,
        ),
      );
    }
  }
}

class GameSessionState {
  const GameSessionState({
    required this.games,
    required this.currentGameIndex,
    required this.totalStars,
    required this.totalGoldStars,
    required this.totalGreenStars,
    this.isCompleted = false,
  });
  final List<GameInput> games;
  final int currentGameIndex;
  final int totalStars;
  final int totalGoldStars;
  final int totalGreenStars;
  final bool isCompleted;

  GameSessionState copyWith({
    List<GameInput>? games,
    int? currentGameIndex,
    int? totalStars,
    int? totalGoldStars,
    int? totalGreenStars,
    bool? isCompleted,
  }) {
    return GameSessionState(
      games: games ?? this.games,
      currentGameIndex: currentGameIndex ?? this.currentGameIndex,
      totalStars: totalStars ?? this.totalStars,
      isCompleted: isCompleted ?? this.isCompleted,
      totalGoldStars: totalGoldStars ?? this.totalGoldStars,
      totalGreenStars: totalGreenStars ?? this.totalGreenStars,
    );
  }

  List<Object> get props => [games, currentGameIndex, totalStars, isCompleted];
}
