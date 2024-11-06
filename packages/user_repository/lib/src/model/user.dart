/// {@template user_model}
/// Mode which represents the user data.
/// {@endtemplate}
class UserModel {
  /// Constructor for the UserModel.
  UserModel({
    required this.name,
    required this.document,
    required this.birthDate,
    required this.age,
    required this.eps,
    required this.bloodType,
    required this.city,
    required this.address,
    required this.neighborhood,
    required this.phone,
    required this.emergencyContactName,
    required this.emergencyContactPhone,
    required this.lastName,
  }) : fullName = '$name $lastName';

  /// Factory method to create a default user.
  factory UserModel.defaultUser() {
    return UserModel(
      name: 'No name',
      document: 'No document',
      birthDate: DateTime.now(),
      age: 0,
      bloodType: 'No blood type',
      city: 'No city',
      address: 'No address',
      neighborhood: 'No neighborhood',
      phone: 'No phone',
      emergencyContactName: 'No emergency contact name',
      emergencyContactPhone: 'No emergency contact phone',
      lastName: 'No last name',
      eps: EPS.aliansalud_entidad_promotora_de_salud_s_a,
    );
  }

  /// Factory method to create a user from a map.
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      document: map['document'] as String,
      birthDate: DateTime.parse(map['birthDate'] as String),
      age: map['age'] as int,
      bloodType: map['bloodType'] as String,
      city: map['city'] as String,
      address: map['address'] as String,
      neighborhood: map['neighborhood'] as String,
      phone: map['phone'] as String,
      emergencyContactName: map['emergencyContactName'] as String,
      emergencyContactPhone: map['emergencyContactPhone'] as String,
      lastName: map['lastName'] as String,
      eps: EPS.values.firstWhere((element) => element.toString() == map['eps']),
    );
  }

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

  /// The city of the user.
  final String city;

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

  /// The EPS of the user.
  final EPS eps;

  /// Map representation of the user.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lastName': lastName,
      'fullName': fullName,
      'document': document,
      'birthDate': birthDate.toIso8601String(),
      'age': age,
      'eps': eps.toString(),
      'bloodType': bloodType,
      'city': city,
      'address': address,
      'neighborhood': neighborhood,
      'phone': phone,
      'emergencyContactName': emergencyContactName,
      'emergencyContactPhone': emergencyContactPhone,
    };
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
  city,
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
    'Medicina Prepagada Suramericana S.A.',
    'assets/eps/medicina_prepagada_suramericana_s_a.png',
  ),
  fundacion_salud_mia(
    'Fundación Salud Mía',
    'assets/eps/fundacion_salud_mia.png',
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
