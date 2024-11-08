import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:user_repository/src/model/user.dart';
import 'package:user_repository/src/model/user_stars.dart';

/// {@template user_repository}
/// Repository which manages user data.
/// {@endtemplate}
class UserRepository {
  /// Constructor privado para el patrón Singleton.
  UserRepository._privateConstructor();
  static UserRepository? _instance;
  static Isar? _isar;

  /// Método estático para inicializar el repositorio y asegurar que Isar esté listo.
  static Future<UserRepository> init() async {
    if (_instance == null) {
      _instance = UserRepository._privateConstructor();
      final dir = await getApplicationDocumentsDirectory();
      _isar = await Isar.open(
        [UserModelSchema, UserStarsSchema],
        directory: dir.path,
      );
    }
    return _instance!;
  }

  /// Save the user data.
  Future<void> saveUser(UserModel user) async {
    await _isar!.writeTxn(() async {
      await _isar!.userModels.put(user);
    });
  }

  /// Get the user data.
  Future<UserModel> getUser() async {
    final user = await _isar!.userModels.where().findFirst();
    return user ?? UserModel.defaultUser();
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
    final user = await getUser();
    return user.isOnboardingComplete;
  }

  /// Clear the user data.
  Future<void> clearUserData() async {
    await _isar!.writeTxn(() async {
      await _isar!.userModels.clear();
    });
  }

  /// Save the user stars data.
  Future<void> saveUserStars(UserStars userStars) async {
    await _isar!.writeTxn(() async {
      await _isar!.userStars.put(userStars);
    });
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
    final userStars = await _isar!.userStars.where().findFirst();
    return userStars ?? UserStars.defaultUserStars();
  }
}
