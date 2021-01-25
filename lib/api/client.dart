import 'package:dio/dio.dart';
import 'package:youvideo/api/video.dart';

import '../config.dart';
import 'base.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  static Dio _dio = new Dio();
  factory ApiClient() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest:(RequestOptions options) async {
        options.baseUrl = ApplicationConfig().serviceUrl;
        return options; //continue
      },
    ));
    return _instance;
  }

  Future<ListResponseWrap<Video>> fetchVideoList(Map<String,String> params) async{
    var response = await _dio.get("/videos",queryParameters: params);
    ListResponseWrap<Video> responseBody = ListResponseWrap.fromJson(response.data, (data) => Video.fromJson(data));
    return responseBody;
  }
  ApiClient._internal();
}