import 'package:practicame_app/game/model/game_help.dart';
import 'package:user_repository/user_repository.dart';

class GameInput {
  GameInput({
    required this.id,
    required this.gameName,
    required this.question,
    required this.answer,
    required this.pictogramImage,
    required this.userAttribute,
    this.gameHelps,
  });

  final int id;
  final String gameName;
  final String question;
  String answer;
  final String pictogramImage;
  final UserAttributes userAttribute;
  final GameHelps? gameHelps;

  GameInput copyWith({String? answer, GameHelps? gameHelps}) {
    return GameInput(
      id: id,
      gameName: gameName,
      question: question,
      answer: answer ?? this.answer,
      pictogramImage: pictogramImage,
      userAttribute: userAttribute,
      gameHelps: gameHelps ?? this.gameHelps,
    );
  }

  String getUserAttributeValue(UserModel user) {
    switch (userAttribute) {
      case UserAttributes.name:
        return user.name;
      case UserAttributes.lastName:
        return user.lastName;
      case UserAttributes.fullName:
        return user.fullName;
      case UserAttributes.document:
        return user.document;
      case UserAttributes.birthDate:
        return user.birthDate.toIso8601String(); // Convierte DateTime a String
      case UserAttributes.age:
        return user.age.toString();
      case UserAttributes.eps:
        return user.eps;
      case UserAttributes.bloodType:
        return user.bloodType;
      case UserAttributes.city:
        return user.city;
      case UserAttributes.address:
        return user.address;
      case UserAttributes.neighborhood:
        return user.neighborhood;
      case UserAttributes.phone:
        return user.phone;
      case UserAttributes.emergencyContactName:
        return user.emergencyContactName;
      case UserAttributes.emergencyContactPhone:
        return user.emergencyContactPhone;
    }
  }
}
