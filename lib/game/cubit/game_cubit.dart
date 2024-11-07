import 'package:bloc/bloc.dart';

enum StarType { none, gold, green, red }

class GameCubit extends Cubit<GameState> {
  GameCubit(String correctAnswer)
      : super(
          GameState(
            correctAnswer: correctAnswer,
            currentInput: List.filled(correctAnswer.length, ''),
            stars: List.filled(correctAnswer.length, StarType.none),
          ),
        );

  void updateLetter(int index, String letter) {
    if (letter.isEmpty || state.correctAnswer[index] == ' ') {
      return; // Skip spaces
    }

    final updatedInput = List<String>.from(state.currentInput);
    updatedInput[index] = letter;

    final updatedStars = List<StarType>.from(state.stars);

    final correctLetter = state.correctAnswer[index].toLowerCase();
    final inputLetter = letter.toLowerCase();

    if (inputLetter == correctLetter) {
      if (state.stars[index] == StarType.none) {
        updatedStars[index] = StarType.gold;
      } else if (state.stars[index] == StarType.red) {
        updatedStars[index] = StarType.green;
      }
    } else {
      updatedStars[index] = StarType.red;
    }

    emit(state.copyWith(currentInput: updatedInput, stars: updatedStars));
  }
}

class GameState {
  GameState({
    required this.correctAnswer,
    required this.currentInput,
    required this.stars,
  });

  final String correctAnswer; // Respuesta correcta
  final List<String> currentInput; // Letras ingresadas por el usuario
  final List<StarType>
      stars; // Lista de estrellas (dorada, verde, roja, ninguna)

  // Método para copiar el estado actual y modificar solo los campos necesarios
  GameState copyWith({
    String? correctAnswer,
    List<String>? currentInput,
    List<StarType>? stars,
  }) {
    return GameState(
      correctAnswer: correctAnswer ?? this.correctAnswer,
      currentInput: currentInput ?? this.currentInput,
      stars: stars ?? this.stars,
    );
  }
}
