class PreparedPreference {
  final int apiId;
  final String originalName;
  final String image;

  String customName;
  String gender;
  String status;
  String species;
  String origin;
  String location;

  PreparedPreference({
    required this.apiId,
    required this.originalName,
    required this.image,
    required this.customName,
    required this.gender,
    required this.status,
    required this.species,
    required this.origin,
    required this.location,
  });
}
