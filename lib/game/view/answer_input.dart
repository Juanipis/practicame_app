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
        var globalIndex = 0; // Índice global para recorrer todas las letras

        return Column(
          children: words.map((word) {
            // Construimos la fila de texto para cada palabra
            final row = Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: word.characters.map((letter) {
                final currentIndex = globalIndex;
                globalIndex++; // Aumentamos el índice global después de cada letra
                return KeyboardListener(
                  focusNode: FocusNode(canRequestFocus: false),
                  onKeyEvent: (value) {
                    // if the textfield is empty and the backspace key is pressed
                    // move the focus to the previous textfield
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
                        // Mostrar la estrella correcta basada en el tipo de estrella
                        if (state.stars[currentIndex] == StarType.gold) {
                          return const Center(
                            child: Icon(
                              Icons.star,
                              color: Colors.yellow, // Dorada
                            ),
                          );
                        } else if (state.stars[currentIndex] ==
                            StarType.green) {
                          return const Center(
                            child: Icon(
                              Icons.star,
                              color: Colors.green, // Verde
                            ),
                          );
                        } else if (state.stars[currentIndex] == StarType.red) {
                          return const Center(
                            child: Icon(
                              Icons.star,
                              color: Colors.red, // Roja
                            ),
                          );
                        } else {
                          return const Center(
                            child: Icon(
                              Icons.star,
                              color: Colors.grey, // Sin acierto
                            ),
                          );
                        }
                      },
                      onChanged: (value) {
                        // Asegurarnos de que solo haya 1 letra en el campo
                        if (value.isNotEmpty) {
                          // Solo tomamos el último carácter ingresado
                          final newValue = value.substring(value.length - 1);
                          _controllers[currentIndex].text = newValue;

                          // Actualizar la letra en el cubit
                          context
                              .read<GameCubit>()
                              .updateLetter(currentIndex, newValue);

                          // Mover el foco al siguiente campo si se ingresa un carácter
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: const TextStyle(fontSize: 24),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
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
