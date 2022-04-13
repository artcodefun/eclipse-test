
import 'package:dio/dio.dart';

import '../ApiHandler.dart';

/// Default ApiHandler implementation with dio package
class DioApiHandler implements ApiHandler{


  @override
  Future delete(String path) async{
    Response response;
    response = await _dio.delete(path);
  }

  @override
  Future<T> get<T>(String path, Map<String, dynamic> query, ApiConverter<T> converter) async {
    Response response;
    response = await _dio.get(path, queryParameters: query);

    return converter(response.data);
  }

  late Dio _dio;
  @override
  Future init(String baseUrl) async{
    _dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  @override
  Future<T> post<T>(String apiPath, T data, ApiConverter<T> converter, ApiReverseConverter<T> reverseConverter,) async{
    Response response;
    response = await _dio.post( apiPath, data: reverseConverter(data));
    return converter(response.data);
  }

  @override
  Future<T> put<T>(String apiPath, T data, ApiConverter<T> converter, ApiReverseConverter<T> reverseConverter,) async{
    Response response;
    response = await _dio.put( apiPath, data: converter(data));
    return converter(response.data);
  }

  @override
  Future download(String path, String localPath) async{
    await _dio.download(path, localPath);
  }

}