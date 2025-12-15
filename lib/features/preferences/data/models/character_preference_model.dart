import 'package:hive/hive.dart';

part 'character_preference_model.g.dart';

@HiveType(typeId: 0)
class CharacterPreferenceModel extends HiveObject {
  @HiveField(0)
  final int apiId;

  @HiveField(1)
  final String originalName;

  @HiveField(2)
  String customName;

  @HiveField(3)
  final String image;

  @HiveField(4)
  String gender;

  @HiveField(5)
  String status;

  @HiveField(6)
  String species;

  @HiveField(7)
  String origin;

  @HiveField(8)
  String location;

  CharacterPreferenceModel({
    required this.apiId,
    required this.originalName,
    required this.customName,
    required this.image,
    required this.gender,
    required this.status,
    required this.species,
    required this.origin,
    required this.location,
  });

  CharacterPreferenceModel copyWith({
    String? customName,
    String? gender,
    String? status,
    String? species,
    String? origin,
    String? location,
  }) {
    return CharacterPreferenceModel(
      apiId: apiId,
      originalName: originalName,
      image: image,
      customName: customName ?? this.customName,
      gender: gender ?? this.gender,
      status: status ?? this.status,
      species: species ?? this.species,
      origin: origin ?? this.origin,
      location: location ?? this.location,
    );
  }
}
