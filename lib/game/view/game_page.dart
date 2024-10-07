import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicame_app/app/app.dart';
import 'package:practicame_app/game/cubit/game_cubit.dart';
import 'package:practicame_app/game/model/game_input.dart';

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

class GameAnswerInputCol extends StatefulWidget {
  const GameAnswerInputCol({super.key});

  @override
  _GameAnswerInputColState createState() => _GameAnswerInputColState();
}

class _GameAnswerInputColState extends State<GameAnswerInputCol> {
  // Lista de controladores para cada letra
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  // Inicializar controladores basados en la longitud de la respuesta correcta
  void _initializeControllers() {
    final correctAnswer = context.read<GameCubit>().state.correctAnswer;
    _controllers =
        List.generate(correctAnswer.length, (_) => TextEditingController());
  }

  @override
  void dispose() {
    // Liberar los controladores cuando el widget sea destruido
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        final words = state.correctAnswer.split(' ');
        var globalIndex = 0; // Índice global para recorrer todas las letras

        return Column(
          children: words.map((word) {
            // Construimos la fila de texto para cada palabra
            final row = Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: word.characters.map((letter) {
                final currentIndex = globalIndex;
                globalIndex++; // Aumentamos el índice global después de cada letra

                return SizedBox(
                  width: 50,
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: _controllers[currentIndex],
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: state.stars[currentIndex]
                          ? Colors.green.shade100
                          : Colors.red.shade100,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                    ),
                    maxLength: 1,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        // Actualizar la letra en el cubit
                        context
                            .read<GameCubit>()
                            .updateLetter(currentIndex, value);

                        // Mover el foco al siguiente campo si se ingresa un carácter
                        FocusScope.of(context).nextFocus();
                      } else {
                        // Mover el foco al campo anterior si se borra un carácter
                        context
                            .read<GameCubit>()
                            .updateLetter(currentIndex, '');

                        FocusScope.of(context).previousFocus();
                      }
                    },
                    style: const TextStyle(fontSize: 24),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                );
              }).toList(), // Termina el mapeo de las letras
            );

            globalIndex++; // Incrementar para contar el espacio entre palabras
            return row;
          }).toList(), // Termina el mapeo de las palabras
        );
      },
    );
  }
}

class GameAnswerInput extends StatelessWidget {
  const GameAnswerInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        // Dividir la respuesta en palabras
        final words = state.correctAnswer.split(' ');

        return Wrap(
          alignment: WrapAlignment.center,
          spacing: 8, // Espacio horizontal entre cuadros
          runSpacing: 8, // Espacio vertical si se distribuyen en varias líneas
          children: [
            for (int wordIndex = 0; wordIndex < words.length; wordIndex++) ...[
              for (int letterIndex = 0;
                  letterIndex < words[wordIndex].length;
                  letterIndex++)
                SizedBox(
                  width: 50, // Ancho fijo para cada cuadro de texto
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: state.stars[letterIndex]
                          ? Colors.green.shade100
                          : Colors.red.shade100,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                    maxLength: 1, // Solo un carácter por cuadro
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        context
                            .read<GameCubit>()
                            .updateLetter(letterIndex, value);
                        FocusScope.of(context)
                            .nextFocus(); // Mover al siguiente campo automáticamente
                      }
                    },
                    style: const TextStyle(fontSize: 24),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                ),
              if (wordIndex < words.length - 1)
                const SizedBox(
                  width: 20, // Esto solo agrega espacio visual entre palabras
                ),
            ],
          ],
        );
      },
    );
  }
}
