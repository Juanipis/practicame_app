import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:practicame_app/app/app.dart';
import 'package:practicame_app/game/cubit/game_cubit.dart';
import 'package:practicame_app/game/model/game_input.dart';
import 'package:practicame_app/game/view/answer_input.dart';

class GamePage extends StatelessWidget {
  const GamePage({required this.gameInput, super.key});
  final GameInput gameInput;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GameCubit(gameInput.answer),
      child: const GameView(),
    );
  }
}

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: const [
          GameStars(
            stars: 10,
          ),
        ],
      ),
      body: GameBody(gameInput: gameInput),
      floatingActionButton: ContinueButton(),
    );
  }
}

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final logger = Logger();
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        // Ignore spaces when determining if all stars are gold or green
        final isButtonEnabled = state.stars
            .asMap()
            .entries
            .where((entry) => state.correctAnswer[entry.key] != ' ')
            .every((entry) =>
                entry.value == StarType.gold || entry.value == StarType.green);

        // Log the state of the stars and button
        logger.i('Stars: ${state.stars}');
        logger.i('Button enabled: $isButtonEnabled');

        return IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: isButtonEnabled
              ? () {
                  logger.i('Continue button pressed');
                  // Navigate to the next page
                }
              : null,
        );
      },
    );
  }
}

class GameStars extends StatelessWidget {
  const GameStars({
    required this.stars,
    super.key,
  });
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
  const GameBody({required this.gameInput, super.key});
  final GameInput gameInput;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GameImage(image: gameInput.pictogramImage),
          GameQuestion(question: gameInput.question),
          const GameAnswerInputCol(),
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
