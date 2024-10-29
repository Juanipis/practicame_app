import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(this._userRepository) : super(OnboardingInitial());
  final UserRepository _userRepository;

  Future<void> checkOnboardingStatus() async {
    final isComplete = await _userRepository.isOnboardingComplete();
    if (isComplete) {
      emit(OnboardingCompleted());
    } else {
      emit(OnboardingNotCompleted());
    }
  }

  Future<void> completeOnboarding(UserModel user) async {
    await _userRepository.saveUser(user);
    emit(OnboardingCompleted());
  }

  Future<void> updateUserField(String field, dynamic value) async {
    await _userRepository.updateUserField(field, value);
  }

  Future<void> saveUserData({required UserModel userModel}) async {
    await _userRepository.saveUser(userModel);
    emit(OnboardingCompleted());
  }
}

abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingNotCompleted extends OnboardingState {}

class OnboardingCompleted extends OnboardingState {}
