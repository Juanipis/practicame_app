import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicame_app/onboarding/cubit/onboarding_cubit.dart';
import 'package:user_repository/user_repository.dart';

class SelectModeScreen extends StatelessWidget {
  const SelectModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seleccionar Modo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<OnboardingCubit>().selectAppMode(AppMode.teacher);
              },
              child: const Text('Modo Maestro'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<OnboardingCubit>().selectAppMode(AppMode.student);
              },
              child: const Text('Modo Estudiante'),
            ),
          ],
        ),
      ),
    );
  }
}
