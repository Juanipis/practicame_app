import 'package:bloc/bloc.dart';
import 'package:practicame_app/game/model/game_input.dart';
import 'package:user_repository/user_repository.dart';

class GameSessionCubit extends Cubit<GameSessionState> {
  GameSessionCubit(List<GameInput> games, this._userRepository)
      : super(
          const GameSessionState(
            games: [],
            currentGameIndex: 0,
            totalStars: 0,
            totalGoldStars: 0,
            totalGreenStars: 0,
            isLoading: true,
          ),
        ) {
    _initializeGames(games);
  }
  final UserRepository _userRepository;

  Future<void> _initializeGames(List<GameInput> games) async {
    final modifiedGames = await _getAnswersForGames(games, _userRepository);
    emit(
      state.copyWith(
        games: modifiedGames,
        isLoading: false,
      ),
    );
  }

  static Future<List<GameInput>> _getAnswersForGames(
      List<GameInput> games, UserRepository userRepository) async {
    final user = await userRepository.getUser();
    return games.map((game) {
      final answer = game.getUserAttributeValue(user);
      return game.copyWith(answer: answer);
    }).toList();
  }

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
      _userRepository.appendStars(
        newTotalGoldStars,
        newTotalGreenStars,
      );
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
    required this.isLoading,
    this.isCompleted = false,
  });
  final List<GameInput> games;
  final int currentGameIndex;
  final int totalStars;
  final int totalGoldStars;
  final int totalGreenStars;
  final bool isCompleted;
  final bool isLoading;

  GameSessionState copyWith({
    List<GameInput>? games,
    int? currentGameIndex,
    int? totalStars,
    int? totalGoldStars,
    int? totalGreenStars,
    bool? isCompleted,
    bool? isLoading,
  }) {
    return GameSessionState(
      games: games ?? this.games,
      currentGameIndex: currentGameIndex ?? this.currentGameIndex,
      totalStars: totalStars ?? this.totalStars,
      isCompleted: isCompleted ?? this.isCompleted,
      totalGoldStars: totalGoldStars ?? this.totalGoldStars,
      totalGreenStars: totalGreenStars ?? this.totalGreenStars,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  List<Object> get props => [games, currentGameIndex, totalStars, isCompleted];
}
