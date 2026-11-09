import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicame_app/app/view/app_theme.dart';
import 'package:practicame_app/home/view/home_page.dart';
import 'package:practicame_app/l10n/l10n.dart';
import 'package:practicame_app/onboarding/cubit/onboarding_cubit.dart';
import 'package:practicame_app/onboarding/view/choose_mode_screen.dart';
import 'package:practicame_app/onboarding/view/onboarding_screen.dart';
import 'package:practicame_app/teacher/view/teacher_screen.dart';
import 'package:user_repository/user_repository.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

class App extends StatelessWidget {
  const App({required this.userRepository, super.key});

  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(userRepository)..initializeAppMode(),
      child: MaterialApp(
        theme: AppTheme.appTheme(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        navigatorObservers: <NavigatorObserver>[routeObserver],
        home: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            if (state is OnboardingInitial) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (state is OnboardingChooseMode) {
              return ChooseModeScreen(
                onModeSelected: (mode) {
                  context.read<OnboardingCubit>().selectAppMode(mode);
                },
              );
            } else if (state is OnboardingTeacherMode) {
              return TeacherScreen(userRepository: userRepository);
            } else if (state is OnboardingStudentMode) {
              return OnboardingScreen(
                isTeacherMode: false,
                onProfileCompleted: (user) {
                  context.read<OnboardingCubit>().completeStudentProfile(user);
                },
              );
            } else if (state is OnboardingCompleted) {
              return HomeScreen(userRepository: userRepository);
            } else {
              return const Scaffold(
                body: Center(child: Text('Estado desconocido')),
              );
            }
          },
        ),
      ),
    );
  }
}
