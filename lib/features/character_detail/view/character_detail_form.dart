import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_clean_app/core/widgets/custom_snackbar.dart';
import 'package:rick_clean_app/features/character_detail/widget/info_card.dart';
import 'package:rick_clean_app/features/preferences/data/models/character_prepared_preference.dart';
import 'package:rick_clean_app/features/preferences/data/repositories/character_preference_repository.dart';
import 'character_detail_validators.dart';

class CharacterDetailForm extends StatefulWidget {
  final dynamic character;
  const CharacterDetailForm({super.key, required this.character});

  @override
  State<CharacterDetailForm> createState() => _CharacterDetailFormState();
}

class _CharacterDetailFormState extends State<CharacterDetailForm> {
  String? _gender;
  String? _origin;
  String? _location;
  String? _customName;

  late final CharacterPreferenceRepository repository;

  @override
  void initState() {
    super.initState();
    repository = context.read<CharacterPreferenceRepository>();
  }

  Future<void> _saveChanges() async {
    final c = widget.character;

    final currentCustomName =
    (_customName == null || _customName!.trim().isEmpty)
        ? c.name
        : _customName!.trim();

    final currentGender = _gender ?? c.gender;
    final currentOrigin = _origin ?? c.origin;
    final currentLocation = _location ?? c.location;

    final errors = validateCharacterFields(
      customName: currentCustomName,
      originalName: c.name,
      gender: currentGender,
      origin: currentOrigin,
      location: currentLocation,
      originalGender: c.gender,
      originalOrigin: c.origin,
      originalLocation: c.location,
    );

    if (errors.isNotEmpty) {
      if (mounted) {
        SnackbarHelper.showError(
          context,
          ['Errores de validación:', ...errors.map((e) => '• $e')].join('\n'),
        );
      }
      return;
    }

    final prepared = PreparedPreference(
      apiId: c.id,
      originalName: c.name,
      customName: currentCustomName,
      image: c.image,
      gender: currentGender,
      status: c.status,
      species: c.species,
      origin: currentOrigin,
      location: currentLocation,
    );

    try {
      await repository.savePreference(prepared);

      if (mounted) {
        SnackbarHelper.showSuccess(context, '✓ Preferencias guardadas');
        await Future.delayed(const Duration(milliseconds: 400));
        if (mounted) Navigator.pop(context);
      }
    } catch (e) {
      debugPrint('❌ Error guardando: $e');
      if (mounted) {
        SnackbarHelper.showError(context, 'Error al guardar preferencias');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.character;
    const double separationHeight = 12.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          InfoCard(
            icon: Icons.edit,
            label: 'Nombre',
            value: _customName ?? c.name,
            color: Colors.teal,
            onChanged: (v) => setState(() => _customName = v),
          ),
          const SizedBox(height: separationHeight),
          InfoCard(
            icon: Icons.person_outline,
            label: 'Género',
            value: _gender ?? c.gender,
            color: Colors.purple,
            onChanged: (v) => setState(() => _gender = v),
          ),
          const SizedBox(height: separationHeight),
          InfoCard(
            icon: Icons.public,
            label: 'Origen',
            value: _origin ?? c.origin,
            color: Colors.blue,
            onChanged: (v) => setState(() => _origin = v),
          ),
          const SizedBox(height: separationHeight),
          InfoCard(
            icon: Icons.location_on_outlined,
            label: 'Ubicación',
            value: _location ?? c.location,
            color: Colors.orange,
            onChanged: (v) => setState(() => _location = v),
          ),

          const SizedBox(height: separationHeight),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _saveChanges,
              icon: const Icon(Icons.save),
              label: const Text('Guardar cambios'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                textStyle: const TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}