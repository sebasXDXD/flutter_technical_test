import 'package:rick_clean_app/features/preferences/data/models/character_prepared_preference.dart';

import '../datasources/character_preference_local_datasource.dart';
import '../models/character_preference_model.dart';

class CharacterPreferenceRepository {
  final CharacterPreferenceLocalDatasource datasource;

  CharacterPreferenceRepository(this.datasource);

  Future<void> savePreference(PreparedPreference prepared) async {
    final model = CharacterPreferenceModel(
      apiId: prepared.apiId,
      originalName: prepared.originalName,
      customName: prepared.customName,
      image: prepared.image,
      gender: prepared.gender,
      status: prepared.status,
      species: prepared.species,
      origin: prepared.origin,
      location: prepared.location,
    );

    await datasource.addPreference(model);
  }

  Future<List<CharacterPreferenceModel>> getPreferences() {
    return datasource.getAll();
  }

  Future<void> deletePreference(dynamic key) {
    return datasource.deleteByKey(key);
  }

  Future<void> update(CharacterPreferenceModel updatedModel) async {
    await updatedModel.save();
  }
}
