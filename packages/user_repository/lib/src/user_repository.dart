import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/src/model/user.dart';
import 'package:user_repository/src/model/user_stars.dart';

/// {@template user_repository}
/// Repository which manages user data.
/// {@endtemplate}
class UserRepository {
  /// Key to store the user data.
  static const String userKey = 'user_data';

  /// Save the user data.
  Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode(user.toMap());
    await prefs.setString(userKey, userData);
  }

  /// Get the user data.
  Future<UserModel> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(userKey);
    if (userData != null) {
      final userMap = json.decode(userData) as Map<String, dynamic>;
      return UserModel.fromMap(userMap);
    }
    return UserModel.defaultUser(); // Retorna un usuario por defecto
  }

  /// Update a user field.
  Future<void> updateUserField(String field, dynamic value) async {
    final user = await getUser();

    final updatedUserMap = user.toMap();
    updatedUserMap[field] = value;

    final updatedUser = UserModel.fromMap(updatedUserMap);
    await saveUser(updatedUser);
  }

  /// Verify if the onboarding process is complete.
  Future<bool> isOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(userKey);
  }

  /// Clear the user data.
  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userKey);
  }

  /// Save the user stars data.
  Future<void> saveUserStars(UserStars userStars) async {
    final prefs = await SharedPreferences.getInstance();
    final userStarsData = json.encode(userStars.toMap());
    await prefs.setString('user_stars', userStarsData);
  }

  /// Append stars to the user.
  Future<void> appendStars(int goldStars, int greenStars) async {
    final userStars = await getUserStars();
    final updatedUserStars = UserStars(
      goldStars: userStars.goldStars + goldStars,
      greenStars: userStars.greenStars + greenStars,
    );
    await saveUserStars(updatedUserStars);
  }

  /// Remove stars from the user.
  Future<void> removeStars(int goldStars, int greenStars) async {
    final userStars = await getUserStars();
    final updatedUserStars = UserStars(
      goldStars: userStars.goldStars - goldStars,
      greenStars: userStars.greenStars - greenStars,
    );
    await saveUserStars(updatedUserStars);
  }

  /// Get the user stars data.
  Future<UserStars> getUserStars() async {
    final prefs = await SharedPreferences.getInstance();
    final userStarsData = prefs.getString('user_stars');
    if (userStarsData != null) {
      final userStarsMap = json.decode(userStarsData) as Map<String, dynamic>;
      return UserStars.fromMap(userStarsMap);
    }
    return UserStars.defaultUserStars();
  }
}
