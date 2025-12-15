import '../data/models/api_character_model.dart';

abstract class ApiCharactersState {
  const ApiCharactersState();
}

class ApiCharactersInitial extends ApiCharactersState {
  const ApiCharactersInitial();
}

class ApiCharactersLoading extends ApiCharactersState {
  const ApiCharactersLoading();
}

class ApiCharactersSuccess extends ApiCharactersState {
  final List<CharacterModel> characters;

  const ApiCharactersSuccess(this.characters);
}


class ApiCharactersEmpty extends ApiCharactersState {
  const ApiCharactersEmpty();
}


class ApiCharactersError extends ApiCharactersState {
  final String message;

  const ApiCharactersError(this.message);
}
