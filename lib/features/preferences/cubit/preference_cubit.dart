import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_clean_app/features/preferences/data/models/character_preference_model.dart';
import 'package:rick_clean_app/features/preferences/data/models/character_prepared_preference.dart';
import 'package:rick_clean_app/features/preferences/data/models/character_update_preference_input_model.dart';
import '../data/repositories/character_preference_repository.dart';
import 'preference_state.dart';

class PreferenceCubit extends Cubit<PreferenceState> {
  final CharacterPreferenceRepository repository;

  PreferenceCubit(this.repository) : super(PreferenceInitial());

  Future<void> save(PreparedPreference prepared) async {
    emit(PreferenceLoading());

    try {
      await repository.savePreference(prepared);
      emit(PreferenceSuccess(await repository.getPreferences()));
    } catch (_) {
      emit(PreferenceError('Error al guardar el elemento'));
    }
  }

  Future<void> loadAll() async {
    emit(PreferenceLoading());

    try {
      emit(PreferenceSuccess(await repository.getPreferences()));
    } catch (_) {
      emit(PreferenceError('Error al cargar elementos'));
    }
  }

  Future<void> update({
    required CharacterPreferenceModel model,
    required UpdatePreferenceInput input,
  }) async {
    if (!input.hasChanges) return;

    emit(PreferenceLoading());

    try {
      model.customName = input.customName ?? model.customName;
      model.gender = input.gender ?? model.gender;
      model.origin = input.origin ?? model.origin;
      model.location = input.location ?? model.location;
      await model.save();

      emit(PreferenceSuccess(await repository.getPreferences()));
    } catch (e) {
      emit(PreferenceError('Error al actualizar el elemento: $e'));
    }
  }




  Future<void> delete(CharacterPreferenceModel model) async {
    emit(PreferenceLoading());

    try {
      await repository.deletePreference(model.key);
      emit(PreferenceSuccess(await repository.getPreferences()));
    } catch (_) {
      emit(PreferenceError('Error al eliminar el elemento'));
    }
  }
}
