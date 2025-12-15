import '../datasources/character_detail_remote_datasource.dart';
import '../models/character_detail_model.dart';

class CharacterDetailRepository {
  final CharacterDetailRemoteDatasource remoteDatasource;

  CharacterDetailRepository(this.remoteDatasource);

  Future<CharacterDetailModel> getById(int id) {
    return remoteDatasource.getCharacterById(id);
  }
}
