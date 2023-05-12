import 'package:youvideo/api/base.dart';
import 'package:youvideo/api/file.dart';
import 'package:youvideo/api/loader.dart';
import 'package:youvideo/api/meta.dart';

import 'client.dart';

class Video {
  int? id;
  String? name;
  String? cover;
  String? baseDir;
  String? dirName;
  int? libraryId;
  int? entityId;
  List<File> files = [];
  List<Meta> infos = [];
  int? order;
  String? ep;

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    baseDir = json['base_dir'];
    cover = json['cover'];
    dirName = json['dirName'];
    entityId = json['entityId'];
    libraryId = json['library_id'];
    order = json['order'];
    ep = json['ep'];
    if (json.containsKey("files")) {
      files = List<File>.from(
          json['files'].map((it) => File.fromJson(it)).toList());
    }
    if (json.containsKey("infos")) {
      infos = List<Meta>.from(
          json['infos'].map((it) => Meta.fromJson(it)).toList());
    }
  }

  getName() {
    return name ?? "Unknown";
  }

  getDirname() {
    return dirName ?? "Unknown";
  }
}

class VideoLoader extends ApiDataLoaderWithBaseResponse<Video> {
  @override
  Future<BaseResponse<ListResponseWrap<Video>>> fetchData(
      Map<String, String> params) {
    return ApiClient().fetchVideoList(params);
  }
}
