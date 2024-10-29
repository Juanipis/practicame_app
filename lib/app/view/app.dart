import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicame_app/game/model/game_input.dart';
import 'package:practicame_app/game_session/view/game_session_page.dart';
import 'package:practicame_app/home/view/home_page.dart';
import 'package:practicame_app/l10n/l10n.dart';
import 'package:practicame_app/onboarding/cubit/onboarding_cubit.dart';
import 'package:practicame_app/onboarding/view/onboarding_page.dart';

GameInput gameInput = GameInput(
  id: 0,
  gameName: 'Write the name',
  question: '¿Cuál es tu nombre?',
  answer: 'Juan Pablo',
  pictogramImage: 'assets/pictograms/name.png',
);

GameInput gameInput2 = GameInput(
  id: 1,
  gameName: 'Write the age',
  question: '¿Cuántos años tienes?',
  answer: '25',
  pictogramImage: 'assets/pictograms/age.png',
);

List<GameInput> games = [gameInput, gameInput2];

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit()..checkOnboardingStatus(),
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          useMaterial3: true,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            if (state is OnboardingNotCompleted) {
              return OnboardingScreen();
            } else if (state is OnboardingCompleted) {
              return const HomeScreen();
            } else {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
          },
        ),
      ),
    );
  }
}
