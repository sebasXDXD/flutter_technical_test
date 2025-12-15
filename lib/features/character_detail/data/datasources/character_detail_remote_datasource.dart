import 'package:dio/dio.dart';
import '../../../../core/helpers/dio_client.dart';
import '../models/character_detail_model.dart';

class CharacterDetailRemoteDatasource {
  final Dio _dio = DioClient.create();

  Future<CharacterDetailModel> getCharacterById(int id) async {
    final Response response = await _dio.get('/character/$id');

    return CharacterDetailModel.fromJson(response.data);
  }
}
