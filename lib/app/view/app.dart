import 'package:flutter/material.dart';
import 'package:practicame_app/app/app.dart';
import 'package:practicame_app/game/game.dart';
import 'package:practicame_app/game/model/game_input.dart';
import 'package:practicame_app/l10n/l10n.dart';

GameInput gameInput = GameInput(
  id: 0,
  gameName: 'Write the name',
  question: '¿Cuál es tu nombre?',
  answer: 'Juan Pablo',
  pictogramImage: 'assets/pictograms/name.png',
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: GamePage(
        gameInput: gameInput,
      ),
    );
  }
}
