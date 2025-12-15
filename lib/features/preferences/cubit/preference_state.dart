import '../data/models/character_preference_model.dart';

abstract class PreferenceState {}

class PreferenceInitial extends PreferenceState {}

class PreferenceLoading extends PreferenceState {}

class PreferenceSuccess extends PreferenceState {
  final List<CharacterPreferenceModel> preferences;

  PreferenceSuccess(this.preferences);
}

class PreferenceError extends PreferenceState {
  final String message;

  PreferenceError(this.message);
}
