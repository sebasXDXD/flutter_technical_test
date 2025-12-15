import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/rick_morty_repository.dart';
import 'api_characters_state.dart';

class ApiCharactersCubit extends Cubit<ApiCharactersState> {
  final RickMortyRepository repository;

  String _lastQuery = '';

  ApiCharactersCubit(this.repository) : super(ApiCharactersInitial());

  Future<void> loadCharacters() async {
    _lastQuery = '';
    await _fetchCharacters();
  }

  Future<void> searchCharacters(String name) async {
    _lastQuery = name;

    if (name.trim().isEmpty) {
      await loadCharacters();
      return;
    }

    await _fetchCharacters(name: name);
  }

  Future<void> retry() async {
    if (_lastQuery.isEmpty) {
      await loadCharacters();
    } else {
      await _fetchCharacters(name: _lastQuery);
    }
  }

  Future<void> _fetchCharacters({String? name}) async {
    emit(ApiCharactersLoading());

    try {
      final characters = await repository.getCharacters(name: name);
      emit(ApiCharactersSuccess(characters));
    } catch (_) {
      emit(
        ApiCharactersError(
          'No se encontraron personajes o hubo un error de red.',
        ),
      );
    }
  }
}
