import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicame_app/home/view/home_page.dart';
import 'package:practicame_app/l10n/l10n.dart';
import 'package:practicame_app/onboarding/cubit/onboarding_cubit.dart';
import 'package:practicame_app/onboarding/view/onboarding_page.dart';
import 'package:user_repository/user_repository.dart';
import 'package:google_fonts/google_fonts.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final userRepository = UserRepository();

    return BlocProvider(
      create: (context) =>
          OnboardingCubit(userRepository)..checkOnboardingStatus(),
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.chewyTextTheme(),
          appBarTheme: const AppBarTheme(
              backgroundColor:
                  Colors.white //Theme.of(context).colorScheme.inversePrimary,
              ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, // Color de fondo
              foregroundColor: Colors.black, // Color de texto
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.black, width: 2)),
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
