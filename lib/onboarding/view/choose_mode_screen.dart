import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

class ChooseModeScreen extends StatelessWidget {
  const ChooseModeScreen({
    required this.onModeSelected,
    super.key,
  });

  final ValueChanged<AppMode> onModeSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecciona el modo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => onModeSelected(AppMode.teacher),
              child: const Text('Modo Maestro'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => onModeSelected(AppMode.student),
              child: const Text('Modo Estudiante'),
            ),
          ],
        ),
      ),
    );
  }
}
