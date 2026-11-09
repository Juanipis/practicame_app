import 'package:flutter/widgets.dart';
import 'package:practicame_app/app/app.dart';
import 'package:practicame_app/bootstrap.dart';
import 'package:user_repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final userRepository = await UserRepository.init();

  // Arrancamos la aplicación pasando userRepository como parámetro.
  await bootstrap(() => App(userRepository: userRepository));
}
