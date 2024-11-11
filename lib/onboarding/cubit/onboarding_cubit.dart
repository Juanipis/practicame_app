import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(this._userRepository) : super(OnboardingInitial());

  final UserRepository _userRepository;

  /// Inicializa el estado del modo de la aplicación.
  Future<void> initializeAppMode() async {
    final isFirstTime = await _userRepository.isFirstTime();
    if (isFirstTime) {
      emit(OnboardingChooseMode());
    } else {
      final mode = await _userRepository.getAppMode(); // Usa await aquí
      if (mode == AppMode.teacher) {
        emit(OnboardingTeacherMode());
      } else if (mode == AppMode.student) {
        final user = await _userRepository.getStudentProfile();
        if (user != null && user.isOnboardingComplete) {
          emit(OnboardingCompleted());
        } else {
          emit(OnboardingStudentMode());
        }
      }
    }
  }

  /// Selecciona el modo de la aplicación.
  Future<void> selectAppMode(AppMode mode) async {
    await _userRepository.setAppMode(mode);
    if (mode == AppMode.teacher) {
      emit(OnboardingTeacherMode());
    } else if (mode == AppMode.student) {
      final user = await _userRepository.getStudentProfile();
      if (user != null && user.isOnboardingComplete) {
        emit(OnboardingCompleted());
      } else {
        emit(OnboardingStudentMode());
      }
    }
  }

  /// Añade un estudiante en modo maestro.
  Future<void> addStudent(UserModel user) async {
    await _userRepository.addUser(user);
    emit(OnboardingStudentAdded());
  }

  /// Completa el perfil del estudiante en modo estudiante.
  Future<void> completeStudentProfile(UserModel user) async {
    await _userRepository.updateUser(user);
    await _userRepository.setActiveUser(user.id); // Marca como activo.
    emit(OnboardingCompleted());
  }

  /// Selecciona un estudiante activo en modo maestro.
  Future<void> selectStudent(int userId) async {
    await _userRepository.setActiveUser(userId);
    final selectedStudent = await _userRepository.getSelectedStudent();
    if (selectedStudent != null) {
      emit(OnboardingStudentSelected(selectedStudent));
    }
  }

  /// Limpia todos los usuarios y restablece el estado inicial.
  Future<void> resetApp() async {
    await _userRepository.clearAllUsers();
    emit(OnboardingInitial());
  }
}

/// Estados del cubit para manejar diferentes flujos de Onboarding.
abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingChooseMode extends OnboardingState {}

class OnboardingTeacherMode extends OnboardingState {}

class OnboardingStudentMode extends OnboardingState {}

class OnboardingCompleted extends OnboardingState {}

class OnboardingStudentAdded extends OnboardingState {}

class OnboardingStudentSelected extends OnboardingState {
  OnboardingStudentSelected(this.selectedStudent);

  final UserModel selectedStudent;
}
