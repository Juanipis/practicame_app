import 'package:flutter/material.dart';
import 'package:practicame_app/app/app.dart';
import 'package:practicame_app/bootstrap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final userRepository = await UserRepository.init();

  await bootstrap(() => App(userRepository: userRepository));
}
