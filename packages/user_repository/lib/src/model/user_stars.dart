///{@template user_stars_model}
///Model which represents the user stars data.
///{@endtemplate}
class UserStars {
  ///Constructor for the UserStars.
  UserStars({
    required this.goldStars,
    required this.greenStars,
  });

  ///Factory method to create a default user stars.
  factory UserStars.defaultUserStars() {
    return UserStars(
      goldStars: 0,
      greenStars: 0,
    );
  }

  ///Factory method to create a user stars from a map.
  factory UserStars.fromMap(Map<String, dynamic> map) {
    return UserStars(
      goldStars: map['goldStars'] as int,
      greenStars: map['greenStars'] as int,
    );
  }

  ///Convert the user stars to a map.
  Map<String, dynamic> toMap() {
    return {
      'goldStars': goldStars,
      'greenStars': greenStars,
    };
  }

  ///Factory method to create a default user stars.
  final int goldStars;

  ///Factory method to create a default user stars.
  final int greenStars;
}
