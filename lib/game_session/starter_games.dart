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
// ------------------------------------------------------------------- //
GameHelps gameHelps1 = GameHelps(
  text:
      'Es el número que aparece en tu cédula de ciudadanía, normalente empieza por 1',
  images: [
    'assets/visual_helps/nuip1.png',
    'assets/visual_helps/nuip2.jpeg',
    'assets/visual_helps/nuip3.webp',
  ],
  audios: ['sounds/nuip.wav'],
);
GameInput game1 = GameInput(
  id: 1,
  gameName: 'Write the NUIP (Número Único de Identificación Personal)',
  question: '¿Cuál es tu número de documento de identidad (NUIP)?',
  answer: '',
  pictogramImage: 'assets/pictograms/nuip.png',
  userAttribute: UserAttributes.document,
  gameHelps: gameHelps1,
);
// ------------------------------------------------------------------- //
GameHelps gameHelps2 = GameHelps(
  text: 'Es la fecha en la que naciste, por ejemplo: 12 de diciembre de 2000',
  images: [
    'assets/visual_helps/birth_date1.png',
    'assets/visual_helps/birth_date2.webp',
  ],
  audios: ['sounds/birth_date.wav'],
);
GameInput game2 = GameInput(
  id: 2,
  gameName: 'Write the birth date',
  question: '¿Cuál es tu fecha de nacimiento?',
  answer: '',
  pictogramImage: 'assets/pictograms/birth_date.png',
  userAttribute: UserAttributes.birthDate,
  gameHelps: gameHelps2,
);
// ------------------------------------------------------------------- //
GameHelps gameHelps3 = GameHelps(
  text: 'Es el número de años que tienes, por ejemplo: 20, 30, 40, etc.',
  images: [
    'assets/visual_helps/age1.webp',
    'assets/visual_helps/age2.webp',
  ],
  audios: ['sounds/age.wav'],
);
GameInput game3 = GameInput(
  id: 3,
  gameName: 'Write the age',
  question: '¿Cuántos años tienes?',
  answer: '',
  pictogramImage: 'assets/pictograms/age.png',
  userAttribute: UserAttributes.age,
  gameHelps: gameHelps3,
);
// ------------------------------------------------------------------- //
GameHelps gameHelps4 = GameHelps(
  text:
      'Es la entidad prestadora de salud a la que perteneces, por ejemplo: Sura, Coomeva, etc.',
  images: [
    'assets/visual_helps/eps1.webp',
    'assets/visual_helps/eps2.webp',
  ],
  audios: ['sounds/eps.wav'],
);
GameInput game4 = GameInput(
  id: 4,
  gameName: 'Choose your EPS',
  question: '¿A qué EPS perteneces?',
  answer: '',
  pictogramImage: '',
  userAttribute: UserAttributes.eps,
  isEPSGame: true,
  gameHelps: gameHelps4,
);

// ------------------------------------------------------------------- //
List<GameInput> starterGames = [game0, game1, game2, game3, game4];
