import 'package:isar/isar.dart';

part 'app_config.g.dart';

@collection
class AppConfig {
  Id id = 0; // Siempre será único (solo un registro)

  @Enumerated(EnumType.ordinal)
  AppMode appMode = AppMode.unknown;
}

/// Enum para los modos de la aplicación.
enum AppMode {
  unknown, // No configurado
  teacher, // Modo maestro
  student, // Modo estudiante
}
