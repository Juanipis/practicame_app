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

GameInput game102 = GameInput(
  id: 102,
  gameName: 'Write the NUIP (Número Único de Identificación Personal)',
  question: '¿Cuál es tu número de documento de identidad (NUIP)?',
  answer: '',
  pictogramImage: 'assets/pictograms/nuip.png',
  userAttribute: UserAttributes.document,
);
GameInput game103 = GameInput(
  id: 103,
  gameName: 'Write the birth date',
  question: '¿Cuál es tu fecha de nacimiento?',
  answer: '',
  pictogramImage: 'assets/pictograms/birth_date.png',
  userAttribute: UserAttributes.birthDate,
);

GameInput game104 = GameInput(
  id: 104,
  gameName: 'Write the age',
  question: '¿Cuántos años tienes?',
  answer: '',
  pictogramImage: 'assets/pictograms/age.png',
  userAttribute: UserAttributes.age,
);

GameInput game105 = GameInput(
  id: 104,
  gameName: 'Write the blood type and RH factor',
  question: '¿Cuál es tu tipo de sangre y factor RH?',
  answer: '',
  pictogramImage: 'assets/pictograms/blood_type.png',
  userAttribute: UserAttributes.bloodType,
);

GameInput game106 = GameInput(
  id: 106,
  gameName: 'Choose your EPS',
  question: '¿A qué EPS perteneces?',
  answer: '',
  pictogramImage: '',
  userAttribute: UserAttributes.eps,
  isEPSGame: true,
);

GameInput game107 = GameInput(
  id: 107,
  gameName: 'Write the municipality name',
  question: '¿Cuál es el nombre de tu municipio?',
  answer: '',
  pictogramImage: 'assets/pictograms/municipality.png',
  userAttribute: UserAttributes.municipality,
);

GameInput game108 = GameInput(
  id: 108,
  gameName: 'Write your address',
  question: '¿Cuál es la dirección de tu casa?',
  answer: '',
  pictogramImage: 'assets/pictograms/address.png',
  userAttribute: UserAttributes.address,
);

GameInput game109 = GameInput(
  id: 109,
  gameName: 'Write the neighborhood name',
  question: '¿Cuál es el nombre de tu barrio?',
  answer: '',
  pictogramImage: 'assets/pictograms/neighborhood.png',
  userAttribute: UserAttributes.neighborhood,
);

GameInput game110 = GameInput(
  id: 110,
  gameName: 'Write the phone number',
  question: '¿Cuál es tu número de teléfono?',
  answer: '',
  pictogramImage: 'assets/pictograms/phone_number.png',
  userAttribute: UserAttributes.phone,
);

GameInput game111 = GameInput(
  id: 111,
  gameName: 'Write your emergency contact name',
  question: '¿Cuál es el nombre de tu contacto de emergencia?',
  answer: '',
  pictogramImage: 'assets/pictograms/emergency_contact_name.png',
  userAttribute: UserAttributes.emergencyContactName,
);

GameInput game112 = GameInput(
  id: 112,
  gameName: 'Write your emergency contact phone number',
  question: '¿Cuál es el número de teléfono de tu contacto de emergencia?',
  answer: '',
  pictogramImage: 'assets/pictograms/emergency_number.png',
  userAttribute: UserAttributes.emergencyContactPhone,
);

List<GameInput> advancedGames = [
  game101,
  game102,
  game103,
  game104,
  game105,
  game106,
  game107,
  game108,
  game109,
  game110,
  game111,
  game112,
];
