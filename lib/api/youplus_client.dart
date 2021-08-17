import 'package:dio/dio.dart';
import 'fetch_entity_by_name_response.dart';
import '../config.dart';

class YouPlusClient {
  static final YouPlusClient _instance = YouPlusClient._internal();
  static Dio _dio = new Dio();

  factory YouPlusClient() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) async {
        var config = ApplicationConfig();
        options.baseUrl = config.serviceUrl;
        if (config.token != null && config.token.isNotEmpty) {
          options.headers["Authorization"] = "Bearer ${config.token}";
        }
        return options; //continue
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
