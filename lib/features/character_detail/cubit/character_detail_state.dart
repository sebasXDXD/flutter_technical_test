import 'package:rick_clean_app/features/character_detail/data/models/character_detail_model.dart';

abstract class CharacterDetailState {}

class DetailInitial extends CharacterDetailState {}
class DetailLoading extends CharacterDetailState {}
class DetailError extends CharacterDetailState {
  final String message;
  DetailError(this.message);
}

class DetailSuccess extends CharacterDetailState {
  final CharacterDetailModel character;
  DetailSuccess(this.character);
}
