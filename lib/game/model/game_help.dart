class GameHelps {
  GameHelps({
    required this.text,
    required this.images,
    required this.audios,
  });

  final String text;
  final List<String> images;
  final List<String> audios;

  GameHelps copyWith({
    String? text,
    List<String>? images,
    List<String>? audios,
  }) {
    return GameHelps(
      text: text ?? this.text,
      images: images ?? this.images,
      audios: audios ?? this.audios,
    );
  }
}
