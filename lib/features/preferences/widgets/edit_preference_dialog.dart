import 'package:flutter/material.dart';
import 'package:rick_clean_app/core/widgets/custom_snackbar.dart';
import 'package:rick_clean_app/features/preferences/data/models/character_update_preference_input_model.dart';
import '../data/models/character_preference_model.dart';
import 'edit_preference_validators.dart';

class EditPreferenceDialog extends StatefulWidget {
  final CharacterPreferenceModel model;
  final void Function(UpdatePreferenceInput input) onSave;

  const EditPreferenceDialog({
    super.key,
    required this.model,
    required this.onSave,
  });

  @override
  State<EditPreferenceDialog> createState() => _EditPreferenceDialogState();
}

class _EditPreferenceDialogState extends State<EditPreferenceDialog> {
  late final TextEditingController nameCtrl;
  late final TextEditingController genderCtrl;
  late final TextEditingController originCtrl;
  late final TextEditingController locationCtrl;

  List<String> _errors = []; // Almacenar errores en el estado

  String? _changed(String value, String original) {
    final trimmed = value.trim();
    if (trimmed.isEmpty || trimmed == original) return null;
    return trimmed;
  }

  void _handleSave(BuildContext dialogContext) {
    final currentName = nameCtrl.text.trim();
    final currentGender = genderCtrl.text.trim();
    final currentOrigin = originCtrl.text.trim();
    final currentLocation = locationCtrl.text.trim();

    // Ejecutar validación
    final errors = validatePreferenceFields(
      customName: currentName,
      gender: currentGender,
      origin: currentOrigin,
      location: currentLocation,
      originalCustomName: widget.model.customName ?? '',
      originalGender: widget.model.gender ?? '',
      originalOrigin: widget.model.origin ?? '',
      originalLocation: widget.model.location ?? '',
    );

    // Si hay errores, actualizar el estado para mostrarlos
    if (errors.isNotEmpty) {
      setState(() {
        _errors = errors;
      });
      return;
    }
    final input = UpdatePreferenceInput(
      customName: _changed(nameCtrl.text, widget.model.customName ?? ''),
      gender: _changed(genderCtrl.text, widget.model.gender ?? ''),
      origin: _changed(originCtrl.text, widget.model.origin ?? ''),
      location: _changed(locationCtrl.text, widget.model.location ?? ''),
    );

    widget.onSave(input);
    SnackbarHelper.showSuccess(dialogContext, '✓ Cambios guardados con éxito');

    Navigator.pop(dialogContext);
  }

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.model.customName);
    genderCtrl = TextEditingController(text: widget.model.gender);
    originCtrl = TextEditingController(text: widget.model.origin);
    locationCtrl = TextEditingController(text: widget.model.location);
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    genderCtrl.dispose();
    originCtrl.dispose();
    locationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Builder(
          builder: (dialogContext) => Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(widget.model.image ?? ''),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.model.customName ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${widget.model.status} • ${widget.model.species}',
                    style: const TextStyle(color: Colors.green),
                  ),
                  const SizedBox(height: 20),
                  _cardField(
                    controller: genderCtrl,
                    label: 'Género',
                    icon: Icons.person,
                    color: Colors.purple,
                  ),
                  _cardField(
                    controller: originCtrl,
                    label: 'Origen',
                    icon: Icons.public,
                    color: Colors.blue,
                  ),
                  _cardField(
                    controller: locationCtrl,
                    label: 'Ubicación',
                    icon: Icons.location_on,
                    color: Colors.orange,
                  ),
                  _cardField(
                    controller: nameCtrl,
                    label: 'Nombre personalizado',
                    icon: Icons.edit,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 20),

                  if (_errors.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade900.withValues(alpha: 77),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.red.shade700,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.error_outline, color: Colors.red, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Errores de validación:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ..._errors.map((error) => Padding(
                            padding: const EdgeInsets.only(left: 28, bottom: 4),
                            child: Text(
                              '• $error',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _handleSave(context),
                      icon: const Icon(Icons.save),
                      label: const Text('Guardar cambios'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        textStyle: const TextStyle(fontSize: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 51),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: label,
                labelStyle: TextStyle(
                  color: Colors.white.withValues(alpha: 153),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(Icons.edit, color: color),
        ],
      ),
    );
  }
}