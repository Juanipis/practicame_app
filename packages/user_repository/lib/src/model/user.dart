import 'package:isar/isar.dart';

part 'user.g.dart';

/// {@template user_model}
/// Mode which represents the user data.
/// {@endtemplate}
@collection
class UserModel {
  /// Constructor for the UserModel.
  UserModel({
    required this.name,
    required this.document,
    required this.birthDate,
    required this.age,
    required this.eps,
    required this.bloodType,
    required this.municipality,
    required this.address,
    required this.neighborhood,
    required this.phone,
    required this.emergencyContactName,
    required this.emergencyContactPhone,
    required this.lastName,
    this.id = Isar.autoIncrement,
    this.isOnboardingComplete = false,
    this.goldStars = 0,
    this.greenStars = 0,
  }) : fullName = '$name $lastName';

  /// Factory method to create a default user.
  factory UserModel.defaultUser() {
    return UserModel(
      name: 'No name',
      document: 'No document',
      birthDate: DateTime.now(),
      age: 0,
      bloodType: 'No blood type',
      municipality: 'No municipality',
      address: 'No address',
      neighborhood: 'No neighborhood',
      phone: 'No phone',
      emergencyContactName: 'No emergency contact name',
      emergencyContactPhone: 'No emergency contact phone',
      lastName: 'No last name',
      eps: EPS.aliansalud_entidad_promotora_de_salud_s_a,
    );
  }

  Id id; // Expose the ID field

  /// The name of the user.
  final String name;

  /// The last name of the user.
  final String lastName;

  /// The full name of the user.
  final String fullName;

  /// The document ID of the user.
  final String document;

  /// The birth date of the user.
  final DateTime birthDate;

  /// The age of the user.
  final int age;

  /// The blood type of the user.
  final String bloodType;

  /// The municipality of the user.
  final String municipality;

  /// The address of the user.
  final String address;

  /// The neighborhood of the user.
  final String neighborhood;

  /// The phone number of the user.
  final String phone;

  /// The name of the emergency contact.
  final String emergencyContactName;

  /// The phone number of the emergency contact.
  final String emergencyContactPhone;

  /// Whether the onboarding process is complete.
  bool isOnboardingComplete;

  /// The EPS of the user.
  @Enumerated(EnumType.ordinal)
  final EPS eps;

  /// Gold stars for this user.
  int goldStars;

  /// Green stars for this user.
  int greenStars;

  /// Map representation of the user.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'fullName': fullName,
      'document': document,
      'birthDate': birthDate.toIso8601String(),
      'age': age,
      'eps': eps.name, // Usa el nombre del enum
      'bloodType': bloodType,
      'municipality': municipality,
      'address': address,
      'neighborhood': neighborhood,
      'phone': phone,
      'emergencyContactName': emergencyContactName,
      'emergencyContactPhone': emergencyContactPhone,
      'isOnboardingComplete': isOnboardingComplete,
      'goldStars': goldStars,
      'greenStars': greenStars,
    };
  }

  /// Copy of the user with the new values.
  UserModel copyWith({
    Id? id,
    String? name,
    String? lastName,
    String? document,
    DateTime? birthDate,
    int? age,
    EPS? eps,
    String? bloodType,
    String? municipality,
    String? address,
    String? neighborhood,
    String? phone,
    String? emergencyContactName,
    String? emergencyContactPhone,
    bool? isOnboardingComplete,
    int? goldStars,
    int? greenStars,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      document: document ?? this.document,
      birthDate: birthDate ?? this.birthDate,
      age: age ?? this.age,
      eps: eps ?? this.eps,
      bloodType: bloodType ?? this.bloodType,
      municipality: municipality ?? this.municipality,
      address: address ?? this.address,
      neighborhood: neighborhood ?? this.neighborhood,
      phone: phone ?? this.phone,
      emergencyContactName: emergencyContactName ?? this.emergencyContactName,
      emergencyContactPhone:
          emergencyContactPhone ?? this.emergencyContactPhone,
      isOnboardingComplete: isOnboardingComplete ?? this.isOnboardingComplete,
      goldStars: goldStars ?? this.goldStars,
      greenStars: greenStars ?? this.greenStars,
    );
  }
}

/// Enum to represent the user attributes.
enum UserAttributes {
  name,
  lastName,
  fullName,
  document,
  birthDate,
  age,
  eps,
  bloodType,
  municipality,
  address,
  neighborhood,
  phone,
  emergencyContactName,
  emergencyContactPhone,
}

enum EPS {
  aliansalud_entidad_promotora_de_salud_s_a(
    'Aliansalud Entidad Promotora de Salud S.A.',
    'assets/eps/aliansalud_entidad_promotora_de_salud_s_a.png',
  ),
  anaswayuu('Anaswayuu', 'assets/eps/anaswayuu.png'),
  asociacion_indigena_del_cauca(
    'Asociación Indígena del Cauca',
    'assets/eps/asociacion_indigena_del_cauca.png',
  ),
  asociacion_mutual_ser_empresa_solidaria_de_salud(
    'Asociación Mutual Ser Empresa Solidaria de Salud',
    'assets/eps/asociacion_mutual_ser_empresa_solidaria_de_salud.webp',
  ),
  capital_salud('Capital Salud', 'assets/eps/capital_salud.png'),
  capresoca('Capresoca', 'assets/eps/capresoca.jpeg'),
  comfenalco_valle('Comfenalco Valle', 'assets/eps/comfenalco_valle.png'),
  compensar('Compensar', 'assets/eps/compensar.png'),
  famisanar_ltda('Famisanar Ltda', 'assets/eps/famisanar_ltda.png'),
  sanitas_s_a('Sanitas S.A.', 'assets/eps/sanitas_s_a.jpg'),
  convida('Convida', 'assets/eps/convida.jpg'),
  servicio_occidental_de_salud_s_a(
    'Servicio Occidental de Salud S.A.',
    'assets/eps/servicio_occidental_de_salud_s_a.webp',
  ),
  medicina_prepagada_suramericana_s_a(
    'Sura EPS',
    'assets/eps/medicina_prepagada_suramericana_s_a.png',
  ),
  fundacion_salud_mia(
    'Fundación Salud Mía',
    'assets/eps/fundacion_salud_mia.png',
  ),
  fomag(
    'Fondo Nacional de Prestaciones Sociales del Magisterio (EPS Profesores)',
    'assets/eps/fomag.png',
  ),
  direccion_de_sanidad_policia_nacional(
    'Dirección de Sanidad Policía Nacional',
    'assets/eps/direccion_de_sanidad_policia_nacional.png',
  ),
  mallamas('Mallamas', 'assets/eps/mallamas.png'),
  nueva_s_a('Nueva S.A.', 'assets/eps/nueva_s_a.png'),
  salud_total_s_a('Salud Total S.A.', 'assets/eps/salud_total_s_a.png'),
  saludvida_s_a('Saludvida S.A.', 'assets/eps/saludvida_s_a.jpg'),
  savia_salud('Savia Salud', 'assets/eps/savia_salud.webp'),
  ;

  const EPS(this.name, this.image);

  /// The name of the EPS.
  final String name;

  /// The image of the EPS.
  final String image;
}
