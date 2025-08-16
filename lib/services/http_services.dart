import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../models/app_config.dart';

class HTTPServices {
  final Dio dio = Dio();
  final getIt = GetIt.instance;

  late final String base_url;
  late final String api_key;

  HTTPServices()
    : base_url = GetIt.instance.get<AppConfig>().BASE_API_URL,
      api_key = GetIt.instance.get<AppConfig>().API_KEY;

  Future<Response?> get(String path, {Map<String, dynamic>? query}) async {
    try {
      String url = '$base_url$path';

      // default query params
      final params = {
        'api_key': api_key,
        'language': 'en-US',
        ...?query, // spread extra query if provided
      };

      return await dio.get(url, queryParameters: params);
    } on DioError catch (e) {
      print("Unable to perform this request");
      print("DioError: ${e.message}");
      return e.response; // optional: return the error response
    }
  }
}
