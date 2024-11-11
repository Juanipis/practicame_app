import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
        return Center(
          child: ElevatedButton(
            onPressed: () {
              _showErrorDialog(context, state, onGameComplete);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              shadowColor: Colors.black.withOpacity(0.2),
              elevation: 8,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Continuar',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: GoogleFonts.comicNeue().fontFamily,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, size: 24),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showErrorDialog(
    BuildContext context,
    GameState state,
    void Function(int, int) onGameComplete,
  ) {
    final incorrectDetails = <String>[];
    final emptyPositions = <int>[];

    // Respuesta correcta sin modificar
    final correctAnswer = state.correctAnswer;

    // Verificar si `state.currentInput` está completamente vacío
    final isCompletelyEmpty =
        state.currentInput.every((input) => input.isEmpty);

    // Reconstruir la respuesta del usuario respetando los espacios
    final userAnswer = List.generate(correctAnswer.length, (i) {
      if (correctAnswer[i] == ' ') {
        return ' '; // Mantén el espacio en la posición correspondiente
      }
      if (i < state.currentInput.length) {
        return state.currentInput[i]; // Accede al índice si existe
      }
      return ''; // Manejar índices fuera de rango
    }).join();

    // Si la entrada está vacía, no procesar errores ni faltantes
    if (!isCompletelyEmpty) {
      for (var i = 0; i < correctAnswer.length; i++) {
        final correctAnswerChar = correctAnswer[i];
        final userAnswerChar = i < state.currentInput.length
            ? state.currentInput[i]
            : ''; // Manejar índices fuera de rango

        if (correctAnswerChar == ' ') {
          continue; // Ignora espacios en la validación
        }

        if (userAnswerChar.isEmpty) {
          emptyPositions.add(i + 1); // Posición legible (1-based index)
        } else if (userAnswerChar.toLowerCase() !=
            correctAnswerChar.toLowerCase()) {
          incorrectDetails.add(
            'Posición ${i + 1}: Ingresaste "$userAnswerChar" pero debería ser "$correctAnswerChar".',
          );
        }
      }
    }

    // Crear el mensaje del diálogo
    final errorMessage = StringBuffer();

    if (isCompletelyEmpty) {
      errorMessage.writeln('No ingresaste ninguna respuesta.');
    } else {
      if (incorrectDetails.isNotEmpty) {
        errorMessage.writeln('Errores encontrados:');
        for (final detail in incorrectDetails) {
          errorMessage.writeln('- $detail');
        }
      }
      if (emptyPositions.isNotEmpty) {
        errorMessage.writeln(
          '\nFaltan letras en las posiciones: ${emptyPositions.join(', ')}.',
        );
      }
    }

    // Resumen final: Respuesta completa del usuario vs respuesta correcta
    errorMessage
      ..writeln('\n--- Resumen ---')
      ..writeln(
        'Tu respuesta: "${isCompletelyEmpty ? '(vacía)' : userAnswer}"',
      )
      ..writeln('Respuesta correcta: "${state.correctAnswer}"');

    // Mostrar el AlertDialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Retroalimentación'),
          content: Text(errorMessage.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                var totalGoldStars = 0;
                var totalGreenStars = 0;

                if (!isCompletelyEmpty) {
                  // Contar las estrellas
                  final goldCount =
                      state.stars.where((star) => star == StarType.gold).length;
                  final greenCount = state.stars
                      .where((star) => star == StarType.green)
                      .length;
                  final redCount =
                      state.stars.where((star) => star == StarType.red).length;
                  final noneCount =
                      state.stars.where((star) => star == StarType.none).length;

                  // Total de estrellas
                  final totalStars =
                      goldCount + greenCount + redCount + noneCount;

                  // Calcular proporciones
                  final goldProportion = goldCount / totalStars;
                  final greenProportion = greenCount / totalStars;

                  // Distribuir las 5 estrellas proporcionalmente
                  totalGoldStars = (5 * goldProportion).floor();
                  totalGreenStars = (5 * greenProportion).floor();

                  // Calcular estrellas faltantes para alcanzar un total de 5
                  final distributedTotal = totalGoldStars + totalGreenStars;
                  final remainingStars = 5 - distributedTotal;

                  // Penalización: No se asignan estrellas adicionales si hay errores o vacíos
                  if (redCount + noneCount > 0) {
                    // Reducir estrellas verdes si hay espacios vacíos o errores
                    totalGreenStars = totalGreenStars > remainingStars
                        ? totalGreenStars - remainingStars
                        : totalGreenStars;
                  }
                }

                onGameComplete(totalGoldStars, totalGreenStars);
              },
              child: const Text('Continuar'),
            ),
          ],
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
