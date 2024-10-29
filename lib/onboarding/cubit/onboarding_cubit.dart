import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  Future<void> checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final hasCompletedOnboarding =
        prefs.getBool('onboardingCompleted') ?? false;

    if (hasCompletedOnboarding) {
      emit(OnboardingCompleted());
    } else {
      emit(OnboardingNotCompleted());
    }
  }

  Future<void> saveUserData({
    required String name,
    required String document,
    required String birthDate,
    required int age,
    required String eps,
    required String bloodType,
    required String city,
    required String address,
    required String neighborhood,
    required String phone,
    required String emergencyContactName,
    required String emergencyContactPhone,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('document', document);
    await prefs.setString('birthDate', birthDate);
    await prefs.setInt('age', age);
    await prefs.setString('eps', eps);
    await prefs.setString('bloodType', bloodType);
    await prefs.setString('city', city);
    await prefs.setString('address', address);
    await prefs.setString('neighborhood', neighborhood);
    await prefs.setString('phone', phone);
    await prefs.setString('emergencyContactName', emergencyContactName);
    await prefs.setString('emergencyContactPhone', emergencyContactPhone);
    await prefs.setBool('onboardingCompleted', true);

    emit(OnboardingCompleted());
  }
}

abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingNotCompleted extends OnboardingState {}

class OnboardingCompleted extends OnboardingState {}
