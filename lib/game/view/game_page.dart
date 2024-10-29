import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:practicame_app/game/cubit/game_cubit.dart';
import 'package:practicame_app/game/model/game_input.dart';
import 'package:practicame_app/game/view/answer_input.dart';

class GamePage extends StatelessWidget {
  const GamePage({
    required this.gameInput,
    required this.onGameComplete,
    super.key,
  });

  final GameInput gameInput;
  final void Function(int, int) onGameComplete;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GameCubit(gameInput.answer),
      child: GameView(gameInput: gameInput, onGameComplete: onGameComplete),
    );
  }
}

class GameView extends StatelessWidget {
  const GameView({
    required this.gameInput,
    required this.onGameComplete,
    super.key,
  });

  final GameInput gameInput;
  final void Function(int, int) onGameComplete;

  @override
  Widget build(BuildContext context) {
    return GameBody(gameInput: gameInput, onGameComplete: onGameComplete);
  }
}

class ContinueButton extends StatelessWidget {
  const ContinueButton({required this.onGameComplete, super.key});

  final void Function(int, int) onGameComplete;

  @override
  Widget build(BuildContext context) {
    final logger = Logger();
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        final isButtonEnabled = state.stars
            .asMap()
            .entries
            .where((entry) => state.correctAnswer[entry.key] != ' ')
            .every(
              (entry) =>
                  entry.value == StarType.gold || entry.value == StarType.green,
            );

        logger
          ..i('Stars: ${state.stars}')
          ..i('Button enabled: $isButtonEnabled');

        return IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: isButtonEnabled
              ? () {
                  logger
                    ..i('Continue button pressed')
                    ..i('Stars: ${state.stars}');
                  onGameComplete(
                    state.stars
                        .where(
                          (star) => star == StarType.gold,
                        )
                        .length,
                    state.stars.where((star) => star == StarType.green).length,
                  );
                }
              : null,
        );
      },
    );
  }
}

class GameStars extends StatelessWidget {
  const GameStars({required this.stars, super.key});
  final int stars;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$stars'),
        const Icon(Icons.star),
      ],
    );
  }
}

class GameBody extends StatelessWidget {
  const GameBody({
    required this.gameInput,
    required this.onGameComplete,
    super.key,
  });
  final GameInput gameInput;
  final void Function(int, int) onGameComplete;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GameImage(image: gameInput.pictogramImage),
          GameQuestion(question: gameInput.question),
          const GameAnswerInputCol(),
          ContinueButton(onGameComplete: onGameComplete),
        ],
      ),
    );
  }
}

class GameImage extends StatelessWidget {
  const GameImage({required this.image, super.key});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(image);
  }
}

class GameQuestion extends StatelessWidget {
  const GameQuestion({required this.question, super.key});
  final String question;

  @override
  Widget build(BuildContext context) {
    return Text(question);
  }
}
