class Archetype {
  final String archetypeName;

  Archetype({required this.archetypeName});

  factory Archetype.fromJson(Map<String, dynamic> json) {
    return Archetype(
      archetypeName: json['archetype_name'],
    );
  }
}
