import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/src/model/user.dart';

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
}
