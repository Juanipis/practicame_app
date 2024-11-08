import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicame_app/game/model/game_input.dart';
import 'package:practicame_app/game/view/game_page.dart';
import 'package:practicame_app/game_session/cubit/game_session_cubit.dart';
import 'package:user_repository/user_repository.dart';

class GameSessionPage extends StatelessWidget {
  const GameSessionPage(
      {required this.games, required this.userRepository, super.key});
  final List<GameInput> games;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GameSessionCubit(games, userRepository),
      child: const GameSessionView(),
    );
  }
}

class GameSessionView extends StatelessWidget {
  const GameSessionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sesión de juego'),
        actions: [
          BlocBuilder<GameSessionCubit, GameSessionState>(
            builder: (context, state) {
              return Row(
                children: [
                  Text('${state.totalGoldStars}'),
                  const Icon(Icons.star, color: Colors.yellow),
                  Text('${state.totalGreenStars}'),
                  const Icon(Icons.star, color: Colors.green),
                ],
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<GameSessionCubit, GameSessionState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.isCompleted) {
            return Column(
              children: [
                const Center(
                  child: Text(
                    'Lección Finalizada!',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Congratulations! You have completed all games with ${state.totalGoldStars} gold stars and ${state.totalGreenStars} green stars!',
                  ),
                ),
              ],
            );
          } else {
            final currentGame = state.games[state.currentGameIndex];
            return GamePage(
              key: ValueKey(currentGame.id),
              gameInput: currentGame,
              onGameComplete: (int earnedGoldStars, int earnedGreenStars) {
                context
                    .read<GameSessionCubit>()
                    .completeGame(earnedGoldStars, earnedGreenStars);
              },
            );
          }
        },
      ),
    );
  }
}
