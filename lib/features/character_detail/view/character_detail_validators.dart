List<String> validateCharacterFields({
  required String customName,
  required String originalName,
  required String gender,
  required String origin,
  required String location,
  required String originalGender,
  required String originalOrigin,
  required String originalLocation,
}) {
  final errors = <String>[];

  //  Nombre
  if (customName.trim().isEmpty) {
    errors.add('El nombre no puede estar vacío');
  } else if (customName.trim().length < 3) {
    errors.add('El nombre debe tener al menos 3 caracteres');
  }

  if (gender.trim().isEmpty) {
    errors.add('El género no puede estar vacío');
  }

  if (origin.trim().isEmpty) {
    errors.add('El origen no puede estar vacío');
  }

  if (location.trim().isEmpty) {
    errors.add('La ubicación no puede estar vacía');
  }

  final hasAnyChange =
      customName.trim() != originalName.trim() ||
          gender.trim() != originalGender.trim() ||
          origin.trim() != originalOrigin.trim() ||
          location.trim() != originalLocation.trim();

  if (!hasAnyChange) {
    errors.add('Debes modificar al menos un campo para guardar los cambios');
  }

  return errors;
}
