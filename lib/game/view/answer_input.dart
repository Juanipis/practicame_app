import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicame_app/game/cubit/game_cubit.dart';

class GameAnswerInputCol extends StatefulWidget {
  const GameAnswerInputCol({super.key});

  @override
  State<GameAnswerInputCol> createState() => _GameAnswerInputColState();
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
        var globalIndex = 0;

        return Column(
          children: words.map((word) {
            final row = Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: word.characters.map((letter) {
                final currentIndex = globalIndex;
                globalIndex++; // Increment the global index for each letter

                if (letter == ' ') {
                  globalIndex++; // Skip the space in globalIndex
                  return const SizedBox(
                    width: 10,
                  ); // Add spacing for visual separation
                }

                return KeyboardListener(
                  focusNode: FocusNode(canRequestFocus: false),
                  onKeyEvent: (value) {
                    if (value.logicalKey == LogicalKeyboardKey.backspace &&
                        _controllers[currentIndex].text.isEmpty) {
                      FocusScope.of(context).previousFocus();
                    }
                  },
                  child: SizedBox(
                    width: 50,
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: _controllers[currentIndex],
                      maxLength: 2,
                      buildCounter: (
                        context, {
                        required currentLength,
                        required isFocused,
                        required maxLength,
                      }) {
                        // Display the appropriate star based on its type
                        if (state.stars[currentIndex] == StarType.gold) {
                          return const Center(
                            child: Icon(Icons.star, color: Colors.yellow),
                          );
                        } else if (state.stars[currentIndex] ==
                            StarType.green) {
                          return const Center(
                            child: Icon(Icons.star, color: Colors.green),
                          );
                        } else if (state.stars[currentIndex] == StarType.red) {
                          return const Center(
                            child: Icon(Icons.star, color: Colors.red),
                          );
                        } else {
                          return const Center(
                            child: Icon(Icons.star, color: Colors.grey),
                          );
                        }
                      },
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          final newValue = value.substring(value.length - 1);
                          _controllers[currentIndex].text = newValue;
                          context
                              .read<GameCubit>()
                              .updateLetter(currentIndex, newValue);
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: const TextStyle(fontSize: 24),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                );
              }).toList(),
            );
            globalIndex++; // Skip index for space between words
            return row;
          }).toList(),
        );
      },
    );
  }
}
