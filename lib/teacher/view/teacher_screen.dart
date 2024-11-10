import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicame_app/home/view/home_page.dart';
import 'package:practicame_app/onboarding/view/onboarding_screen.dart';
import 'package:practicame_app/teacher/cubit/teacher_cubit.dart';
import 'package:user_repository/user_repository.dart';

class TeacherScreen extends StatelessWidget {
  const TeacherScreen({required this.userRepository, super.key});

  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TeacherCubit(userRepository)..loadStudents(),
      child: TeacherView(userRepository: userRepository),
    );
  }
}

class TeacherView extends StatelessWidget {
  const TeacherView({required this.userRepository, super.key});

  final UserRepository userRepository;

  Future<void> _navigateToHome(BuildContext context, int studentId) async {
    final teacherCubit = context.read<TeacherCubit>();
    await teacherCubit.setActiveStudent(studentId);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<HomeScreen>(
        builder: (_) => HomeScreen(userRepository: userRepository),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final teacherCubit = context.read<TeacherCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hola maestro, añada sus estudiantes',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: BlocBuilder<TeacherCubit, TeacherState>(
        builder: (context, state) {
          if (state is TeacherLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TeacherLoaded) {
            if (state.students.isEmpty) {
              return const Center(
                child: Text(
                  'Aún no has añadido estudiantes. Usa el botón "+" para comenzar.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            return ListView.builder(
              itemCount: state.students.length,
              itemBuilder: (context, index) {
                final student = state.students[index];
                return Card(
                  child: ListTile(
                    title: Text(
                      student.name,
                      style: const TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(
                      'ID: ${student.id}\n'
                      'Estrellas Doradas: ${student.goldStars} 🌟 | Verdes: ${student.greenStars} 🌟',
                      style: const TextStyle(fontSize: 14),
                    ),
                    onTap: () => _navigateToHome(context, student.id),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        final result =
                            await Navigator.of(context).push<UserModel?>(
                          MaterialPageRoute<UserModel>(
                            builder: (_) => OnboardingScreen(
                              isTeacherMode: true,
                              onProfileCompleted: (updatedStudent) {
                                teacherCubit.updateStudent(updatedStudent);
                                Navigator.of(context).pop(updatedStudent);
                              },
                              initialStudent: student,
                            ),
                          ),
                        );
                        if (result != null) {
                          await teacherCubit.loadStudents();
                        }
                      },
                    ),
                  ),
                );
              },
            );
          } else if (state is TeacherError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).push<UserModel?>(
            MaterialPageRoute<UserModel>(
              builder: (_) => OnboardingScreen(
                isTeacherMode: true,
                onProfileCompleted: (student) {
                  teacherCubit.addStudent(student);
                  Navigator.of(context).pop(student);
                },
              ),
            ),
          );
          if (result != null) {
            await teacherCubit.loadStudents();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
