import 'package:dio/dio.dart';
import 'package:rick_clean_app/core/helpers/dio_client.dart';


class RickMortyRemoteDatasource {
  final Dio _dio = DioClient.create();
  Future<Response> getCharacters({String? name}) {
    final Map<String, dynamic> queryParams = {};
    if (name != null && name.isNotEmpty) {
      queryParams['name'] = name;
    }

    return _dio.get(
      '/character',
      queryParameters: queryParams,
    );
  }
}
