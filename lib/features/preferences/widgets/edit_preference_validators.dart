List<String> validatePreferenceFields({
  required String? customName,
  required String? gender,
  required String? origin,
  required String? location,
  required String originalCustomName,
  required String originalGender,
  required String originalOrigin,
  required String originalLocation,
}) {
  final errors = <String>[];


  final currentName = customName ?? originalCustomName;
  final currentGender = gender ?? originalGender;
  final currentOrigin = origin ?? originalOrigin;
  final currentLocation = location ?? originalLocation;

  if (currentName.trim().isEmpty) {
    errors.add('El nombre personalizado no puede estar vacío');
  }

  if (currentName.trim().length < 2) {
    errors.add('El nombre debe tener al menos 2 caracteres');
  }

  if (currentName.trim().length > 50) {
    errors.add('El nombre no puede tener más de 50 caracteres');
  }

  if (currentGender.trim().isEmpty) {
    errors.add('El género no puede estar vacío');
  }


  if (currentOrigin.trim().isEmpty) {
    errors.add('El origen no puede estar vacío');
  }

  if (currentLocation.trim().isEmpty) {
    errors.add('La ubicación no puede estar vacía');
  }

  final nameChanged = currentName.trim() != originalCustomName.trim();
  final genderChanged = currentGender.trim() != originalGender.trim();
  final originChanged = currentOrigin.trim() != originalOrigin.trim();
  final locationChanged = currentLocation.trim() != originalLocation.trim();

  if (!nameChanged && !genderChanged && !originChanged && !locationChanged) {
    errors.add('Debes modificar al menos un campo para guardar cambios');
  }

  return errors;
}