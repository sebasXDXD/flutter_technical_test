class UpdatePreferenceInput {
  final String? customName;
  final String? gender;
  final String? origin;
  final String? location;

  const UpdatePreferenceInput({
    this.customName,
    this.gender,
    this.origin,
    this.location,
  });

  bool get hasChanges =>
      customName != null ||
          gender != null ||
          origin != null ||
          location != null;
}
