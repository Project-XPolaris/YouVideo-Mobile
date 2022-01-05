import 'package:youvideo/api/base.dart';
import 'package:youvideo/api/client.dart';
import 'package:youvideo/api/loader.dart';
import 'package:youvideo/api/video.dart';

class Folder {
  int? id;
  String name = "";
  List<Video> videos = [];
  String? type;
  String? cover;
  double? get coverHeight {
    if (videos.isEmpty) return null;
    return videos.first.files[0].coverHeight?.toDouble();
  }
  double? get coverWidth {
    if (videos.isEmpty) return null;
    return videos.first.files[0].coverWidth?.toDouble();
  }
  double get coverRatio {
    var width = coverWidth;
    var height = coverHeight;
    if (width == null || height == null) return 1.0;
    return coverWidth! / coverHeight!;
  }
  Folder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    List<dynamic>? rawVideos = json['videos'];
    if (rawVideos != null) {
      for (var value in rawVideos) {
        videos.add(Video.fromJson(value));
      }
    }
    if (!videos.isEmpty) {
      for (var video in videos) {
        for (var file in video.files) {
          if (file.getCoverUrl() != null) {
            cover = file.getCoverUrl();
            type = video.type;
            return;
          }
        }
      }
    }
  }
}

class FolderLoader extends ApiDataLoader<Folder> {
  @override
  Future<ListResponseWrap<Folder>> fetchData(Map<String, String> params) {
    return ApiClient().fetchFolder(params);
  }
}