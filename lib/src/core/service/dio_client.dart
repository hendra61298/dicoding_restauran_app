
import 'dart:io';

import 'package:dicoding_restaurant_app/src/constant/api_urls.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';


abstract class DioClient {
  Future<dynamic> get(String url, {Map<String, dynamic>? queryParameters});

}

@injectable
class DioClientImpl implements DioClient {
  late Dio _dio;

  DioClientImpl() {
    _initApiClient();
  }

  void _initApiClient() {
    BaseOptions options = BaseOptions(
      baseUrl: ApiUrls.baseUrl,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      responseType: ResponseType.json,
    );
    _dio = Dio(options);
  }

  @override
  Future<dynamic> get(
      String url, {
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
      );

      return response.data;
    } on DioError catch (e) {
      if (e.response?.data != null) throw Exception(e.response?.data);

      throw Exception(e.message);
    }
  }
}
