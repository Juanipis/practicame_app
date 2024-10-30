import 'package:practicame_app/game/model/game_input.dart';
import 'package:user_repository/user_repository.dart';

GameInput game101 = GameInput(
  id: 101,
  gameName: 'Write the full name',
  question: '¿Cuál es tu nombre completo?',
  answer: '',
  pictogramImage: 'assets/pictograms/full_name.png',
  userAttribute: UserAttributes.fullName,
);

GameInput game109 = GameInput(
  id: 109,
  gameName: 'Write the neighborhood name',
  question: '¿Cuál es el nombre de tu barrio?',
  answer: '',
  pictogramImage: 'assets/pictograms/neighborhood.png',
  userAttribute: UserAttributes.neighborhood,
);

List<GameInput> advancedGames = [game101, game109];
