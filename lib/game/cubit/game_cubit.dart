import 'package:bloc/bloc.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit(String correctAnswer)
      : super(
          GameState(
            correctAnswer: correctAnswer,
            currentInput: List.filled(
              correctAnswer.length,
              '',
            ), // Lista vacía para las letras ingresadas
            stars: List.filled(
              correctAnswer.length,
              false,
            ), // Falsos inicialmente, indicando que ninguna letra es correcta
          ),
        );

  // Actualiza la letra ingresada en la posición correcta
  void updateLetter(int index, String letter) {
    // Verificar que la entrada sea válida
    if (letter.isEmpty) return;

    final updatedInput = List<String>.from(
        state.currentInput); // Crear una copia de la lista actual
    updatedInput[index] =
        letter; // Actualizar la letra en la posición correspondiente

    final updatedStars = List<bool>.from(
        state.stars); // Crear una copia del estado de las estrellas

    // Verificamos si la letra ingresada es correcta (comparando ignorando mayúsculas)
    final correctLetter = state.correctAnswer[index].toLowerCase();
    final inputLetter = letter.toLowerCase();

    if (inputLetter == correctLetter) {
      print('La letra es correcta: $inputLetter en la posición $index');
      updatedStars[index] =
          true; // Si es correcta, actualizamos la estrella a true (verde)
    } else {
      print('La letra es incorrecta: $inputLetter en la posición $index');
      updatedStars[index] =
          false; // Si es incorrecta, la estrella es false (rojo)
    }

    // Emitir el nuevo estado con el input y las estrellas actualizadas
    emit(state.copyWith(currentInput: updatedInput, stars: updatedStars));
  }

  // Resetea el estado del juego
  void reset() {
    emit(
      GameState(
        correctAnswer: state.correctAnswer,
        currentInput: List.filled(
          state.correctAnswer.length,
          '',
        ), // Volver a un input vacío
        stars: List.filled(
          state.correctAnswer.length,
          false,
        ), // Reseteamos las estrellas
      ),
    );
  }
}

class GameState {
  // Estado de las estrellas (correcto o incorrecto para cada letra)
  GameState({
    required this.correctAnswer,
    required this.currentInput,
    required this.stars,
  });

  final String correctAnswer; // Respuesta correcta
  final List<String> currentInput; // Letras ingresadas por el usuario
  final List<bool>
      stars; // Lista de booleanos que indican si cada letra es correcta

  // Método para copiar el estado actual y modificar solo los campos necesarios
  GameState copyWith({
    String? correctAnswer,
    List<String>? currentInput,
    List<bool>? stars,
  }) {
    return GameState(
      correctAnswer: correctAnswer ?? this.correctAnswer,
      currentInput: currentInput ?? this.currentInput,
      stars: stars ?? this.stars,
    );
  }
}
