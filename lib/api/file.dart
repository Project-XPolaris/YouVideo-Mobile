import '../config.dart';

class File {
  int id;
  String cover;
  String path;

  File.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
    cover = json['cover'];
  }
  getCoverUrl(){
    if (cover != null){
      return ApplicationConfig().serviceUrl + cover;
    }
  }

  String getStreamUrl(){
    return '${ApplicationConfig().serviceUrl}/video/file/$id/stream';
  }
}