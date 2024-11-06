import 'package:practicame_app/game/model/game_help.dart';
import 'package:practicame_app/game/model/game_input.dart';
import 'package:user_repository/user_repository.dart';

GameHelps gameHelps0 = GameHelps(
  text:
      'Es el nombre que te pusieron tus padres, por ejemplo: Juan, María, etc.',
  images: [
    'assets/visual_helps/first_name.webp',
    'assets/visual_helps/first_name2.jpg',
  ],
  audios: ['sounds/first_name.wav'],
);

GameInput game0 = GameInput(
  id: 0,
  gameName: 'Write the name',
  question: '¿Cuál es tu nombre?',
  answer: '',
  pictogramImage: 'assets/pictograms/name.png',
  userAttribute: UserAttributes.name,
  gameHelps: gameHelps0,
);

GameInput game1 = GameInput(
  id: 1,
  gameName: 'Write the age',
  question: '¿Cuántos años tienes?',
  answer: '',
  pictogramImage: 'assets/pictograms/age.png',
  userAttribute: UserAttributes.age,
);

GameInput game2 = GameInput(
  id: 2,
  gameName: 'Choose your EPS',
  question: '¿A qué EPS perteneces?',
  answer: '',
  pictogramImage: '',
  userAttribute: UserAttributes.eps,
  isEPSGame: true,
);

List<GameInput> starterGames = [game2, game0, game1];
