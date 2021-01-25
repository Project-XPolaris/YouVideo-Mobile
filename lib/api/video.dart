import 'package:youvideo/api/base.dart';
import 'package:youvideo/api/loader.dart';

import '../config.dart';
import 'client.dart';

class Video {
  int id;
  String name;
  String cover;
  String path;
  int library_id;

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    path = json['path'];
    cover = json['cover'];
    library_id = json['library_id'];
  }
  getCoverUrl(){
    if (cover != null){
      return ApplicationConfig().serviceUrl + cover;
    }
  }

  String getStreamUrl(){
    return '${ApplicationConfig.apiUrl}/video/$id/stream';
  }
}
class VideoLoader extends ApiDataLoader<Video> {
  @override
  Future<ListResponseWrap<Video>> fetchData(Map<String, String> params) {
    return ApiClient().fetchVideoList(params);
  }
}