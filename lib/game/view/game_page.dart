import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicame_app/game/cubit/game_cubit.dart';
import 'package:practicame_app/game/model/game_input.dart';
import 'package:practicame_app/game/view/answer_input.dart';
import 'package:practicame_app/game/view/game_eps.dart';
import 'package:practicame_app/game/view/game_helper.dart';

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
    if (gameInput.isEPSGame ?? false) {
      return EpsGameBody(gameInput: gameInput, onGameComplete: onGameComplete);
    }
    return GameBody(gameInput: gameInput, onGameComplete: onGameComplete);
  }
}

class ContinueButton extends StatelessWidget {
  const ContinueButton({required this.onGameComplete, super.key});

  final void Function(int, int) onGameComplete;

  @override
  Widget build(BuildContext context) {
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

        return Center(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: isButtonEnabled
                ? 1.0
                : 0.5, // Transparencia si está deshabilitado
            child: ElevatedButton(
              onPressed: isButtonEnabled
                  ? () {
                      onGameComplete(
                        state.stars
                            .where((star) => star == StarType.gold)
                            .length,
                        state.stars
                            .where((star) => star == StarType.green)
                            .length,
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isButtonEnabled ? Colors.green : Colors.grey,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                shadowColor: Colors.black.withOpacity(0.2),
                elevation: 8,
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Continuar',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 24),
                ],
              ),
            ),
          ),
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
          if (gameInput.gameHelps != null)
            GameHelp(gameHelps: gameInput.gameHelps!),
          const GameAnswerInputCol(),
          const SizedBox(height: 16),
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
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 400,
      ),
      width: double.infinity,
      child: Image.asset(
        image,
        fit: BoxFit.cover,
      ),
    );
  }
}

class GameQuestion extends StatelessWidget {
  const GameQuestion({required this.question, super.key});
  final String question;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleLarge;
    return Text(
      question, style: textStyle, // Usa el estilo del tema
      textAlign: TextAlign.center,
    );
  }
}
