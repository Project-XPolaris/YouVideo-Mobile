import 'package:dio/dio.dart';
import 'package:youvideo/api/entity.dart';
import 'package:youvideo/api/folder.dart';
import 'package:youvideo/api/history.dart';
import 'package:youvideo/api/info.dart';
import 'package:youvideo/api/library.dart';
import 'package:youvideo/api/meta.dart';
import 'package:youvideo/api/search.dart';
import 'package:youvideo/api/tag.dart';
import 'package:youvideo/api/user_auth_response.dart';
import 'package:youvideo/api/user_token.dart';
import 'package:youvideo/api/video.dart';

import '../config.dart';
import 'base.dart';
import 'cc.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  static Dio _dio = new Dio();

  factory ApiClient() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        options.baseUrl = ApplicationConfig().serviceUrl ?? "";
        String token = ApplicationConfig().token ?? "";
        if (token.isNotEmpty) {
          options.headers = {"Authorization": "Bearer $token"};
        }
        handler.next(options);
      },
    ));
    return _instance;
  }

  Future<BaseResponse<ListResponseWrap<Video>>> fetchVideoList(
      Map<String, String> params) async {
    var response = await _dio.get("/videos", queryParameters: params);
    return BaseResponse<ListResponseWrap<Video>>.fromJson(
        response.data,
        (raw) => ListResponseWrap<Video>.fromJson(
            raw, (data) => Video.fromJson(data)));
  }

  Future<BaseResponse<ListResponseWrap<Tag>>> fetchTagList(
      Map<String, String> params) async {
    var response = await _dio.get("/tag", queryParameters: params);
    return BaseResponse<ListResponseWrap<Tag>>.fromJson(
        response.data,
        (raw) =>
            ListResponseWrap<Tag>.fromJson(raw, (data) => Tag.fromJson(data)));
  }

  Future<BaseResponse<ListResponseWrap<Library>>> fetchLibraryList(
      Map<String, String> params) async {
    var response = await _dio.get("/library", queryParameters: params);
    return BaseResponse<ListResponseWrap<Library>>.fromJson(
        response.data,
        (raw) => ListResponseWrap<Library>.fromJson(
            raw, (data) => Library.fromJson(data)));
  }

  Future<BaseResponse<ListResponseWrap<History>>> fetchHistoryList(
      Map<String, String> params) async {
    var response = await _dio.get("/history", queryParameters: params);
    return BaseResponse<ListResponseWrap<History>>.fromJson(
        response.data,
        (raw) => ListResponseWrap<History>.fromJson(
            raw, (data) => History.fromJson(data)));
  }

  Future<BaseResponse<Video>> fetchVideo(int id) async {
    var response = await _dio.get("/video/$id");
    return BaseResponse<Video>.fromJson(
        response.data, (data) => Video.fromJson(data));
  }

  Future<ListResponseWrap<Folder>> fetchFolder(
      Map<String, String> queryParams) async {
    var response = await _dio.get("/folders", queryParameters: queryParams);
    ListResponseWrap<Folder> responseBody = ListResponseWrap.fromJson(
        response.data, (data) => Folder.fromJson(data));
    return responseBody;
  }

  Future createTag(String name, List<int> ids) async {
    var response = await _dio.post("/tag/videos", data: {
      "name": [name],
      "ids": ids
    });
    return response;
  }

  Future removeTag(int id) async {
    var response = await _dio.delete("/tag/$id");
    return response;
  }

  Future removeVideoFromTag(int id, List<int> videoIds) async {
    var response =
        await _dio.delete("/tag/$id/videos", data: {"ids": videoIds});
    return response;
  }

  Future<Info> fetchInfo() async {
    var response = await _dio.get("/info");
    return Info.fromJson(response.data);
  }

  Future<UserAuthResponse> fetchUserAuth(username, password) async {
    var response = await _dio
        .post("/user/auth", data: {"username": username, "password": password});
    return UserAuthResponse.fromJson(response.data);
  }

  Future<UserToken> userToken(String token) async {
    var response =
        await _dio.get("/user/auth", queryParameters: {"token": token});
    return UserToken.fromJson(response.data);
  }

  Future<BaseResponse<ListResponseWrap<Entity>>> fetchEntityList(
      Map<String, String> params) async {
    var response = await _dio.get("/entities", queryParameters: params);
    BaseResponse<ListResponseWrap<Entity>> responseBody = BaseResponse.fromJson(
        response.data,
        (rawData) => ListResponseWrap<Entity>.fromJson(
            rawData, (data) => Entity.fromJson(data)));
    return responseBody;
  }

  Future<BaseResponse<ListResponseWrap<Meta>>> fetchMetaList(
      Map<String, String> params) async {
    var response = await _dio.get("/meta", queryParameters: params);
    return BaseResponse<ListResponseWrap<Meta>>.fromJson(
        response.data,
        (raw) => ListResponseWrap<Meta>.fromJson(
            raw, (data) => Meta.fromJson(data)));
  }

  Future<List<CC>> fetchCC(int fileId) async {
    var response =
        await _dio.get("/link/${fileId}/cc/${ApplicationConfig().token}");
    List<CC> data = [];
    List<dynamic> subs = response.data["subs"] as List<dynamic>;
    for (var sub in subs) {
      data.add(CC.fromJson(sub));
    }
    return data;
  }

  Future<BaseResponse<Entity>> fetchEntityById(int id) async {
    var response = await _dio.get("/entity/$id");
    return BaseResponse<Entity>.fromJson(
        response.data, (raw) => Entity.fromJson(raw));
  }

  Future<SearchResult> search(String key) async {
    var response = await _dio.get("/search", queryParameters: {"q": key});
    return SearchResult.fromJson(response.data);
  }

  Future<ListResponseWrap<void>> createPlayHistory(int videoId) async {
    var response = await _dio.post("/history", data: {"videoId": videoId});
    return ListResponseWrap.fromJson(response.data, (data) => null);
  }

  ApiClient._internal();
}
