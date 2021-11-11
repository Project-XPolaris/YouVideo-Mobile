import 'package:dio/dio.dart';
import 'fetch_entity_by_name_response.dart';
import '../config.dart';

class YouPlusClient {
  static final YouPlusClient _instance = YouPlusClient._internal();
  static Dio _dio = new Dio();

  factory YouPlusClient() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest:(RequestOptions options, RequestInterceptorHandler handler) async {
        options.baseUrl = ApplicationConfig().serviceUrl ?? "";
        String token = ApplicationConfig().token ?? "";
        if (token.isNotEmpty) {
          options.headers = {
            "Authorization": "Bearer $token"
          };
        }
        handler.next(options);
      },
    ));
    return _instance;
  }

  Future<FetchEntityByNameResponse> fetchEntityByName(String name) async {
    var response = await _dio.get("/entry", queryParameters: {"name":name});
    FetchEntityByNameResponse responseBody = FetchEntityByNameResponse.fromJson(
        response.data);
    return responseBody;
  }
  YouPlusClient._internal();
}
