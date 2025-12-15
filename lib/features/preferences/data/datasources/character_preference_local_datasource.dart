import 'package:hive/hive.dart';
import '../models/character_preference_model.dart';

class CharacterPreferenceLocalDatasource {
  static const String boxName = 'preferences';

  Future<Box<CharacterPreferenceModel>> _openBox() async {
    return Hive.openBox<CharacterPreferenceModel>(boxName);
  }

  Future<void> addPreference(CharacterPreferenceModel model) async {
    final box = await _openBox();
    await box.add(model);
  }

  Future<List<CharacterPreferenceModel>> getAll() async {
    final box = await _openBox();
    return box.values.toList();
  }

  Future<void> deleteByKey(dynamic key) async {
    final box = await _openBox();
    await box.delete(key);
  }
}
