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
  });

  /// Factory method to create a default user.
  factory UserModel.defaultUser() {
    return UserModel(
      name: 'No name',
      document: 'No document',
      birthDate: DateTime.now(),
      age: 0,
      eps: 'No EPS',
      bloodType: 'No blood type',
      city: 'No city',
      address: 'No address',
      neighborhood: 'No neighborhood',
      phone: 'No phone',
      emergencyContactName: 'No emergency contact name',
      emergencyContactPhone: 'No emergency contact phone',
    );
  }

  /// Factory method to create a user from a map.
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      document: map['document'] as String,
      birthDate: DateTime.parse(map['birthDate'] as String),
      age: map['age'] as int,
      eps: map['eps'] as String,
      bloodType: map['bloodType'] as String,
      city: map['city'] as String,
      address: map['address'] as String,
      neighborhood: map['neighborhood'] as String,
      phone: map['phone'] as String,
      emergencyContactName: map['emergencyContactName'] as String,
      emergencyContactPhone: map['emergencyContactPhone'] as String,
    );
  }

  /// The name of the user.
  final String name;

  /// The document ID of the user.
  final String document;

  /// The birth date of the user.
  final DateTime birthDate;

  /// The age of the user.
  final int age;

  /// The EPS of the user.
  final String eps;

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

  /// Map representation of the user.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'document': document,
      'birthDate': birthDate.toIso8601String(),
      'age': age,
      'eps': eps,
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
