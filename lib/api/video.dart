import 'package:youvideo/api/base.dart';
import 'package:youvideo/api/file.dart';
import 'package:youvideo/api/loader.dart';

import '../config.dart';
import 'client.dart';

class Video {
  int id;
  String name;
  String cover;
  String path;
  int library_id;
  List<File> files;

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    path = json['path'];
    cover = json['cover'];
    library_id = json['library_id'];
    if (json.containsKey("files")){
      files = List<File>.from(json['files'].map((it) => File.fromJson(it)).toList());
    }
  }
}
class VideoLoader extends ApiDataLoader<Video> {
  @override
  Future<ListResponseWrap<Video>> fetchData(Map<String, String> params) {
    return ApiClient().fetchVideoList(params);
  }
}