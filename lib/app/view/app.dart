import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practicame_app/home/view/home_page.dart';
import 'package:practicame_app/l10n/l10n.dart';
import 'package:practicame_app/onboarding/cubit/onboarding_cubit.dart';
import 'package:practicame_app/onboarding/view/onboarding_page.dart';
import 'package:user_repository/user_repository.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

class App extends StatelessWidget {
  const App({required this.userRepository, super.key});

  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OnboardingCubit(userRepository)..checkOnboardingStatus(),
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.chewyTextTheme(),
          appBarTheme: const AppBarTheme(
            backgroundColor:
                Colors.white, //Theme.of(context).colorScheme.inversePrimary,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, // Color de fondo
              foregroundColor: Colors.black, // Color de texto
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(width: 2),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            ),
          ),
          useMaterial3: true,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        navigatorObservers: <NavigatorObserver>[routeObserver],
        home: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            if (state is OnboardingNotCompleted) {
              return const OnboardingScreen();
            } else if (state is OnboardingCompleted) {
              return HomeScreen(
                userRepository: userRepository,
              );
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
