import '../datasources/rick_morty_remote_datasource.dart';
import '../models/api_character_model.dart';

class RickMortyRepository {
  final RickMortyRemoteDatasource remoteDatasource;

  RickMortyRepository(this.remoteDatasource);

  Future<List<CharacterModel>> getCharacters({String? name}) async {
    final response = await remoteDatasource.getCharacters(name: name);

    final results = response.data['results'] as List;

    return results
        .map((json) => CharacterModel.fromJson(json))
        .toList();
  }
}
