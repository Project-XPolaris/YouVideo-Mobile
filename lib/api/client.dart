import 'package:dio/dio.dart';
import 'package:youvideo/api/history.dart';
import 'package:youvideo/api/info.dart';
import 'package:youvideo/api/library.dart';
import 'package:youvideo/api/tag.dart';
import 'package:youvideo/api/user_auth_response.dart';
import 'package:youvideo/api/user_token.dart';
import 'package:youvideo/api/video.dart';

import '../config.dart';
import 'base.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  static Dio _dio = new Dio();

  factory ApiClient() {
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

  Future<ListResponseWrap<Video>> fetchVideoList(
      Map<String, String> params) async {
    var response = await _dio.get("/videos", queryParameters: params);
    ListResponseWrap<Video> responseBody = ListResponseWrap.fromJson(
        response.data, (data) => Video.fromJson(data));
    return responseBody;
  }

  Future<ListResponseWrap<Tag>> fetchTagList(
      Map<String, String> params) async {
    var response = await _dio.get("/tag", queryParameters: params);
    ListResponseWrap<Tag> responseBody = ListResponseWrap.fromJson(
        response.data, (data) => Tag.fromJson(data));
    return responseBody;
  }

  Future<ListResponseWrap<Library>> fetchLibraryList(
      Map<String, String> params) async {
    var response = await _dio.get("/library", queryParameters: params);
    ListResponseWrap<Library> responseBody = ListResponseWrap.fromJson(
        response.data, (data) => Library.fromJson(data));
    return responseBody;
  }
  Future<ListResponseWrap<History>> fetchHistoryList(
      Map<String, String> params) async {
    var response = await _dio.get("/history", queryParameters: params);
    ListResponseWrap<History> responseBody = ListResponseWrap.fromJson(
        response.data, (data) => History.fromJson(data));
    return responseBody;
  }

  Future<Video> fetchVideo(int id) async {
    var response = await _dio.get("/video/$id");
    return Video.fromJson(response.data);
  }

  Future createTag(String name,List<int> ids) async {
    var response = await _dio.post("/tag/videos", data: {"name":[name],"ids":ids});
    return response;
  }
  Future removeTag(int id) async {
    var response = await _dio.delete("/tag/$id");
    return response;
  }
  Future removeVideoFromTag(int id,List<int> videoIds) async {
    var response = await _dio.delete("/tag/$id/videos", data: {"ids":videoIds});
    return response;
  }
  Future<Info> fetchInfo() async {
    var response = await _dio.get("/info");
    return Info.fromJson(response.data);
  }
  Future<UserAuthResponse> fetchUserAuth(username,password) async {
    var response = await _dio.post("/user/auth",data: {"username":username,"password":password});
    return UserAuthResponse.fromJson(response.data);
  }
  Future<UserToken> userToken(String token) async {
    var response = await _dio.get("/user/auth",queryParameters: {"token":token});
    return UserToken.fromJson(response.data);
  }
  ApiClient._internal();
}
