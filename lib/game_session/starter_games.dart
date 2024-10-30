import 'package:practicame_app/game/model/game_input.dart';
import 'package:user_repository/user_repository.dart';

GameInput game0 = GameInput(
  id: 0,
  gameName: 'Write the name',
  question: '¿Cuál es tu nombre?',
  answer: '',
  pictogramImage: 'assets/pictograms/name.png',
  userAttribute: UserAttributes.name,
);

GameInput game1 = GameInput(
  id: 1,
  gameName: 'Write the age',
  question: '¿Cuántos años tienes?',
  answer: '',
  pictogramImage: 'assets/pictograms/age.png',
  userAttribute: UserAttributes.age,
);

List<GameInput> starterGames = [game0, game1];
