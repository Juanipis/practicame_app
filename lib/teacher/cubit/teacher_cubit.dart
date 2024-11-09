import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class TeacherCubit extends Cubit<TeacherState> {
  TeacherCubit(this.userRepository) : super(TeacherInitial());

  final UserRepository userRepository;

  Future<void> loadStudents() async {
    emit(TeacherLoading());
    try {
      final students = await userRepository.getAllUsers();
      emit(TeacherLoaded(students));
    } catch (e) {
      emit(TeacherError(e.toString()));
    }
  }

  Future<void> addStudent(UserModel student) async {
    try {
      await userRepository.addUser(student);
      await loadStudents();
    } catch (e) {
      emit(TeacherError(e.toString()));
    }
  }

  Future<void> setActiveStudent(int studentId) async {
    try {
      await userRepository.setActiveUser(studentId);
    } catch (e) {
      emit(TeacherError(e.toString()));
    }
  }
}

abstract class TeacherState {}

class TeacherInitial extends TeacherState {}

class TeacherLoading extends TeacherState {}

class TeacherLoaded extends TeacherState {
  TeacherLoaded(this.students);

  final List<UserModel> students;
}

class TeacherError extends TeacherState {
  TeacherError(this.message);

  final String message;
}
