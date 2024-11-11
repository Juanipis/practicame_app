import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:user_repository/src/model/app_config.dart';
import 'package:user_repository/src/model/user.dart';

/// {@template user_repository}
/// Repository which manages user data and supports multiple profiles and modes.
/// {@endtemplate}
class UserRepository {
  /// Constructor privado para el patrón Singleton.
  UserRepository._privateConstructor();
  static UserRepository? _instance;
  static Isar? _isar;

  /// ID del usuario activo en modo estudiante o del estudiante seleccionado en modo maestro.
  int? _activeUserId;

  /// Método estático para inicializar el repositorio y asegurar que Isar esté listo.
  static Future<UserRepository> init() async {
    if (_instance == null) {
      _instance = UserRepository._privateConstructor();
      final dir = await getApplicationDocumentsDirectory();
      _isar = await Isar.open(
        [UserModelSchema, AppConfigSchema],
        directory: dir.path,
      );
    }
    return _instance!;
  }

  /// Verifica si es la primera vez que se entra a la app.
  Future<bool> isFirstTime() async {
    final users = await getAllUsers();
    return users.isEmpty;
  }

  /// Configura el modo de la aplicación.
  Future<void> setAppMode(AppMode mode) async {
    await _isar!.writeTxn(() async {
      var config = await _isar!.appConfigs.get(0);
      config ??= AppConfig();
      config.appMode = mode;
      await _isar!.appConfigs.put(config);
    });

    if (mode == AppMode.student) {
      // Si es estudiante, selecciona o crea un perfil único
      final users = await getAllUsers();
      if (users.isEmpty) {
        final defaultUser = UserModel.defaultUser();
        await addUser(defaultUser);
        _activeUserId = defaultUser.id;
      } else {
        _activeUserId = users.first.id;
      }
    }
  }

  /// Obtiene el modo de la aplicación.
  Future<AppMode> getAppMode() async {
    final config = await _isar!.appConfigs.get(0);
    if (config?.appMode == AppMode.student && _activeUserId == null) {
      final users = await getAllUsers();
      if (users.isNotEmpty) {
        _activeUserId = 2; // the unique student profile is ISAR's ID 2
      }
    }
    return config?.appMode ?? AppMode.unknown;
  }

  /// Lista todos los perfiles de usuarios.
  Future<List<UserModel>> getAllUsers() async {
    return await _isar!.userModels.where().findAll();
  }

  /// Añade un nuevo usuario (estudiante o maestro).
  Future<void> addUser(UserModel user) async {
    await _isar!.writeTxn(() async {
      await _isar!.userModels.put(user);
    });
  }

  /// Selecciona el usuario activo según el modo.
  Future<void> setActiveUser(int userId) async {
    _activeUserId = userId;
    await _isar!.writeTxn(() async {
      final users = await getAllUsers();
      for (final user in users) {
        user.isOnboardingComplete = user.id == userId; // Activa este perfil
        await _isar!.userModels.put(user);
      }
    });
  }

  /// Obtiene el usuario activo.
  Future<UserModel?> getActiveUser() async {
    if (_activeUserId == null) return null;

    return _isar!.userModels.get(_activeUserId!);
  }

  /// Obtiene el perfil del estudiante activo en modo maestro.
  Future<UserModel?> getSelectedStudent() async {
    final appMode = await getAppMode();
    if (appMode == AppMode.teacher) {
      return await getActiveUser();
    }
    return null;
  }

  /// Obtiene el perfil del estudiante activo en modo estudiante.
  Future<UserModel?> getStudentProfile() async {
    final appMode = await getAppMode();
    if (appMode == AppMode.student) {
      return getActiveUser();
    }
    return null;
  }

  /// Borra el usuario por ID.
  Future<void> deleteUserById(int id) async {
    await _isar!.writeTxn(() async {
      await _isar!.userModels.delete(id);
    });
  }

  /// Actualiza un usuario.
  Future<void> updateUser(UserModel user) async {
    await _isar!.writeTxn(() async {
      await _isar!.userModels.put(user);
    });
  }

  /// Limpia los datos de todos los usuarios.
  Future<void> clearAllUsers() async {
    await _isar!.writeTxn(() async {
      await _isar!.userModels.clear();
      await _isar!.appConfigs.clear();
    });
    _activeUserId = null;
  }
}
