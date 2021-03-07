import 'package:dio/dio.dart';
import 'package:youvideo/api/library.dart';
import 'package:youvideo/api/video.dart';

import '../config.dart';
import 'base.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  static Dio _dio = new Dio();

  factory ApiClient() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) async {
        print(ApplicationConfig().serviceUrl);
        options.baseUrl = ApplicationConfig().serviceUrl;
        return options; //continue
      },
    ));
    return _instance;
  }

  Future<ListResponseWrap<Video>> fetchVideoList(
      Map<String, String> params) async {
    var response = await _dio.get("/videos", queryParameters: params);
    print(params);
    ListResponseWrap<Video> responseBody = ListResponseWrap.fromJson(
        response.data, (data) => Video.fromJson(data));
    return responseBody;
  }

  Future<ListResponseWrap<Library>> fetchLibraryList(
      Map<String, String> params) async {
    var response = await _dio.get("/library", queryParameters: params);
    ListResponseWrap<Library> responseBody = ListResponseWrap.fromJson(
        response.data, (data) => Library.fromJson(data));
    return responseBody;
  }

  Future<Video> fetchVideo(int id) async {
    var response = await _dio.get("/video/$id");
    return Video.fromJson(response.data);
  }

  ApiClient._internal();
}
